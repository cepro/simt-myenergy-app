// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomActionResultStruct extends BaseStruct {
  CustomActionResultStruct({
    bool? success,
    String? errorMessage,
  })  : _success = success,
        _errorMessage = errorMessage;

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "errorMessage" field.
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? '';
  set errorMessage(String? val) => _errorMessage = val;

  bool hasErrorMessage() => _errorMessage != null;

  static CustomActionResultStruct fromMap(Map<String, dynamic> data) =>
      CustomActionResultStruct(
        success: data['success'] as bool?,
        errorMessage: data['errorMessage'] as String?,
      );

  static CustomActionResultStruct? maybeFromMap(dynamic data) => data is Map
      ? CustomActionResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'errorMessage': _errorMessage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'errorMessage': serializeParam(
          _errorMessage,
          ParamType.String,
        ),
      }.withoutNulls;

  static CustomActionResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CustomActionResultStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        errorMessage: deserializeParam(
          data['errorMessage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CustomActionResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CustomActionResultStruct &&
        success == other.success &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => const ListEquality().hash([success, errorMessage]);
}

CustomActionResultStruct createCustomActionResultStruct({
  bool? success,
  String? errorMessage,
}) =>
    CustomActionResultStruct(
      success: success,
      errorMessage: errorMessage,
    );
