import '../database.dart';

class TransactionStatusesTable extends SupabaseTable<TransactionStatusesRow> {
  @override
  String get tableName => 'transaction_statuses';

  @override
  TransactionStatusesRow createRow(Map<String, dynamic> data) =>
      TransactionStatusesRow(data);
}

class TransactionStatusesRow extends SupabaseDataRow {
  TransactionStatusesRow(super.data);

  @override
  SupabaseTable get table => TransactionStatusesTable();

  DateTime get timestamp => getField<DateTime>('timestamp')!;
  set timestamp(DateTime value) => setField<DateTime>('timestamp', value);

  String get transaction => getField<String>('transaction')!;
  set transaction(String value) => setField<String>('transaction', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  double get availableBalance => getField<double>('available_balance')!;
  set availableBalance(double value) =>
      setField<double>('available_balance', value);
}
