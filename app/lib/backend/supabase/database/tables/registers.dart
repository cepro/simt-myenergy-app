import '../database.dart';

class RegistersTable extends SupabaseTable<RegistersRow> {
  @override
  String get tableName => 'registers';

  @override
  RegistersRow createRow(Map<String, dynamic> data) => RegistersRow(data);
}

class RegistersRow extends SupabaseDataRow {
  RegistersRow(super.data);

  @override
  SupabaseTable get table => RegistersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  double? get importRead => getField<double>('import_read');
  set importRead(double? value) => setField<double>('import_read', value);

  double? get exportRead => getField<double>('export_read');
  set exportRead(double? value) => setField<double>('export_read', value);

  bool get directionReversed => getField<bool>('direction_reversed')!;
  set directionReversed(bool value) =>
      setField<bool>('direction_reversed', value);

  String? get meter => getField<String>('meter');
  set meter(String? value) => setField<String>('meter', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
