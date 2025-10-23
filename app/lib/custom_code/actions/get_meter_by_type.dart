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

Future<MeterStruct?> getMeterByType(
  PropertyStruct property,
  String meterType,
  dynamic metersJSON,
) async {
  String? meterId =
      meterType == 'solar' ? property.solarMeterUUID : property.supplyMeterUUID;
  if (meterId == null) {
    return null;
  }

  var meter = null;
  var meterResult = getJsonField(metersJSON, "\$['$meterId']", false);
  if (meterResult != null) {
    meter = MeterStruct.fromMap(meterResult);
  }

  return meter;
}
