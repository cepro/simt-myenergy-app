// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopupStruct extends BaseStruct {
  TopupStruct({
    int? amountPence,
    DateTime? aquiredAt,
    DateTime? usedAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? source,
    String? notes,
  })  : _amountPence = amountPence,
        _aquiredAt = aquiredAt,
        _usedAt = usedAt,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _source = source,
        _notes = notes;

  // "amountPence" field.
  int? _amountPence;
  int get amountPence => _amountPence ?? 0;
  set amountPence(int? val) => _amountPence = val;

  void incrementAmountPence(int amount) => amountPence = amountPence + amount;

  bool hasAmountPence() => _amountPence != null;

  // "aquiredAt" field.
  DateTime? _aquiredAt;
  DateTime? get aquiredAt => _aquiredAt;
  set aquiredAt(DateTime? val) => _aquiredAt = val;

  bool hasAquiredAt() => _aquiredAt != null;

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

  static TopupStruct fromMap(Map<String, dynamic> data) => TopupStruct(
        amountPence: castToType<int>(data['amountPence']),
        aquiredAt: data['aquiredAt'] as DateTime?,
        usedAt: data['usedAt'] as DateTime?,
        status: data['status'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
        source: data['source'] as String?,
        notes: data['notes'] as String?,
      );

  static TopupStruct? maybeFromMap(dynamic data) =>
      data is Map ? TopupStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'amountPence': _amountPence,
        'aquiredAt': _aquiredAt,
        'usedAt': _usedAt,
        'status': _status,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'source': _source,
        'notes': _notes,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amountPence': serializeParam(
          _amountPence,
          ParamType.int,
        ),
        'aquiredAt': serializeParam(
          _aquiredAt,
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
      }.withoutNulls;

  static TopupStruct fromSerializableMap(Map<String, dynamic> data) =>
      TopupStruct(
        amountPence: deserializeParam(
          data['amountPence'],
          ParamType.int,
          false,
        ),
        aquiredAt: deserializeParam(
          data['aquiredAt'],
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
      );

  @override
  String toString() => 'TopupStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TopupStruct &&
        amountPence == other.amountPence &&
        aquiredAt == other.aquiredAt &&
        usedAt == other.usedAt &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        source == other.source &&
        notes == other.notes;
  }

  @override
  int get hashCode => const ListEquality().hash([
        amountPence,
        aquiredAt,
        usedAt,
        status,
        createdAt,
        updatedAt,
        source,
        notes
      ]);
}

TopupStruct createTopupStruct({
  int? amountPence,
  DateTime? aquiredAt,
  DateTime? usedAt,
  String? status,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? source,
  String? notes,
}) =>
    TopupStruct(
      amountPence: amountPence,
      aquiredAt: aquiredAt,
      usedAt: usedAt,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      source: source,
      notes: notes,
    );
