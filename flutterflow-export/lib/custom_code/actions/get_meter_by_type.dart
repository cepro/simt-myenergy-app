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

Future<MeterStruct?> getMeterByType(
  List<AccountStruct> accounts,
  String meterType,
  dynamic metersJSON,
) async {
  AccountStruct? account = accounts.firstWhere(
      (account) => account.contract.type == meterType,
      orElse: () => new AccountStruct());
  String? meterId = meterType == 'solar'
      ? account.property.solarMeterUUID
      : account.property.supplyMeterUUID;
  if (meterId == null) {
    return null;
  }

  var meter = null;
  var meterResult = getJsonField(metersJSON, "\$['$meterId']", false);
  if (meterResult != null) {
    meter = meterResult;
  }

  return meter;
}
