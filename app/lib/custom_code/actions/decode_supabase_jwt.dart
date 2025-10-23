// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
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
