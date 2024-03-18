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

Future<List<MonthlyUsageStruct>> monthlyUsageJSONToDataType(
    dynamic usageJSON) async {
  List<MonthlyUsageStruct> usages = [];

  Map<String, dynamic> usageMap = usageJSON as Map<String, dynamic>;
  usageMap.forEach((key, usageRec) {
    DateTime month = DateTime.parse(key);
    DateFormat dateFormatter = DateFormat('MMMM y');
    String monthStr = dateFormatter.format(month);
    usages.add(MonthlyUsageStruct(
      usageHeat: usageRec['usageHeat'],
      usagePower: usageRec['usagePower'],
      month: monthStr,
    ));
  });

  return usages;
}
