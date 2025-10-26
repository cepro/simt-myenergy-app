// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<SolarInstallationStruct?> getSolarInstallationById(
    dynamic solarInstallationJSON, String? id) async {
  SolarInstallationStruct solar;

  var solarResult = getJsonField(solarInstallationJSON, "\$['$id']", false);
  if (solarResult != null) {
    Map<String, dynamic> solarMap = solarResult as Map<String, dynamic>;
    DateTime commissioningDate = DateTime.parse(solarMap["commissioningDate"]);
    solar = SolarInstallationStruct(
        property: solarMap["property"],
        mcs: solarMap["mcs"],
        declaredNetCapacity: solarMap["declaredNetCapacity"],
        commissioningDate: commissioningDate);
  }

  return solar;
}
