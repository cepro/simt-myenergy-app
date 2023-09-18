import '../database.dart';

class ReportsTable extends SupabaseTable<ReportsRow> {
  @override
  String get tableName => 'reports';

  @override
  ReportsRow createRow(Map<String, dynamic> data) => ReportsRow(data);
}

class ReportsRow extends SupabaseDataRow {
  ReportsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ReportsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get contract => getField<String>('contract');
  set contract(String? value) => setField<String>('contract', value);

  String? get billingmonth => getField<String>('billingmonth');
  set billingmonth(String? value) => setField<String>('billingmonth', value);

  String? get reporturl => getField<String>('reporturl');
  set reporturl(String? value) => setField<String>('reporturl', value);
}
