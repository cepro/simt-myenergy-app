import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://rkzgrxssutcwrauaazjz.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJremdyeHNzdXRjd3JhdWFhemp6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY1MDgwNTgsImV4cCI6MTk5MjA4NDA1OH0.8DG3Bt2sfxVuB8j4diCCTtyiUJUBcYlbNTc5a7BUrTw';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
      );
}
