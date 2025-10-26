import '../database.dart';

class CustomerInvitesTable extends SupabaseTable<CustomerInvitesRow> {
  @override
  String get tableName => 'customer_invites';

  @override
  CustomerInvitesRow createRow(Map<String, dynamic> data) =>
      CustomerInvitesRow(data);
}

class CustomerInvitesRow extends SupabaseDataRow {
  CustomerInvitesRow(super.data);

  @override
  SupabaseTable get table => CustomerInvitesTable();

  String get inviteToken => getField<String>('invite_token')!;
  set inviteToken(String value) => setField<String>('invite_token', value);

  String get customer => getField<String>('customer')!;
  set customer(String value) => setField<String>('customer', value);

  DateTime get expiresAt => getField<DateTime>('expires_at')!;
  set expiresAt(DateTime value) => setField<DateTime>('expires_at', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get accessedAt => getField<DateTime>('accessed_at');
  set accessedAt(DateTime? value) => setField<DateTime>('accessed_at', value);

  String? get inviteUrl => getField<String>('invite_url');
  set inviteUrl(String? value) => setField<String>('invite_url', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);
}
