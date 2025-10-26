import '../database.dart';

class ContractsTable extends SupabaseTable<ContractsRow> {
  @override
  String get tableName => 'contracts';

  @override
  ContractsRow createRow(Map<String, dynamic> data) => ContractsRow(data);
}

class ContractsRow extends SupabaseDataRow {
  ContractsRow(super.data);

  @override
  SupabaseTable get table => ContractsTable();

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime? get endDate => getField<DateTime>('end_date');
  set endDate(DateTime? value) => setField<DateTime>('end_date', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  DateTime? get effectiveDate => getField<DateTime>('effective_date');
  set effectiveDate(DateTime? value) =>
      setField<DateTime>('effective_date', value);

  DateTime? get signedDate => getField<DateTime>('signed_date');
  set signedDate(DateTime? value) => setField<DateTime>('signed_date', value);

  String? get terms => getField<String>('terms');
  set terms(String? value) => setField<String>('terms', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  int? get docusealSubmissionId => getField<int>('docuseal_submission_id');
  set docusealSubmissionId(int? value) =>
      setField<int>('docuseal_submission_id', value);

  String? get signedContractUrl => getField<String>('signed_contract_url');
  set signedContractUrl(String? value) =>
      setField<String>('signed_contract_url', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
