// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:url_launcher/url_launcher.dart';

Future navigateToExternalURI(String uriString) async {
  final Uri uri = Uri.parse(uriString);
  if (!await launchUrl(uri, webOnlyWindowName: "_self")) {
    throw Exception('Could not launch $uri');
  }
}
