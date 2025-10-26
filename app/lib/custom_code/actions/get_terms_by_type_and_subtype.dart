// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<ContractTermsStruct?> getTermsByTypeAndSubtype(
  List<ContractTermsStruct> termsList,
  String termsType,
  String? termsSubtype,
) async {
  ContractTermsStruct? terms = termsList.firstWhere(
      (terms) =>
          terms.type == termsType &&
          (terms.subtype == termsSubtype ||
              // expand null checks out because comparing the 2 with other will return false even when both are null
              (!terms.hasSubtype() && termsSubtype == null)),
      orElse: () => ContractTermsStruct());
  return terms.hasId() ? terms : null;
}
