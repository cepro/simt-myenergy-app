// Pure handlers for the contract-events SSE stream. Kept in their own
// file (no SSE/wiring imports) so they can be tested directly without
// pulling in the launchdarkly_event_source_client transitive deps.
//
// `initSseEventsSubscription` (in
// `init_sse_events_subscription.dart`) wires these up to the
// `contractSigned` and `customerUpdated` broadcast streams exposed by
// `SseEventsClient`.

// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Replaces the previous Supabase Realtime path
// (`init_supabase_realtime_subscriptions.dart`). Same downstream effect
// on `FFAppState()`, but driven by SSE from the accounts service
// (`/events/stream`) instead of `postgres_changes` channels on
// `public:contracts` / `public:customers`. See
// specs/sse-events.md for the wire protocol.
AccountStruct? updateAccountListWithNewContract(
    List<AccountStruct> accounts, Map<String, dynamic> newRec) {
  // Find the account via the accountId the backend now sends, not via
  // contract.id scan. Falls back to the old scan if accountId is absent
  // (e.g. replayed events from before this PR shipped).
  AccountStruct? accountForContract;
  final accountId = newRec['accountId'] as String?;
  if (accountId != null) {
    try {
      accountForContract = accounts.firstWhere((a) => a.id == accountId);
    } catch (_) {
      accountForContract = null;
    }
  }
  accountForContract ??= () {
    try {
      return accounts.firstWhere((a) => a.contract.id == newRec['id']);
    } catch (_) {
      return null;
    }
  }();

  if (accountForContract == null) {
    print(
        "no account found for contract ${newRec['id']} (accountId=$accountId)");
    return null;
  }

  // Build the new contract from the camelCase SSE payload. signedDate is
  // intentionally absent — post-migration 0022 it lives in
  // `contract_signatures` per-customer, not on the contract. signaturesRequired
  // is optional in the SSE payload (older events may not include it) and
  // defaults to null on the struct (= 1 via the getter).
  final updatedContract = ContractStruct(
    id: newRec['id'],
    type: newRec['type'],
    termsId: newRec['terms'],
    docusealSubmissionId: newRec['docusealSubmissionId'],
    signedContractURL: newRec['signedContractUrl'],
    effectiveDate: newRec['effectiveDate'],
    endDate: newRec['endDate'],
    signaturesRequired: newRec['signaturesRequired'] is int
        ? newRec['signaturesRequired'] as int
        : null,
  );

  final index = accounts.indexOf(accountForContract);
  if (index != -1) {
    accountForContract.contract = updatedContract;
    accounts[index] = accountForContract;
    return accountForContract;
  }

  return null;
}

// Handler for `contract_signed` SSE messages. Same state updates as the
// old Supabase Realtime path — but now keyed off the post-migration
// `signed` boolean, not the dropped `signed_date`.
void handleContractSignedEvent(Map<String, dynamic> newRec) {
  FFAppState().update(() {
    final appState = FFAppState();
    final updatedAll =
        updateAccountListWithNewContract(appState.accountsAll, newRec);
    final updatedCurrent = updateAccountListWithNewContract(
        appState.accountsForCurrentProperty, newRec);

    // Persist the mutated lists. FlutterFlow list getters return the backing
    // list, so direct element replacement above does not hit the generated
    // setters unless we reassign.
    appState.accountsAll = appState.accountsAll.toList();
    appState.accountsForCurrentProperty =
        appState.accountsForCurrentProperty.toList();

    final type = newRec['type'];
    final signed = newRec['signed'] == true;
    final updatedAccount = updatedCurrent ?? updatedAll;
    if (type == 'solar') {
      appState.solarContractSigned = signed;
      if (updatedAccount != null &&
          (appState.solarAccount.id == updatedAccount.id ||
              appState.solarAccount.id.isEmpty)) {
        appState.solarAccount = updatedAccount;
      }
    } else if (type == 'supply') {
      appState.supplyContractSigned = signed;
      if (updatedAccount != null &&
          (appState.supplyAccount.id == updatedAccount.id ||
              appState.supplyAccount.id.isEmpty)) {
        appState.supplyAccount = updatedAccount;
      }
    }
  });

  print("patched contract by replacing account records in both lists");
}

// Handler for `customer_updated` SSE messages. Mirrors the old
// public:customers Realtime handler. Any field that is absent from the
// payload (null on the wire, dropped by @JsonInclude(NON_NULL)) is
// left as-is on FFAppState().customer.
void handleCustomerUpdatedEvent(Map<String, dynamic> newRec) {
  FFAppState().update(() {
    FFAppState().updateCustomerStruct((c) {
      if (newRec.containsKey('status')) c.status = newRec['status'];
      if (newRec.containsKey('hasPaymentMethod')) {
        c.hasPaymentMethod = newRec['hasPaymentMethod'];
      }
      if (newRec.containsKey('allowOnboardTransition')) {
        c.allowOnboardTransition = newRec['allowOnboardTransition'];
      }
    });
  });

  print("patched customer record: ${FFAppState().customer}");
}
