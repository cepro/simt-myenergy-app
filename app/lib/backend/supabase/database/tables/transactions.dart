import '../database.dart';

class TransactionsTable extends SupabaseTable<TransactionsRow> {
  @override
  String get tableName => 'transactions';

  @override
  TransactionsRow createRow(Map<String, dynamic> data) => TransactionsRow(data);
}

class TransactionsRow extends SupabaseDataRow {
  TransactionsRow(super.data);

  @override
  SupabaseTable get table => TransactionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get timestamp => getField<DateTime>('timestamp')!;
  set timestamp(DateTime value) => setField<DateTime>('timestamp', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get referenceField => getField<String>('reference');
  set referenceField(String? value) => setField<String>('reference', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  double get balance => getField<double>('balance')!;
  set balance(double value) => setField<double>('balance', value);

  String get account => getField<String>('account')!;
  set account(String value) => setField<String>('account', value);
}
