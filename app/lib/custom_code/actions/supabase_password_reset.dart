// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> supabasePasswordReset(String email, String hostname) async {
  await SupaFlow.client.auth.resetPasswordForEmail(email,
      redirectTo: "https://$hostname/resetPassword");
  return true;
}
