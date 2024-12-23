// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TopupStruct extends BaseStruct {
  TopupStruct({
    String? id,
    int? amountPence,
    DateTime? aquiredAt,
    DateTime? usedAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _id = id,
        _amountPence = amountPence,
        _aquiredAt = aquiredAt,
        _usedAt = usedAt,
        _status = status,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

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

  static TopupStruct fromMap(Map<String, dynamic> data) => TopupStruct(
        id: data['id'] as String?,
        amountPence: castToType<int>(data['amountPence']),
        aquiredAt: data['aquiredAt'] as DateTime?,
        usedAt: data['usedAt'] as DateTime?,
        status: data['status'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
      );

  static TopupStruct? maybeFromMap(dynamic data) =>
      data is Map ? TopupStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'amountPence': _amountPence,
        'aquiredAt': _aquiredAt,
        'usedAt': _usedAt,
        'status': _status,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
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
      }.withoutNulls;

  static TopupStruct fromSerializableMap(Map<String, dynamic> data) =>
      TopupStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
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
      );

  @override
  String toString() => 'TopupStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TopupStruct &&
        id == other.id &&
        amountPence == other.amountPence &&
        aquiredAt == other.aquiredAt &&
        usedAt == other.usedAt &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, amountPence, aquiredAt, usedAt, status, createdAt, updatedAt]);
}

TopupStruct createTopupStruct({
  String? id,
  int? amountPence,
  DateTime? aquiredAt,
  DateTime? usedAt,
  String? status,
  DateTime? createdAt,
  DateTime? updatedAt,
}) =>
    TopupStruct(
      id: id,
      amountPence: amountPence,
      aquiredAt: aquiredAt,
      usedAt: usedAt,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
