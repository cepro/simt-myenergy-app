abstract class AppConfig {
  // --dart-define ENV
  final String env;

  AppConfig(this.env);

  // --dart-define GIT_COMMIT
  String get gitCommit =>
      const String.fromEnvironment('GIT_COMMIT', defaultValue: 'unknown');

  // --dart-define BUILD_FLUTTER_VERSION
  String get flutterVersion =>
      const String.fromEnvironment('BUILD_FLUTTER_VERSION', defaultValue: 'unknown');

  // see simt-j-accounts-service - the myenergy / accounts service
  String get myenergyServiceURI;

  // self hosted supabase
  String get supabaseURI;
  String get supabaseAnonKey;
}
