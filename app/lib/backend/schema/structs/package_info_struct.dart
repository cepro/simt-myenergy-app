// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PackageInfoStruct extends BaseStruct {
  PackageInfoStruct({
    String? version,
    String? buildNumber,
    String? packageName,
    String? appName,
  })  : _version = version,
        _buildNumber = buildNumber,
        _packageName = packageName,
        _appName = appName;

  // "version" field.
  String? _version;
  String get version => _version ?? '';
  set version(String? val) => _version = val;

  bool hasVersion() => _version != null;

  // "buildNumber" field.
  String? _buildNumber;
  String get buildNumber => _buildNumber ?? '';
  set buildNumber(String? val) => _buildNumber = val;

  bool hasBuildNumber() => _buildNumber != null;

  // "packageName" field.
  String? _packageName;
  String get packageName => _packageName ?? '';
  set packageName(String? val) => _packageName = val;

  bool hasPackageName() => _packageName != null;

  // "appName" field.
  String? _appName;
  String get appName => _appName ?? '';
  set appName(String? val) => _appName = val;

  bool hasAppName() => _appName != null;

  static PackageInfoStruct fromMap(Map<String, dynamic> data) =>
      PackageInfoStruct(
        version: data['version'] as String?,
        buildNumber: data['buildNumber'] as String?,
        packageName: data['packageName'] as String?,
        appName: data['appName'] as String?,
      );

  static PackageInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? PackageInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'version': _version,
        'buildNumber': _buildNumber,
        'packageName': _packageName,
        'appName': _appName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'version': serializeParam(
          _version,
          ParamType.String,
        ),
        'buildNumber': serializeParam(
          _buildNumber,
          ParamType.String,
        ),
        'packageName': serializeParam(
          _packageName,
          ParamType.String,
        ),
        'appName': serializeParam(
          _appName,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackageInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      PackageInfoStruct(
        version: deserializeParam(
          data['version'],
          ParamType.String,
          false,
        ),
        buildNumber: deserializeParam(
          data['buildNumber'],
          ParamType.String,
          false,
        ),
        packageName: deserializeParam(
          data['packageName'],
          ParamType.String,
          false,
        ),
        appName: deserializeParam(
          data['appName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackageInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackageInfoStruct &&
        version == other.version &&
        buildNumber == other.buildNumber &&
        packageName == other.packageName &&
        appName == other.appName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([version, buildNumber, packageName, appName]);
}

PackageInfoStruct createPackageInfoStruct({
  String? version,
  String? buildNumber,
  String? packageName,
  String? appName,
}) =>
    PackageInfoStruct(
      version: version,
      buildNumber: buildNumber,
      packageName: packageName,
      appName: appName,
    );
