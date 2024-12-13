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

          String id = newRec['id'];
          AccountStruct accountForContract;
          try {
            accountForContract = FFAppState()
                .accounts
                .firstWhere((element) => element.contract.id == id);
          } catch (e) {
            print("exception finding match");
            return;
          }
          print("found account for contract: ${accountForContract}");

          FFAppState().removeFromAccounts(accountForContract);

          // replace the contract in appstate with the updated one:
          accountForContract.contract = ContractStruct(
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
          FFAppState().addToAccounts(accountForContract);

          bool contractSigned = newRec['signed_date'] != null;
          if (newRec['type'] == 'solar') {
            FFAppState().solarContractSigned = contractSigned;
          } else if (newRec['type'] == 'supply') {
            FFAppState().supplyContractSigned = contractSigned;
          }

          print("patched contract by replacing account record");
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
            c.hasPaymentMethod = newRec['has_payment_method'];
            c.allowOnboardTransition = newRec['allow_onboard_transition'];
          });

          print("app state customer updated: ${FFAppState().customer}");
        },
      )
      .subscribe();
}
