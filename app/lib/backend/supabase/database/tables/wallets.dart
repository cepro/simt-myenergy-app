import '../database.dart';

class WalletsTable extends SupabaseTable<WalletsRow> {
  @override
  String get tableName => 'wallets';

  @override
  WalletsRow createRow(Map<String, dynamic> data) => WalletsRow(data);
}

class WalletsRow extends SupabaseDataRow {
  WalletsRow(super.data);

  @override
  SupabaseTable get table => WalletsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  double? get balance => getField<double>('balance');
  set balance(double? value) => setField<double>('balance', value);

  DateTime? get lastSyncTimestamp => getField<DateTime>('last_sync_timestamp');
  set lastSyncTimestamp(DateTime? value) =>
      setField<DateTime>('last_sync_timestamp', value);

  int get topupAmount => getField<int>('topup_amount')!;
  set topupAmount(int value) => setField<int>('topup_amount', value);

  int get topupThreshold => getField<int>('topup_threshold')!;
  set topupThreshold(int value) => setField<int>('topup_threshold', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);

  bool? get autoTopup => getField<bool>('auto_topup');
  set autoTopup(bool? value) => setField<bool>('auto_topup', value);
}
