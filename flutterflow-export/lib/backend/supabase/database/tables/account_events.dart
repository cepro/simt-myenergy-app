import '../database.dart';

class AccountEventsTable extends SupabaseTable<AccountEventsRow> {
  @override
  String get tableName => 'account_events';

  @override
  AccountEventsRow createRow(Map<String, dynamic> data) =>
      AccountEventsRow(data);
}

class AccountEventsRow extends SupabaseDataRow {
  AccountEventsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AccountEventsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get account => getField<String>('account')!;
  set account(String value) => setField<String>('account', value);

  String get historyType => getField<String>('history_type')!;
  set historyType(String value) => setField<String>('history_type', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  DateTime get eventTimestamp => getField<DateTime>('event_timestamp')!;
  set eventTimestamp(DateTime value) =>
      setField<DateTime>('event_timestamp', value);
}
