// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContractStruct extends BaseStruct {
  ContractStruct({
    String? id,
    String? type,
    String? description,
    int? docusealSubmissionId,
    String? signedContractURL,
    String? signedDate,
    String? effectiveDate,
    String? endDate,
    String? termsId,
  })  : _id = id,
        _type = type,
        _description = description,
        _docusealSubmissionId = docusealSubmissionId,
        _signedContractURL = signedContractURL,
        _signedDate = signedDate,
        _effectiveDate = effectiveDate,
        _endDate = endDate,
        _termsId = termsId;

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

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  // "docusealSubmissionId" field.
  int? _docusealSubmissionId;
  int get docusealSubmissionId => _docusealSubmissionId ?? 0;
  set docusealSubmissionId(int? val) => _docusealSubmissionId = val;
  void incrementDocusealSubmissionId(int amount) =>
      _docusealSubmissionId = docusealSubmissionId + amount;
  bool hasDocusealSubmissionId() => _docusealSubmissionId != null;

  // "signedContractURL" field.
  String? _signedContractURL;
  String get signedContractURL => _signedContractURL ?? '';
  set signedContractURL(String? val) => _signedContractURL = val;
  bool hasSignedContractURL() => _signedContractURL != null;

  // "signedDate" field.
  String? _signedDate;
  String get signedDate => _signedDate ?? '';
  set signedDate(String? val) => _signedDate = val;
  bool hasSignedDate() => _signedDate != null;

  // "effectiveDate" field.
  String? _effectiveDate;
  String get effectiveDate => _effectiveDate ?? '';
  set effectiveDate(String? val) => _effectiveDate = val;
  bool hasEffectiveDate() => _effectiveDate != null;

  // "endDate" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;
  bool hasEndDate() => _endDate != null;

  // "termsId" field.
  String? _termsId;
  String get termsId => _termsId ?? '';
  set termsId(String? val) => _termsId = val;
  bool hasTermsId() => _termsId != null;

  static ContractStruct fromMap(Map<String, dynamic> data) => ContractStruct(
        id: data['id'] as String?,
        type: data['type'] as String?,
        description: data['description'] as String?,
        docusealSubmissionId: castToType<int>(data['docusealSubmissionId']),
        signedContractURL: data['signedContractURL'] as String?,
        signedDate: data['signedDate'] as String?,
        effectiveDate: data['effectiveDate'] as String?,
        endDate: data['endDate'] as String?,
        termsId: data['termsId'] as String?,
      );

  static ContractStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContractStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'type': _type,
        'description': _description,
        'docusealSubmissionId': _docusealSubmissionId,
        'signedContractURL': _signedContractURL,
        'signedDate': _signedDate,
        'effectiveDate': _effectiveDate,
        'endDate': _endDate,
        'termsId': _termsId,
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
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'docusealSubmissionId': serializeParam(
          _docusealSubmissionId,
          ParamType.int,
        ),
        'signedContractURL': serializeParam(
          _signedContractURL,
          ParamType.String,
        ),
        'signedDate': serializeParam(
          _signedDate,
          ParamType.String,
        ),
        'effectiveDate': serializeParam(
          _effectiveDate,
          ParamType.String,
        ),
        'endDate': serializeParam(
          _endDate,
          ParamType.String,
        ),
        'termsId': serializeParam(
          _termsId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContractStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContractStruct(
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
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        docusealSubmissionId: deserializeParam(
          data['docusealSubmissionId'],
          ParamType.int,
          false,
        ),
        signedContractURL: deserializeParam(
          data['signedContractURL'],
          ParamType.String,
          false,
        ),
        signedDate: deserializeParam(
          data['signedDate'],
          ParamType.String,
          false,
        ),
        effectiveDate: deserializeParam(
          data['effectiveDate'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['endDate'],
          ParamType.String,
          false,
        ),
        termsId: deserializeParam(
          data['termsId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContractStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContractStruct &&
        id == other.id &&
        type == other.type &&
        description == other.description &&
        docusealSubmissionId == other.docusealSubmissionId &&
        signedContractURL == other.signedContractURL &&
        signedDate == other.signedDate &&
        effectiveDate == other.effectiveDate &&
        endDate == other.endDate &&
        termsId == other.termsId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        type,
        description,
        docusealSubmissionId,
        signedContractURL,
        signedDate,
        effectiveDate,
        endDate,
        termsId
      ]);
}

ContractStruct createContractStruct({
  String? id,
  String? type,
  String? description,
  int? docusealSubmissionId,
  String? signedContractURL,
  String? signedDate,
  String? effectiveDate,
  String? endDate,
  String? termsId,
}) =>
    ContractStruct(
      id: id,
      type: type,
      description: description,
      docusealSubmissionId: docusealSubmissionId,
      signedContractURL: signedContractURL,
      signedDate: signedDate,
      effectiveDate: effectiveDate,
      endDate: endDate,
      termsId: termsId,
    );
