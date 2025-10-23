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

import 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js_interop';

Future clearWebCache() async {
  if (!kIsWeb) {
    print("clearWebCache skipping on non web platform");
    return;
  }

  try {
    print(web.window.caches);
  } catch (e) {
    print("caches does not exist yet - returning");
    return null;
  }

  // Get all cache keys
  final JSPromise<JSArray<JSString>> keysPromise = web.window.caches.keys();
  final List<JSString> cacheKeysJSStrings = (await keysPromise.toDart).toDart;
  final List<String> cacheKeys = [
    for (final jsString in cacheKeysJSStrings) jsString.toDart
  ];
  print("cacheKeys = [$cacheKeys]");

  try {
    // Delete each cache
    await Future.wait(
        cacheKeys.map((key) => web.window.caches.delete(key).toDart));
    print('Cache cleared successfully');
  } catch (e) {
    print('Error clearing cache: $e');
    print(e);
  }
}
