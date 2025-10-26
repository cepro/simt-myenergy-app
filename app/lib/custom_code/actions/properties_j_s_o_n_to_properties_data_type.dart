// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<PropertyStruct>> propertiesJSONToPropertiesDataType(
    List<dynamic> propertiesJSON) async {
  List<PropertyStruct> properties = [];

  for (var property in propertiesJSON) {
    properties.add(PropertyStruct.fromMap(property));
  }

  // sort by address (description) ascending
  properties.sort((a, b) => a.plot.compareTo(b.plot));

  return properties;
}
