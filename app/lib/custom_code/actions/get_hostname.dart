// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:web/web.dart' as web;

Future<String> getHostname() async {
  Uri uri = Uri.parse(web.window.location.href);
  return uri.host;
}
