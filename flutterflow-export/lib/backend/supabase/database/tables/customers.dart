import '../database.dart';

class CustomersTable extends SupabaseTable<CustomersRow> {
  @override
  String get tableName => 'customers';

  @override
  CustomersRow createRow(Map<String, dynamic> data) => CustomersRow(data);
}

class CustomersRow extends SupabaseDataRow {
  CustomersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CustomersTable();

  String? get fullname => getField<String>('fullname');
  set fullname(String? value) => setField<String>('fullname', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String get customerId => getField<String>('customer_id')!;
  set customerId(String value) => setField<String>('customer_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
