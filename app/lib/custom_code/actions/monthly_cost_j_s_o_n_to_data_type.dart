// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<MonthlyCostStruct>> monthlyCostJSONToDataType(
    dynamic costJSON) async {
  List<MonthlyCostStruct> costs = [];

  DateFormat dateFormatter = DateFormat('MMMM y');

  Map<String, dynamic> costMap = costJSON as Map<String, dynamic>;
  costMap.forEach((key, costRec) {
    DateTime month = DateTime.parse(key);
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
