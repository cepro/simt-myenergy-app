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

  SupaFlow.client.channel('public:contracts').on(
    RealtimeListenTypes.postgresChanges,
    ChannelFilter(event: 'UPDATE', schema: 'public', table: 'contracts'),
    (payload, [ref]) {
      print('public:contracts UPDATE received: ${payload.toString()}');

      Map<String, dynamic> updateMap = payload;
      if (!updateMap.containsKey('new')) {
        print('no new in payload');
        return;
      }

      Map<String, dynamic> newMap = updateMap['new'];
      if (!newMap.containsKey('id')) {
        print('no id in new');
        return;
      }

      String id = newMap['id'];
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
        id: newMap['id'],
        type: newMap['type'],
        description: newMap['description'],
        termsId: newMap['terms'],
        docusealSubmissionId: newMap['docuseal_submission_id'],
        signedContractURL: newMap['signed_contract_url'],
        signedDate: newMap['signed_date'],
        effectiveDate: newMap['effective_date'],
        endDate: newMap['end_date'],
      );
      FFAppState().addToAccounts(accountForContract);

      FFAppState().solarContractSigned = newMap['signed_date'] != null;

      print("patched contract by replacing account record");
    },
  ).subscribe();
}
