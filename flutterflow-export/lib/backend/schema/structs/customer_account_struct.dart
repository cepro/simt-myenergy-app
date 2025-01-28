// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomerAccountStruct extends BaseStruct {
  CustomerAccountStruct({
    String? role,
  }) : _role = role;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  static CustomerAccountStruct fromMap(Map<String, dynamic> data) =>
      CustomerAccountStruct(
        role: data['role'] as String?,
      );

  static CustomerAccountStruct? maybeFromMap(dynamic data) => data is Map
      ? CustomerAccountStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'role': _role,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
      }.withoutNulls;

  static CustomerAccountStruct fromSerializableMap(Map<String, dynamic> data) =>
      CustomerAccountStruct(
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CustomerAccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CustomerAccountStruct && role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([role]);
}

CustomerAccountStruct createCustomerAccountStruct({
  String? role,
}) =>
    CustomerAccountStruct(
      role: role,
    );
