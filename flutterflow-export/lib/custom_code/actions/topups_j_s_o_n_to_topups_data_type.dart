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

Future<List<TopupStruct>> topupsJSONToTopupsDataType(
    List<dynamic> topupsJSON) async {
  List<TopupStruct> topups = [];

  for (var topup in topupsJSON) {
    topups.add(TopupStruct(
        amountPence: topup['amountPence'],
        status: topup['status'],
        source: topup['source'],
        notes: topup['notes'],
        createdAt: DateTime.parse(topup['createdAt']),
        updatedAt: DateTime.parse(topup['updatedAt'])));
  }

  // reverse date order (ie. latest date first)
  topups.sort((a, b) {
    if (a.createdAt == null && b.createdAt == null) {
      return 0;
    }
    if (a.createdAt == null) {
      return 1;
    }
    if (b.createdAt == null) {
      return -1;
    }
    return b.createdAt!.compareTo(a.createdAt!);
  });

  return topups;
}
