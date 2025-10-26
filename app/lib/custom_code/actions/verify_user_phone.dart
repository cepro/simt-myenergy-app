// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<CustomActionResultStruct> verifyUserPhone(
    final String phone, final String otp) async {
  final supabase = Supabase.instance.client;
  final AuthResponse res;
  try {
    res = await supabase.auth.verifyOTP(
      token: otp,
      type: OtpType.phoneChange,
      phone: phone,
    );
    print(res);
    return CustomActionResultStruct(success: true, errorMessage: "");
  } on AuthException catch (e) {
    print("ERROR: $e");
    return CustomActionResultStruct(success: false, errorMessage: e.message);
  }
}
