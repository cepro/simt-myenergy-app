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

Future<List<MonthlyCostStruct>> monthlyCostJSONToDataType(
    dynamic costJSON) async {
  List<MonthlyCostStruct> costs = [];

  Map<String, dynamic> costMap = costJSON as Map<String, dynamic>;
  costMap.forEach((key, costRec) {
    DateTime month = DateTime.parse(key);
    DateFormat dateFormatter = DateFormat('MMMM y');
    String monthStr = dateFormatter.format(month);
    costs.add(MonthlyCostStruct(
      month: monthStr,
      monthTyped: month,

      // actual costs (customer_tariffs)
      heat: costRec['heat'],
      power: costRec['power'],
      standingCharge: costRec['standingCharge'],
      total: costRec['total'],

      // microgrid costs (microgrid_tariffs)
      microgridHeat: costRec['microgridHeat'],
      microgridPower: costRec['microgridPower'],
      microgridStandingCharge: costRec['microgridStandingCharge'],
      microgridTotal: costRec['microgridTotal'],

      // benchmark costs (benchmark_tariffs)
      benchmarkHeat: costRec['benchmarkHeat'],
      benchmarkPower: costRec['benchmarkPower'],
      benchmarkStandingCharge: costRec['benchmarkStandingCharge'],
      benchmarkTotal: costRec['benchmarkTotal'],
    ));
  });

  return costs;
}
