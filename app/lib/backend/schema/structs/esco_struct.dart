// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EscoStruct extends BaseStruct {
  EscoStruct({
    String? id,
    String? name,
    EscoCodeEnum? code,
  })  : _id = id,
        _name = name,
        _code = code;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "code" field.
  EscoCodeEnum? _code;
  EscoCodeEnum get code => _code ?? EscoCodeEnum.unknown;
  set code(EscoCodeEnum? val) => _code = val;

  bool hasCode() => _code != null;

  static EscoStruct fromMap(Map<String, dynamic> data) => EscoStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        code: data['code'] is EscoCodeEnum
            ? data['code']
            : deserializeEnum<EscoCodeEnum>(data['code']),
      );

  static EscoStruct? maybeFromMap(dynamic data) =>
      data is Map ? EscoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'code': _code?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'code': serializeParam(
          _code,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static EscoStruct fromSerializableMap(Map<String, dynamic> data) =>
      EscoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        code: deserializeParam<EscoCodeEnum>(
          data['code'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'EscoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EscoStruct &&
        id == other.id &&
        name == other.name &&
        code == other.code;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, code]);
}

EscoStruct createEscoStruct({
  String? id,
  String? name,
  EscoCodeEnum? code,
}) =>
    EscoStruct(
      id: id,
      name: name,
      code: code,
    );
