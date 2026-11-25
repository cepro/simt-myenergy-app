// Refresh a contract after a `contract_signed` SSE event until its signed
// PDF URL is available.
//
// Why this exists: the `contract_signed` NOTIFY fires when the
// `update_contract_signed_status` trigger flips `contracts.signed` on the
// final signature insert. The service writes `signed_contract_url` in a
// separate, later call (straight after the signature insert for
// single-signer contracts, and on `submission.completed` for multi-party
// ones). So the SSE event often arrives with `signedContractUrl` still null,
// and nothing else pushes the URL to the app. We re-read the accounts
// response (the same `GET /account` used at login) with a short backoff
// until the URL shows up, then patch it into app state. Anything showing
// the contract (the solar modal watches app state) then switches to the
// signed PDF.

import 'dart:async';

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'active_user_token.dart';
import 'contract_signed_refresh_core.dart';

export 'contract_signed_refresh_core.dart';

/// The contract with [contractId] in [accounts], or null.
ContractStruct? findContractById(
    List<AccountStruct> accounts, String contractId) {
  if (contractId.isEmpty) return null;
  for (final account in accounts) {
    if (account.hasContract() && account.contract.id == contractId) {
      return account.contract;
    }
  }
  return null;
}

/// True when the contract is fully signed and its combined PDF is available.
bool hasSignedContractPdf(ContractStruct? contract) =>
    contract != null && contract.signedContractURL.isNotEmpty;

/// Sets [contract] on every account in [accounts] whose contract has the same
/// id. Mutates in place, like the SSE handler does; callers reassign the list
/// to persist it.
void replaceContractInAccounts(
    List<AccountStruct> accounts, ContractStruct contract) {
  for (final account in accounts) {
    if (account.hasContract() && account.contract.id == contract.id) {
      account.contract = contract;
    }
  }
}

Future<List<AccountStruct>?> _fetchAccounts() async {
  final response = await GetCustomersAccountsCall.call(
    bearerToken: await activeUserToken(),
  );
  if (!response.succeeded) return null;
  final accountsJson = getJsonField(response.jsonBody, r'''$.accounts''', true);
  if (accountsJson is! List) return null;
  return accountsJson
      .whereType<Map>()
      .map((a) => AccountStruct.fromMap(a.cast<String, dynamic>()))
      .toList();
}

/// Applies a freshly fetched, fully signed [contract] to app state.
void applySignedContractToAppState(ContractStruct contract) {
  FFAppState().update(() {
    final appState = FFAppState();
    replaceContractInAccounts(appState.accountsAll, contract);
    replaceContractInAccounts(appState.accountsForCurrentProperty, contract);
    appState.accountsAll = appState.accountsAll.toList();
    appState.accountsForCurrentProperty =
        appState.accountsForCurrentProperty.toList();

    if (contract.type == 'solar') {
      appState.solarContractSigned = true;
      if (appState.solarAccount.contract.id == contract.id) {
        appState.updateSolarAccountStruct((a) => a.contract = contract);
      }
    } else if (contract.type == 'supply') {
      appState.supplyContractSigned = true;
      if (appState.supplyAccount.contract.id == contract.id) {
        appState.updateSupplyAccountStruct((a) => a.contract = contract);
      }
    }
  });
}

final Set<String> _refreshesInFlight = {};

/// Re-reads the accounts until [contractId] has its signed PDF, then patches
/// app state. At most one refresh runs per contract.
Future<void> refreshContractUntilSignedPdf(
  String contractId, {
  Future<List<AccountStruct>?> Function()? fetchAccounts,
  List<Duration> delays = kContractSignedRefreshDelays,
}) async {
  if (contractId.isEmpty || !_refreshesInFlight.add(contractId)) return;
  try {
    final fetch = fetchAccounts ?? _fetchAccounts;
    final contract = await pollUntilFound<ContractStruct>(
      delays: delays,
      onError: (e) =>
          print('contract_signed refresh: fetch failed for $contractId: $e'),
      attempt: () async {
        final accounts = await fetch();
        if (accounts == null) return null;
        final contract = findContractById(accounts, contractId);
        return hasSignedContractPdf(contract) ? contract : null;
      },
    );
    if (contract == null) {
      print('contract_signed refresh: no signed PDF for $contractId yet; '
          'it will load on the next app start');
      return;
    }
    applySignedContractToAppState(contract);
    print('contract_signed refresh: signed PDF loaded for $contractId');
  } finally {
    _refreshesInFlight.remove(contractId);
  }
}
