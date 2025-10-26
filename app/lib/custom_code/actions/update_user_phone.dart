// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<CustomActionResultStruct> updateUserPhone(String phone) async {
  final supabase = Supabase.instance.client;
  final UserResponse res;
  try {
    res = await supabase.auth.updateUser(
      UserAttributes(
        phone: phone,
      ),
    );
    final User? updatedUser = res.user;
    print(updatedUser);
    //if (updatedUser?.new_phone == phone) {
    return CustomActionResultStruct(success: true, errorMessage: "");
  } on AuthException catch (e) {
    print("ERROR: $e");
    return CustomActionResultStruct(success: false, errorMessage: e.message);
  }
}
