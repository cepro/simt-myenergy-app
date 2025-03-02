// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomerRoleStruct extends BaseStruct {
  CustomerRoleStruct({
    String? email,
    String? role,
  })  : _email = email,
        _role = role;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  static CustomerRoleStruct fromMap(Map<String, dynamic> data) =>
      CustomerRoleStruct(
        email: data['email'] as String?,
        role: data['role'] as String?,
      );

  static CustomerRoleStruct? maybeFromMap(dynamic data) => data is Map
      ? CustomerRoleStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'email': _email,
        'role': _role,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
      }.withoutNulls;

  static CustomerRoleStruct fromSerializableMap(Map<String, dynamic> data) =>
      CustomerRoleStruct(
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CustomerRoleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CustomerRoleStruct &&
        email == other.email &&
        role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([email, role]);
}

CustomerRoleStruct createCustomerRoleStruct({
  String? email,
  String? role,
}) =>
    CustomerRoleStruct(
      email: email,
      role: role,
    );
