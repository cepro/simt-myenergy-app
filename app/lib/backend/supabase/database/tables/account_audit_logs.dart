import '../database.dart';

class AccountAuditLogsTable extends SupabaseTable<AccountAuditLogsRow> {
  @override
  String get tableName => 'account_audit_logs';

  @override
  AccountAuditLogsRow createRow(Map<String, dynamic> data) =>
      AccountAuditLogsRow(data);
}

class AccountAuditLogsRow extends SupabaseDataRow {
  AccountAuditLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AccountAuditLogsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get principal => getField<String>('principal')!;
  set principal(String value) => setField<String>('principal', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  dynamic get dataField => getField<dynamic>('data')!;
  set dataField(dynamic value) => setField<dynamic>('data', value);

  DateTime get timestamp => getField<DateTime>('timestamp')!;
  set timestamp(DateTime value) => setField<DateTime>('timestamp', value);
}
