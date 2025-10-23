import '../database.dart';

class AccountsTable extends SupabaseTable<AccountsRow> {
  @override
  String get tableName => 'accounts';

  @override
  AccountsRow createRow(Map<String, dynamic> data) => AccountsRow(data);
}

class AccountsRow extends SupabaseDataRow {
  AccountsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AccountsTable();

  int get accountNumber => getField<int>('account_number')!;
  set accountNumber(int value) => setField<int>('account_number', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get property => getField<String>('property');
  set property(String? value) => setField<String>('property', value);

  String? get currentContract => getField<String>('current_contract');
  set currentContract(String? value) =>
      setField<String>('current_contract', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
