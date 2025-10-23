// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SupabaseUserStruct extends BaseStruct {
  SupabaseUserStruct({
    String? authUserId,
    String? email,
    bool? isCeproUser,
    String? phone,
  })  : _authUserId = authUserId,
        _email = email,
        _isCeproUser = isCeproUser,
        _phone = phone;

  // "authUserId" field.
  String? _authUserId;
  String get authUserId => _authUserId ?? '';
  set authUserId(String? val) => _authUserId = val;

  bool hasAuthUserId() => _authUserId != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "isCeproUser" field.
  bool? _isCeproUser;
  bool get isCeproUser => _isCeproUser ?? false;
  set isCeproUser(bool? val) => _isCeproUser = val;

  bool hasIsCeproUser() => _isCeproUser != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  static SupabaseUserStruct fromMap(Map<String, dynamic> data) =>
      SupabaseUserStruct(
        authUserId: data['authUserId'] as String?,
        email: data['email'] as String?,
        isCeproUser: data['isCeproUser'] as bool?,
        phone: data['phone'] as String?,
      );

  static SupabaseUserStruct? maybeFromMap(dynamic data) => data is Map
      ? SupabaseUserStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'authUserId': _authUserId,
        'email': _email,
        'isCeproUser': _isCeproUser,
        'phone': _phone,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'authUserId': serializeParam(
          _authUserId,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'isCeproUser': serializeParam(
          _isCeproUser,
          ParamType.bool,
        ),
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
      }.withoutNulls;

  static SupabaseUserStruct fromSerializableMap(Map<String, dynamic> data) =>
      SupabaseUserStruct(
        authUserId: deserializeParam(
          data['authUserId'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        isCeproUser: deserializeParam(
          data['isCeproUser'],
          ParamType.bool,
          false,
        ),
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SupabaseUserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SupabaseUserStruct &&
        authUserId == other.authUserId &&
        email == other.email &&
        isCeproUser == other.isCeproUser &&
        phone == other.phone;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([authUserId, email, isCeproUser, phone]);
}

SupabaseUserStruct createSupabaseUserStruct({
  String? authUserId,
  String? email,
  bool? isCeproUser,
  String? phone,
}) =>
    SupabaseUserStruct(
      authUserId: authUserId,
      email: email,
      isCeproUser: isCeproUser,
      phone: phone,
    );
