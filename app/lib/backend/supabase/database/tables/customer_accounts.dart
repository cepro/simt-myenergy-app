import '../database.dart';

class CustomerAccountsTable extends SupabaseTable<CustomerAccountsRow> {
  @override
  String get tableName => 'customer_accounts';

  @override
  CustomerAccountsRow createRow(Map<String, dynamic> data) =>
      CustomerAccountsRow(data);
}

class CustomerAccountsRow extends SupabaseDataRow {
  CustomerAccountsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CustomerAccountsTable();

  String get customer => getField<String>('customer')!;
  set customer(String value) => setField<String>('customer', value);

  String get account => getField<String>('account')!;
  set account(String value) => setField<String>('account', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  String get role => getField<String>('role')!;
  set role(String value) => setField<String>('role', value);
}
