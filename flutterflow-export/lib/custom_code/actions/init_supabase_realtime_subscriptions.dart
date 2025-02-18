// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

void updateAccountListWithNewContract(
    List<AccountStruct> accounts, Map<String, dynamic> newRec) {
  AccountStruct? accountForContract;
  try {
    accountForContract =
        accounts.firstWhere((element) => element.contract.id == newRec['id']);

    // Create new contract struct
    final updatedContract = ContractStruct(
      id: newRec['id'],
      type: newRec['type'],
      description: newRec['description'],
      termsId: newRec['terms'],
      docusealSubmissionId: newRec['docuseal_submission_id'],
      signedContractURL: newRec['signed_contract_url'],
      signedDate: newRec['signed_date'],
      effectiveDate: newRec['effective_date'],
      endDate: newRec['end_date'],
    );

    // Create new account struct with updated contract
    final updatedAccount = AccountStruct(
      id: accountForContract.id,
      contract: updatedContract,
      // Copy all other fields from the original account
      name: accountForContract.name,
      // Add any other fields that AccountStruct has
    );

    // Remove old account and add updated one
    final index = accounts.indexOf(accountForContract);
    if (index != -1) {
      accounts[index] = updatedAccount;
    }
  } catch (e) {
    print("exception finding match in account list: $e");
  }
}

Future initSupabaseRealtimeSubscriptions() async {
  await SupaFlow.client.removeAllChannels();

  SupaFlow.client
      .channel('public:contracts')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'contracts',
        callback: (payload) {
          print('public:contracts UPDATE received: ${payload.toString()}');

          Map<String, dynamic> newRec = payload.newRecord;
          if (!newRec.containsKey('id')) {
            print('no id in new record');
            return;
          }

          // Update both account lists
          updateAccountListWithNewContract(FFAppState().accountsAll, newRec);
          updateAccountListWithNewContract(
              FFAppState().accountsForCurrentProperty, newRec);

          bool contractSigned = newRec['signed_date'] != null;
          if (newRec['type'] == 'solar') {
            FFAppState().solarContractSigned = contractSigned;
          } else if (newRec['type'] == 'supply') {
            FFAppState().supplyContractSigned = contractSigned;
          }

          print("patched contract by replacing account records in both lists");
        },
      )
      .subscribe();

  SupaFlow.client
      .channel('public:customers')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'customers',
        callback: (payload) {
          print('public:customers UPDATE received: ${payload.toString()}');

          Map<String, dynamic> newRec = payload.newRecord;
          CustomerStruct customer = FFAppState().customer;
          print("app state customer current: ${customer}");

          FFAppState().updateCustomerStruct((c) {
            c.status = newRec['status'];
            c.hasPaymentMethod = newRec['has_payment_method'];
            c.allowOnboardTransition = newRec['allow_onboard_transition'];
          });

          print("app state customer updated: ${FFAppState().customer}");
        },
      )
      .subscribe();
}
