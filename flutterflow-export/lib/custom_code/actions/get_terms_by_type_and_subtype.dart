// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<ContractTermsStruct?> getTermsByTypeAndSubtype(
  List<ContractTermsStruct> termsList,
  String termsType,
  String? termsSubtype,
) async {
  ContractTermsStruct? terms = termsList.firstWhere(
      (terms) => terms.type == termsType && terms.subtype == termsSubtype,
      orElse: () => new ContractTermsStruct());
  return terms.hasId() ? terms : null;
}
