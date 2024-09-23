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

Future<TariffsStruct> tariffsJSONToDataType(dynamic tariffsJSON) async {
  Map<String, dynamic> tariffsMap = tariffsJSON as Map<String, dynamic>;

  List<TariffStruct> benchmarkTariffs = [];

  tariffsMap["benchmarkTariffs"].forEach((tariffRec) {
    benchmarkTariffs.add(TariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  List<TariffStruct> microgridTariffs = [];
  tariffsMap["microgridTariffs"].forEach((tariffRec) {
    microgridTariffs.add(TariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  List<TariffStruct> customerTariffs = [];
  tariffsMap["customerTariffs"].forEach((tariffRec) {
    customerTariffs.add(TariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  return TariffsStruct(
      benchmarkTariffs: benchmarkTariffs,
      microgridTariffs: microgridTariffs,
      customerTariffs: customerTariffs);
}
