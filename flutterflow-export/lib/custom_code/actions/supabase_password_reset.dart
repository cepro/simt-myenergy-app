// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:html';

Future<bool> supabasePasswordReset(String email) async {
  Uri uri = Uri.parse(window.location.href);
  await SupaFlow.client.auth
      // relative work here?  if not how to gt the domain. available or inject it as per sysinfo page ...
      .resetPasswordForEmail(email,
          redirectTo: "https://" + uri.host + "/resetPassword");
  return true;
}
