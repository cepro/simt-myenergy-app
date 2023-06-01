import '../database.dart';

class PropertiesTable extends SupabaseTable<PropertiesRow> {
  @override
  String get tableName => 'properties';

  @override
  PropertiesRow createRow(Map<String, dynamic> data) => PropertiesRow(data);
}

class PropertiesRow extends SupabaseDataRow {
  PropertiesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PropertiesTable();

  String get propertyId => getField<String>('property_id')!;
  set propertyId(String value) => setField<String>('property_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get plot => getField<String>('plot');
  set plot(String? value) => setField<String>('plot', value);

  String? get site => getField<String>('site');
  set site(String? value) => setField<String>('site', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);
}
