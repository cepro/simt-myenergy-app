import '../database.dart';

class NestedTable extends SupabaseTable<NestedRow> {
  @override
  String get tableName => 'nested';

  @override
  NestedRow createRow(Map<String, dynamic> data) => NestedRow(data);
}

class NestedRow extends SupabaseDataRow {
  NestedRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NestedTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get parent => getField<String>('parent');
  set parent(String? value) => setField<String>('parent', value);

  String get place => getField<String>('place')!;
  set place(String value) => setField<String>('place', value);
}
