// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopupStruct extends BaseStruct {
  TopupStruct({
    int? amountPence,
    DateTime? acquiredAt,
    DateTime? usedAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? source,
    String? notes,
    String? referenceStr,
  })  : _amountPence = amountPence,
        _acquiredAt = acquiredAt,
        _usedAt = usedAt,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _source = source,
        _notes = notes,
        _referenceStr = referenceStr;

  // "amountPence" field.
  int? _amountPence;
  int get amountPence => _amountPence ?? 0;
  set amountPence(int? val) => _amountPence = val;

  void incrementAmountPence(int amount) => amountPence = amountPence + amount;

  bool hasAmountPence() => _amountPence != null;

  // "acquiredAt" field.
  DateTime? _acquiredAt;
  DateTime? get acquiredAt => _acquiredAt;
  set acquiredAt(DateTime? val) => _acquiredAt = val;

  bool hasAcquiredAt() => _acquiredAt != null;

  // "usedAt" field.
  DateTime? _usedAt;
  DateTime? get usedAt => _usedAt;
  set usedAt(DateTime? val) => _usedAt = val;

  bool hasUsedAt() => _usedAt != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "referenceStr" field.
  String? _referenceStr;
  String get referenceStr => _referenceStr ?? '';
  set referenceStr(String? val) => _referenceStr = val;

  bool hasReferenceStr() => _referenceStr != null;

  static TopupStruct fromMap(Map<String, dynamic> data) => TopupStruct(
        amountPence: castToType<int>(data['amountPence']),
        acquiredAt: data['acquiredAt'] as DateTime?,
        usedAt: data['usedAt'] as DateTime?,
        status: data['status'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
        source: data['source'] as String?,
        notes: data['notes'] as String?,
        referenceStr: data['referenceStr'] as String?,
      );

  static TopupStruct? maybeFromMap(dynamic data) =>
      data is Map ? TopupStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'amountPence': _amountPence,
        'acquiredAt': _acquiredAt,
        'usedAt': _usedAt,
        'status': _status,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'source': _source,
        'notes': _notes,
        'referenceStr': _referenceStr,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amountPence': serializeParam(
          _amountPence,
          ParamType.int,
        ),
        'acquiredAt': serializeParam(
          _acquiredAt,
          ParamType.DateTime,
        ),
        'usedAt': serializeParam(
          _usedAt,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'updatedAt': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
        'referenceStr': serializeParam(
          _referenceStr,
          ParamType.String,
        ),
      }.withoutNulls;

  static TopupStruct fromSerializableMap(Map<String, dynamic> data) =>
      TopupStruct(
        amountPence: deserializeParam(
          data['amountPence'],
          ParamType.int,
          false,
        ),
        acquiredAt: deserializeParam(
          data['acquiredAt'],
          ParamType.DateTime,
          false,
        ),
        usedAt: deserializeParam(
          data['usedAt'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        updatedAt: deserializeParam(
          data['updatedAt'],
          ParamType.DateTime,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
        referenceStr: deserializeParam(
          data['referenceStr'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TopupStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TopupStruct &&
        amountPence == other.amountPence &&
        acquiredAt == other.acquiredAt &&
        usedAt == other.usedAt &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        source == other.source &&
        notes == other.notes &&
        referenceStr == other.referenceStr;
  }

  @override
  int get hashCode => const ListEquality().hash([
        amountPence,
        acquiredAt,
        usedAt,
        status,
        createdAt,
        updatedAt,
        source,
        notes,
        referenceStr
      ]);
}

TopupStruct createTopupStruct({
  int? amountPence,
  DateTime? acquiredAt,
  DateTime? usedAt,
  String? status,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? source,
  String? notes,
  String? referenceStr,
}) =>
    TopupStruct(
      amountPence: amountPence,
      acquiredAt: acquiredAt,
      usedAt: usedAt,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      source: source,
      notes: notes,
      referenceStr: referenceStr,
    );
