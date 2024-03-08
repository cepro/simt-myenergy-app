import '../database.dart';

class MeterpointsTable extends SupabaseTable<MeterpointsRow> {
  @override
  String get tableName => 'meterpoints';

  @override
  MeterpointsRow createRow(Map<String, dynamic> data) => MeterpointsRow(data);
}

class MeterpointsRow extends SupabaseDataRow {
  MeterpointsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MeterpointsTable();

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  String? get register => getField<String>('register');
  set register(String? value) => setField<String>('register', value);

  DateTime? get startDate => getField<DateTime>('start_date');
  set startDate(DateTime? value) => setField<DateTime>('start_date', value);

  DateTime? get endDate => getField<DateTime>('end_date');
  set endDate(DateTime? value) => setField<DateTime>('end_date', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get account => getField<String>('account');
  set account(String? value) => setField<String>('account', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  String? get nature => getField<String>('nature');
  set nature(String? value) => setField<String>('nature', value);
}
