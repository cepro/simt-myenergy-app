// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<CustomerStruct> customerJSONToDataType(dynamic customerJSON) async {
  String? confirmAtStr = customerJSON['confirmedDetailsAt'];
  DateTime? confirmAtDateTime =
      confirmAtStr != null ? DateTime.parse(confirmAtStr) : null;
  return CustomerStruct(
      id: customerJSON['id'],
      name: customerJSON['name'],
      status: customerJSON['status'],
      hasPaymentMethod: customerJSON['hasPaymentMethod'],
      allowOnboardTransition: customerJSON['allowOnboardTransition'],
      exiting: customerJSON['exiting'],
      confirmedDetailsAt: confirmAtDateTime);
}
