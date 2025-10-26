// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:html';

Future<String> getHostname() async {
  Uri uri = Uri.parse(window.location.href);
  return uri.host;
}
