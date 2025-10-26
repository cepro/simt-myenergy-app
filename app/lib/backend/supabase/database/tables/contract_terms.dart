import '../database.dart';

class ContractTermsTable extends SupabaseTable<ContractTermsRow> {
  @override
  String get tableName => 'contract_terms';

  @override
  ContractTermsRow createRow(Map<String, dynamic> data) =>
      ContractTermsRow(data);
}

class ContractTermsRow extends SupabaseDataRow {
  ContractTermsRow(super.data);

  @override
  SupabaseTable get table => ContractTermsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  int get version => getField<int>('version')!;
  set version(int value) => setField<int>('version', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  int? get docusealTemplateId => getField<int>('docuseal_template_id');
  set docusealTemplateId(int? value) =>
      setField<int>('docuseal_template_id', value);

  String? get docusealTemplateSlug =>
      getField<String>('docuseal_template_slug');
  set docusealTemplateSlug(String? value) =>
      setField<String>('docuseal_template_slug', value);

  String get summaryText => getField<String>('summary_text')!;
  set summaryText(String value) => setField<String>('summary_text', value);

  String? get subtype => getField<String>('subtype');
  set subtype(String? value) => setField<String>('subtype', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
