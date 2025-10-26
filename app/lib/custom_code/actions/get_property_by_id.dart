// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<PropertyStruct?> getPropertyById(
  List<PropertyStruct> properties,
  String propertyId,
) async {
  PropertyStruct? property = properties.firstWhere((p) => p.id == propertyId,
      orElse: () => PropertyStruct());
  return property.hasId() ? property : null;
  // Add your function code here!
}
