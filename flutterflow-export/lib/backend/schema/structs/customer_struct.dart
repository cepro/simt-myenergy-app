// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomerStruct extends BaseStruct {
  CustomerStruct({
    String? id,
    DateTime? confirmedDetailsAt,
    String? name,
    String? status,
  })  : _id = id,
        _confirmedDetailsAt = confirmedDetailsAt,
        _name = name,
        _status = status;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "confirmedDetailsAt" field.
  DateTime? _confirmedDetailsAt;
  DateTime? get confirmedDetailsAt => _confirmedDetailsAt;
  set confirmedDetailsAt(DateTime? val) => _confirmedDetailsAt = val;

  bool hasConfirmedDetailsAt() => _confirmedDetailsAt != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static CustomerStruct fromMap(Map<String, dynamic> data) => CustomerStruct(
        id: data['id'] as String?,
        confirmedDetailsAt: data['confirmedDetailsAt'] as DateTime?,
        name: data['name'] as String?,
        status: data['status'] as String?,
      );

  static CustomerStruct? maybeFromMap(dynamic data) =>
      data is Map ? CustomerStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'confirmedDetailsAt': _confirmedDetailsAt,
        'name': _name,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'confirmedDetailsAt': serializeParam(
          _confirmedDetailsAt,
          ParamType.DateTime,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static CustomerStruct fromSerializableMap(Map<String, dynamic> data) =>
      CustomerStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        confirmedDetailsAt: deserializeParam(
          data['confirmedDetailsAt'],
          ParamType.DateTime,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CustomerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CustomerStruct &&
        id == other.id &&
        confirmedDetailsAt == other.confirmedDetailsAt &&
        name == other.name &&
        status == other.status;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, confirmedDetailsAt, name, status]);
}

CustomerStruct createCustomerStruct({
  String? id,
  DateTime? confirmedDetailsAt,
  String? name,
  String? status,
}) =>
    CustomerStruct(
      id: id,
      confirmedDetailsAt: confirmedDetailsAt,
      name: name,
      status: status,
    );
