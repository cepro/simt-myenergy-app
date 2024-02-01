// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SiteStruct extends BaseStruct {
  SiteStruct({
    String? id,
    String? name,
    String? code,
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
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;
  bool hasCode() => _code != null;

  static SiteStruct fromMap(Map<String, dynamic> data) => SiteStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        code: data['code'] as String?,
      );

  static SiteStruct? maybeFromMap(dynamic data) =>
      data is Map ? SiteStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'code': _code,
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
          ParamType.String,
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
        code: deserializeParam(
          data['code'],
          ParamType.String,
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
  String? code,
}) =>
    SiteStruct(
      id: id,
      name: name,
      code: code,
    );
