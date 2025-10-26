// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<AccountStruct>> accountsJSONToAccountsDataType(
    List<dynamic> accountsJSON) async {
  List<AccountStruct> accounts = [];

  for (var account in accountsJSON) {
    accounts.add(AccountStruct.fromMap(account));
  }

  return accounts;
}
