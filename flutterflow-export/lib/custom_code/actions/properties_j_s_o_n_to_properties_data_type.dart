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

Future<List<PropertyStruct>> propertiesJSONToPropertiesDataType(
    List<dynamic> propertiesJSON) async {
  List<PropertyStruct> properties = [];

  for (var property in propertiesJSON) {
    properties.add(PropertyStruct.fromMap(property));
  }

  // sort by address (description) ascending
  properties.sort((a, b) => a.plot!.compareTo(b.plot!));

  return properties;
}
