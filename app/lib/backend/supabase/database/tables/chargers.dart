import '../database.dart';

class ChargersTable extends SupabaseTable<ChargersRow> {
  @override
  String get tableName => 'chargers';

  @override
  ChargersRow createRow(Map<String, dynamic> data) => ChargersRow(data);
}

class ChargersRow extends SupabaseDataRow {
  ChargersRow(super.data);

  @override
  SupabaseTable get table => ChargersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get site => getField<String>('site')!;
  set site(String value) => setField<String>('site', value);

  String get serial => getField<String>('serial')!;
  set serial(String value) => setField<String>('serial', value);

  String get pin => getField<String>('pin')!;
  set pin(String value) => setField<String>('pin', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);
}
