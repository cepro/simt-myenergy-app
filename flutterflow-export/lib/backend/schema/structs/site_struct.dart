// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SiteStruct extends BaseStruct {
  SiteStruct({
    String? id,
    String? name,
    SiteCodeEnum? code,
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
  SiteCodeEnum? _code;
  SiteCodeEnum get code => _code ?? SiteCodeEnum.unknown;
  set code(SiteCodeEnum? val) => _code = val;
  bool hasCode() => _code != null;

  static SiteStruct fromMap(Map<String, dynamic> data) => SiteStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        code: deserializeEnum<SiteCodeEnum>(data['code']),
      );

  static SiteStruct? maybeFromMap(dynamic data) =>
      data is Map ? SiteStruct.fromMap(data.cast<String, dynamic>()) : null;

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

  static SiteStruct fromSerializableMap(Map<String, dynamic> data) =>
      SiteStruct(
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
        code: deserializeParam<SiteCodeEnum>(
          data['code'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'SiteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SiteStruct &&
        id == other.id &&
        name == other.name &&
        code == other.code;
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, code]);
}

SiteStruct createSiteStruct({
  String? id,
  String? name,
  SiteCodeEnum? code,
}) =>
    SiteStruct(
      id: id,
      name: name,
      code: code,
    );
