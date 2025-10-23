import '../database.dart';

class MonthlyFlowsTable extends SupabaseTable<MonthlyFlowsRow> {
  @override
  String get tableName => 'monthly_flows';

  @override
  MonthlyFlowsRow createRow(Map<String, dynamic> data) => MonthlyFlowsRow(data);
}

class MonthlyFlowsRow extends SupabaseDataRow {
  MonthlyFlowsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MonthlyFlowsTable();

  double get value => getField<double>('value')!;
  set value(double value) => setField<double>('value', value);

  DateTime get month => getField<DateTime>('month')!;
  set month(DateTime value) => setField<DateTime>('month', value);

  String get meterpoint => getField<String>('meterpoint')!;
  set meterpoint(String value) => setField<String>('meterpoint', value);
}
