// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/events/contract_events_client.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Replaces the previous Supabase Realtime path
// (`init_supabase_realtime_subscriptions.dart`). Same downstream effect
// on `FFAppState()`, but driven by SSE from the accounts service
// (`/contracts/events`) instead of `postgres_changes` channels on
// `public:contracts` / `public:customers`. See
// specs/contract-events-sse.md for the wire protocol.
void updateAccountListWithNewContract(
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
    print("no account found for contract ${newRec['id']} (accountId=$accountId)");
    return;
  }

  // Build the new contract from the camelCase SSE payload. signedDate is
  // intentionally absent — post-migration 0022 it lives in
  // `contract_signatures` per-customer, not on the contract.
  final updatedContract = ContractStruct(
    id: newRec['id'],
    type: newRec['type'],
    termsId: newRec['terms'],
    docusealSubmissionId: newRec['docusealSubmissionId'],
    signedContractURL: newRec['signedContractUrl'],
    effectiveDate: newRec['effectiveDate'],
    endDate: newRec['endDate'],
  );

  // Replace the account in place; copy the other fields through unchanged.
  final updatedAccount = AccountStruct(
    id: accountForContract.id,
    contract: updatedContract,
    name: accountForContract.name,
  );

  final index = accounts.indexOf(accountForContract);
  if (index != -1) {
    accounts[index] = updatedAccount;
  }
}

Future initContractEventsSubscription() async {
  final events = ContractEventsClient();
  await events.connect();

  events.contractSigned.listen((newRec) {
    // Same state updates as the old Supabase Realtime path — but now
    // keyed off the post-migration `signed` boolean, not the dropped
    // `signed_date`.
    updateAccountListWithNewContract(FFAppState().accountsAll, newRec);
    updateAccountListWithNewContract(
        FFAppState().accountsForCurrentProperty, newRec);

    final type = newRec['type'];
    final signed = newRec['signed'] == true;
    if (type == 'solar') {
      FFAppState().solarContractSigned = signed;
    } else if (type == 'supply') {
      FFAppState().supplyContractSigned = signed;
    }

    print("patched contract by replacing account records in both lists");
  });

  events.customerUpdated.listen((newRec) {
    // Mirrors the old public:customers Realtime handler. Any field that
    // is absent from the payload (null on the wire, dropped by
    // @JsonInclude(NON_NULL)) is left as-is on FFAppState().customer.
    FFAppState().updateCustomerStruct((c) {
      if (newRec.containsKey('status')) c.status = newRec['status'];
      if (newRec.containsKey('hasPaymentMethod')) {
        c.hasPaymentMethod = newRec['hasPaymentMethod'];
      }
      if (newRec.containsKey('allowOnboardTransition')) {
        c.allowOnboardTransition = newRec['allowOnboardTransition'];
      }
    });

    print("patched customer record: ${FFAppState().customer}");
  });
}