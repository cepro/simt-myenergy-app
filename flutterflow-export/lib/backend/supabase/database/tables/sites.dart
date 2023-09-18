import '../database.dart';

class SitesTable extends SupabaseTable<SitesRow> {
  @override
  String get tableName => 'sites';

  @override
  SitesRow createRow(Map<String, dynamic> data) => SitesRow(data);
}

class SitesRow extends SupabaseDataRow {
  SitesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SitesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);
}
