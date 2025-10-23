import 'app_config.dart';

class ProdConfig extends AppConfig {
  ProdConfig() : super('prod');

  @override
  String get myenergyServiceURI => "https://simt-j-accounts-mgf.fly.dev";

  @override
  String get supabaseURI => "https://supabase-kong-mgf.fly.dev";

  @override
  String get supabaseAnonKey => "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE4NDA4Nzk5NDUsImlhdCI6MTc1NTA5MDkwNiwiaXNzIjoic3VwYWJhc2UiLCJyb2xlIjoiYW5vbiJ9.MA8tojsiizRZ4uPDgJAC2znkLNk4j_20wzZofpx-cQc";
}