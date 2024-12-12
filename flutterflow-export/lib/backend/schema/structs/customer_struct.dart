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
    bool? hasPaymentMethod,
    bool? exiting,
    bool? allowOnboardTransition,
  })  : _id = id,
        _confirmedDetailsAt = confirmedDetailsAt,
        _name = name,
        _status = status,
        _hasPaymentMethod = hasPaymentMethod,
        _exiting = exiting,
        _allowOnboardTransition = allowOnboardTransition;

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

  // "hasPaymentMethod" field.
  bool? _hasPaymentMethod;
  bool get hasPaymentMethod => _hasPaymentMethod ?? false;
  set hasPaymentMethod(bool? val) => _hasPaymentMethod = val;

  bool hasHasPaymentMethod() => _hasPaymentMethod != null;

  // "exiting" field.
  bool? _exiting;
  bool get exiting => _exiting ?? false;
  set exiting(bool? val) => _exiting = val;

  bool hasExiting() => _exiting != null;

  // "allowOnboardTransition" field.
  bool? _allowOnboardTransition;
  bool get allowOnboardTransition => _allowOnboardTransition ?? false;
  set allowOnboardTransition(bool? val) => _allowOnboardTransition = val;

  bool hasAllowOnboardTransition() => _allowOnboardTransition != null;

  static CustomerStruct fromMap(Map<String, dynamic> data) => CustomerStruct(
        id: data['id'] as String?,
        confirmedDetailsAt: data['confirmedDetailsAt'] as DateTime?,
        name: data['name'] as String?,
        status: data['status'] as String?,
        hasPaymentMethod: data['hasPaymentMethod'] as bool?,
        exiting: data['exiting'] as bool?,
        allowOnboardTransition: data['allowOnboardTransition'] as bool?,
      );

  static CustomerStruct? maybeFromMap(dynamic data) =>
      data is Map ? CustomerStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'confirmedDetailsAt': _confirmedDetailsAt,
        'name': _name,
        'status': _status,
        'hasPaymentMethod': _hasPaymentMethod,
        'exiting': _exiting,
        'allowOnboardTransition': _allowOnboardTransition,
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
        'hasPaymentMethod': serializeParam(
          _hasPaymentMethod,
          ParamType.bool,
        ),
        'exiting': serializeParam(
          _exiting,
          ParamType.bool,
        ),
        'allowOnboardTransition': serializeParam(
          _allowOnboardTransition,
          ParamType.bool,
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
        hasPaymentMethod: deserializeParam(
          data['hasPaymentMethod'],
          ParamType.bool,
          false,
        ),
        exiting: deserializeParam(
          data['exiting'],
          ParamType.bool,
          false,
        ),
        allowOnboardTransition: deserializeParam(
          data['allowOnboardTransition'],
          ParamType.bool,
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
        status == other.status &&
        hasPaymentMethod == other.hasPaymentMethod &&
        exiting == other.exiting &&
        allowOnboardTransition == other.allowOnboardTransition;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        confirmedDetailsAt,
        name,
        status,
        hasPaymentMethod,
        exiting,
        allowOnboardTransition
      ]);
}

CustomerStruct createCustomerStruct({
  String? id,
  DateTime? confirmedDetailsAt,
  String? name,
  String? status,
  bool? hasPaymentMethod,
  bool? exiting,
  bool? allowOnboardTransition,
}) =>
    CustomerStruct(
      id: id,
      confirmedDetailsAt: confirmedDetailsAt,
      name: name,
      status: status,
      hasPaymentMethod: hasPaymentMethod,
      exiting: exiting,
      allowOnboardTransition: allowOnboardTransition,
    );
