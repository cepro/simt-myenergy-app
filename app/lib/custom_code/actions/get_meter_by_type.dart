// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<MeterStruct?> getMeterByType(
  PropertyStruct property,
  String meterType,
  dynamic metersJSON,
) async {
  String? meterId =
      meterType == 'solar' ? property.solarMeterUUID : property.supplyMeterUUID;

  MeterStruct meter;
  var meterResult = getJsonField(metersJSON, "\$['$meterId']", false);
  if (meterResult != null) {
    meter = MeterStruct.fromMap(meterResult);
  }

  return meter;
}
