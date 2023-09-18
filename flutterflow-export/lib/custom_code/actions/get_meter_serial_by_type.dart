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

Future<String?> getMeterSerialByType(
  List<dynamic> accountsJSON,
  String meterType,
  dynamic meterSerialsJSON,
) async {
  try {
    var meterIdResult = getJsonField(
        accountsJSON,
        r'$[?(@.contract.terms.type=="'
        "$meterType\")].property.${meterType}MeterUUID",
        true);
    var meterId = meterIdResult.isNotEmpty ? meterIdResult[0].toString() : null;
    var meterSerial = null;
    if (meterId != null) {
      var meterSerialResult =
          getJsonField(meterSerialsJSON, "\$['$meterId']", false);
      if (meterSerialResult.isNotEmpty) {
        meterSerial = meterSerialResult;
      }
    }
    return meterSerial;
  } catch (e, s) {
    print('Exception details:\n\n$e\n');
    print('Stack trace:\n\n$s');
    return null;
  }
}
