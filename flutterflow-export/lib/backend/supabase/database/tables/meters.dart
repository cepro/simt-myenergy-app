import '../database.dart';

class MetersTable extends SupabaseTable<MetersRow> {
  @override
  String get tableName => 'meters';

  @override
  MetersRow createRow(Map<String, dynamic> data) => MetersRow(data);
}

class MetersRow extends SupabaseDataRow {
  MetersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MetersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get serial => getField<String>('serial');
  set serial(String? value) => setField<String>('serial', value);

  String? get wallet => getField<String>('wallet');
  set wallet(String? value) => setField<String>('wallet', value);

  String? get registerA => getField<String>('register_a');
  set registerA(String? value) => setField<String>('register_a', value);

  String? get registerB => getField<String>('register_b');
  set registerB(String? value) => setField<String>('register_b', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  bool? get prepayEnabled => getField<bool>('prepay_enabled');
  set prepayEnabled(bool? value) => setField<bool>('prepay_enabled', value);

  double? get balance => getField<double>('balance');
  set balance(double? value) => setField<double>('balance', value);
}
