// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<CustomActionResultStruct> updateUserEmail(String email) async {
  final supabase = Supabase.instance.client;
  final UserResponse res;
  try {
    res = await supabase.auth.updateUser(
      UserAttributes(
        email: email,
      ),
    );
    final User? updatedUser = res.user;
    print(updatedUser);
    return CustomActionResultStruct(success: true, errorMessage: "");
  } on AuthException catch (e) {
    print("ERROR: $e");
    return CustomActionResultStruct(success: false, errorMessage: e.message);
  }
}
