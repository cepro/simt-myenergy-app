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

Future<List<ContractTermsStruct>> contractTermsJSONToContractTermsDataType(
    List<dynamic> contractTermsJSON) async {
  List<ContractTermsStruct> termsList = [];

  for (var terms in contractTermsJSON) {
    termsList.add(ContractTermsStruct.fromMap(terms));
  }

  return termsList;
}
