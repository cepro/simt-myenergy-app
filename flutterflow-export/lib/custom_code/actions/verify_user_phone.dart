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
    print("ERROR: ");
    print(e);
    return CustomActionResultStruct(success: false, errorMessage: e.message);
  }
}
