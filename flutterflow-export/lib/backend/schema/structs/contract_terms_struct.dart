// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContractTermsStruct extends BaseStruct {
  ContractTermsStruct({
    String? id,
    String? type,
    String? subtype,
    int? version,
    String? summaryText,
    int? docusealTemplateId,
    String? docusealTemplateSlug,
    String? createdAt,
    String? shortDescription,
  })  : _id = id,
        _type = type,
        _subtype = subtype,
        _version = version,
        _summaryText = summaryText,
        _docusealTemplateId = docusealTemplateId,
        _docusealTemplateSlug = docusealTemplateSlug,
        _createdAt = createdAt,
        _shortDescription = shortDescription;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;
  bool hasType() => _type != null;

  // "subtype" field.
  String? _subtype;
  String get subtype => _subtype ?? '';
  set subtype(String? val) => _subtype = val;
  bool hasSubtype() => _subtype != null;

  // "version" field.
  int? _version;
  int get version => _version ?? 0;
  set version(int? val) => _version = val;
  void incrementVersion(int amount) => _version = version + amount;
  bool hasVersion() => _version != null;

  // "summaryText" field.
  String? _summaryText;
  String get summaryText => _summaryText ?? '';
  set summaryText(String? val) => _summaryText = val;
  bool hasSummaryText() => _summaryText != null;

  // "docusealTemplateId" field.
  int? _docusealTemplateId;
  int get docusealTemplateId => _docusealTemplateId ?? 0;
  set docusealTemplateId(int? val) => _docusealTemplateId = val;
  void incrementDocusealTemplateId(int amount) =>
      _docusealTemplateId = docusealTemplateId + amount;
  bool hasDocusealTemplateId() => _docusealTemplateId != null;

  // "docusealTemplateSlug" field.
  String? _docusealTemplateSlug;
  String get docusealTemplateSlug => _docusealTemplateSlug ?? '';
  set docusealTemplateSlug(String? val) => _docusealTemplateSlug = val;
  bool hasDocusealTemplateSlug() => _docusealTemplateSlug != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;
  bool hasCreatedAt() => _createdAt != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  set shortDescription(String? val) => _shortDescription = val;
  bool hasShortDescription() => _shortDescription != null;

  static ContractTermsStruct fromMap(Map<String, dynamic> data) =>
      ContractTermsStruct(
        id: data['id'] as String?,
        type: data['type'] as String?,
        subtype: data['subtype'] as String?,
        version: castToType<int>(data['version']),
        summaryText: data['summaryText'] as String?,
        docusealTemplateId: castToType<int>(data['docusealTemplateId']),
        docusealTemplateSlug: data['docusealTemplateSlug'] as String?,
        createdAt: data['createdAt'] as String?,
        shortDescription: data['shortDescription'] as String?,
      );

  static ContractTermsStruct? maybeFromMap(dynamic data) => data is Map
      ? ContractTermsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'type': _type,
        'subtype': _subtype,
        'version': _version,
        'summaryText': _summaryText,
        'docusealTemplateId': _docusealTemplateId,
        'docusealTemplateSlug': _docusealTemplateSlug,
        'createdAt': _createdAt,
        'shortDescription': _shortDescription,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'subtype': serializeParam(
          _subtype,
          ParamType.String,
        ),
        'version': serializeParam(
          _version,
          ParamType.int,
        ),
        'summaryText': serializeParam(
          _summaryText,
          ParamType.String,
        ),
        'docusealTemplateId': serializeParam(
          _docusealTemplateId,
          ParamType.int,
        ),
        'docusealTemplateSlug': serializeParam(
          _docusealTemplateSlug,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'shortDescription': serializeParam(
          _shortDescription,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContractTermsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContractTermsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        subtype: deserializeParam(
          data['subtype'],
          ParamType.String,
          false,
        ),
        version: deserializeParam(
          data['version'],
          ParamType.int,
          false,
        ),
        summaryText: deserializeParam(
          data['summaryText'],
          ParamType.String,
          false,
        ),
        docusealTemplateId: deserializeParam(
          data['docusealTemplateId'],
          ParamType.int,
          false,
        ),
        docusealTemplateSlug: deserializeParam(
          data['docusealTemplateSlug'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
        shortDescription: deserializeParam(
          data['shortDescription'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContractTermsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContractTermsStruct &&
        id == other.id &&
        type == other.type &&
        subtype == other.subtype &&
        version == other.version &&
        summaryText == other.summaryText &&
        docusealTemplateId == other.docusealTemplateId &&
        docusealTemplateSlug == other.docusealTemplateSlug &&
        createdAt == other.createdAt &&
        shortDescription == other.shortDescription;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        type,
        subtype,
        version,
        summaryText,
        docusealTemplateId,
        docusealTemplateSlug,
        createdAt,
        shortDescription
      ]);
}

ContractTermsStruct createContractTermsStruct({
  String? id,
  String? type,
  String? subtype,
  int? version,
  String? summaryText,
  int? docusealTemplateId,
  String? docusealTemplateSlug,
  String? createdAt,
  String? shortDescription,
}) =>
    ContractTermsStruct(
      id: id,
      type: type,
      subtype: subtype,
      version: version,
      summaryText: summaryText,
      docusealTemplateId: docusealTemplateId,
      docusealTemplateSlug: docusealTemplateSlug,
      createdAt: createdAt,
      shortDescription: shortDescription,
    );
