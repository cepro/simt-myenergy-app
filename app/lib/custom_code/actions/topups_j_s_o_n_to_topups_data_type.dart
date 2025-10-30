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
        acquiredAt: topup['acquiredAt'] != null ? DateTime.parse(topup['acquiredAt']) : null,
        usedAt: topup['usedAt'] != null ? DateTime.parse(topup['usedAt']) : null,
        createdAt: topup['createdAt'] != null ? DateTime.parse(topup['createdAt']) : null,
        updatedAt: topup['updatedAt'] != null ? DateTime.parse(topup['updatedAt']) : null));
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
