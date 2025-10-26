import '../database.dart';

class PropertiesTable extends SupabaseTable<PropertiesRow> {
  @override
  String get tableName => 'properties';

  @override
  PropertiesRow createRow(Map<String, dynamic> data) => PropertiesRow(data);
}

class PropertiesRow extends SupabaseDataRow {
  PropertiesRow(super.data);

  @override
  SupabaseTable get table => PropertiesTable();

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get plot => getField<String>('plot');
  set plot(String? value) => setField<String>('plot', value);

  String? get site => getField<String>('site');
  set site(String? value) => setField<String>('site', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get solarMeter => getField<String>('solar_meter');
  set solarMeter(String? value) => setField<String>('solar_meter', value);

  String? get supplyMeter => getField<String>('supply_meter');
  set supplyMeter(String? value) => setField<String>('supply_meter', value);

  String? get owner => getField<String>('owner');
  set owner(String? value) => setField<String>('owner', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
