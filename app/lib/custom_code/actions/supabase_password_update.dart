// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future<bool> supabasePasswordUpdate(String newPassword) async {
  UserResponse userResponse = await SupaFlow.client.auth
      .updateUser(UserAttributes(password: newPassword));
  return (userResponse.user != null) ? true : false;
}
