// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> getTermsFromLatestTermsJSON(
  List<dynamic> terms,
  String termsType,
  String? termsSubtype,
) async {
  try {
    String subtypeValueOrNull =
        termsSubtype == null ? 'null' : '"' + termsSubtype + '"';

    // wrap in a try because the json path expression will throw
    // a RangeError when there are no unsigned contracts.
    // in this case we just want to return null to denote none are
    // there.
    List<dynamic> result = getJsonField(
        terms,
        r'$[?(@.type=="' +
            termsType +
            r'" && @.subtype==' +
            subtypeValueOrNull +
            r')]',
        true);
    return (result.length > 0) ? result[0] : null;
  } catch (_) {
    return null;
  }
}
