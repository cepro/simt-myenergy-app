// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/auth/supabase_auth/auth_util.dart';

Future<String> activeUserToken() async {
  return FFAppState().impersonationToken != ''
      ? FFAppState().impersonationToken
      : currentJwtToken;
}
