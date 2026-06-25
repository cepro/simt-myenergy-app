// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Uses `Uri.base` (a Dart core library) instead of `package:web` so this
// file can be compiled on the VM (used by `flutter test` for unit tests)
// without dragging in `dart:js_interop`. On web, `Uri.base.host` is the
// same value as `window.location.hostname`. See
// specs/web-pgk-issue.md for context.
Future<String> getHostname() async {
  return Uri.base.host;
}
