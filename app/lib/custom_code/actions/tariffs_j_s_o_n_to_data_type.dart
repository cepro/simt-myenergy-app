// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<TariffsStruct> tariffsJSONToDataType(dynamic tariffsJSON) async {
  Map<String, dynamic> tariffsMap = tariffsJSON as Map<String, dynamic>;

  List<SupplyTariffStruct> benchmarkTariffs = [];

  tariffsMap["benchmarkTariffs"].forEach((tariffRec) {
    benchmarkTariffs.add(SupplyTariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  List<SupplyTariffStruct> microgridTariffs = [];
  tariffsMap["microgridTariffs"].forEach((tariffRec) {
    microgridTariffs.add(SupplyTariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  List<SupplyTariffStruct> customerTariffs = [];
  tariffsMap["customerTariffs"].forEach((tariffRec) {
    customerTariffs.add(SupplyTariffStruct(
      unitRate: tariffRec['unitRate'],
      standingCharge: tariffRec['standingCharge'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  List<SolarCreditTariffStruct> solarCreditTariffs = [];
  tariffsMap["solarCreditTariffs"].forEach((tariffRec) {
    solarCreditTariffs.add(SolarCreditTariffStruct(
      creditPencePerYear: tariffRec['creditPencePerYear'],
      periodStart: DateTime.parse(tariffRec["periodStart"]),
    ));
  });

  return TariffsStruct(
      benchmarkTariffs: benchmarkTariffs,
      microgridTariffs: microgridTariffs,
      customerTariffs: customerTariffs,
      solarCreditTariffs: solarCreditTariffs);
}
