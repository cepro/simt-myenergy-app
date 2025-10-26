// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:jwt_decode/jwt_decode.dart';

Future<SupabaseUserStruct> decodeSupabaseJwt(String jwt) async {
  Map<String, dynamic> jwtMap = Jwt.parseJwt(jwt);
  return SupabaseUserStruct(
      authUserId: jwtMap["sub"],
      email: jwtMap["email"],
      phone: jwtMap["phone"],
      isCeproUser: jwtMap["app_metadata"]["cepro_user"] ?? false);
}
