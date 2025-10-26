// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<ContractTermsStruct>> contractTermsJSONToContractTermsDataType(
    List<dynamic> contractTermsJSON) async {
  List<ContractTermsStruct> termsList = [];

  for (var terms in contractTermsJSON) {
    termsList.add(ContractTermsStruct.fromMap(terms));
  }

  return termsList;
}
