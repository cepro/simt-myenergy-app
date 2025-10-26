// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<MonthlyUsageStruct>> monthlyUsageJSONToDataType(
    dynamic usageJSON) async {
  List<MonthlyUsageStruct> usages = [];

  DateFormat dateFormatter = DateFormat('MMMM y');

  Map<String, dynamic> usageMap = usageJSON as Map<String, dynamic>;
  usageMap.forEach((key, usageRec) {
    DateTime month = DateTime.parse(key);
    String monthStr = dateFormatter.format(month);
    usages.add(MonthlyUsageStruct(
      usageHeat: usageRec['usageHeat'],
      usagePower: usageRec['usagePower'],
      month: monthStr,
    ));
  });

  return usages;
}
