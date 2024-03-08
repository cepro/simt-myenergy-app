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

  DateTime? get billingMonth => getField<DateTime>('billing_month');
  set billingMonth(DateTime? value) =>
      setField<DateTime>('billing_month', value);

  String? get reportUrl => getField<String>('report_url');
  set reportUrl(String? value) => setField<String>('report_url', value);
}
