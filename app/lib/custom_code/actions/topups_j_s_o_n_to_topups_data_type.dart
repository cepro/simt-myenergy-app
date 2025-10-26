// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
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
        referenceStr: topup['reference'],
        acquiredAt: DateTime.parse(topup['acquiredAt']),
        usedAt: DateTime.parse(topup['usedAt']),
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
