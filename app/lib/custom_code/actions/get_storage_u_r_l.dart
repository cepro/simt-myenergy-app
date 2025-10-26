// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String> getStorageURL(
  String bucketName,
  String filePath,
) async {
  return 'https://$bucketName.t3.storage.dev/$filePath';
}
