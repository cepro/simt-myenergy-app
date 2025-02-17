// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SolarInstallationStruct extends BaseStruct {
  SolarInstallationStruct({
    String? property,
    String? mcs,
    double? declaredNetCapacity,
    DateTime? commissioningDate,
  })  : _property = property,
        _mcs = mcs,
        _declaredNetCapacity = declaredNetCapacity,
        _commissioningDate = commissioningDate;

  // "property" field.
  String? _property;
  String get property => _property ?? '';
  set property(String? val) => _property = val;

  bool hasProperty() => _property != null;

  // "mcs" field.
  String? _mcs;
  String get mcs => _mcs ?? '';
  set mcs(String? val) => _mcs = val;

  bool hasMcs() => _mcs != null;

  // "declaredNetCapacity" field.
  double? _declaredNetCapacity;
  double get declaredNetCapacity => _declaredNetCapacity ?? 0.0;
  set declaredNetCapacity(double? val) => _declaredNetCapacity = val;

  void incrementDeclaredNetCapacity(double amount) =>
      declaredNetCapacity = declaredNetCapacity + amount;

  bool hasDeclaredNetCapacity() => _declaredNetCapacity != null;

  // "commissioningDate" field.
  DateTime? _commissioningDate;
  DateTime? get commissioningDate => _commissioningDate;
  set commissioningDate(DateTime? val) => _commissioningDate = val;

  bool hasCommissioningDate() => _commissioningDate != null;

  static SolarInstallationStruct fromMap(Map<String, dynamic> data) =>
      SolarInstallationStruct(
        property: data['property'] as String?,
        mcs: data['mcs'] as String?,
        declaredNetCapacity: castToType<double>(data['declaredNetCapacity']),
        commissioningDate: data['commissioningDate'] as DateTime?,
      );

  static SolarInstallationStruct? maybeFromMap(dynamic data) => data is Map
      ? SolarInstallationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'property': _property,
        'mcs': _mcs,
        'declaredNetCapacity': _declaredNetCapacity,
        'commissioningDate': _commissioningDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'property': serializeParam(
          _property,
          ParamType.String,
        ),
        'mcs': serializeParam(
          _mcs,
          ParamType.String,
        ),
        'declaredNetCapacity': serializeParam(
          _declaredNetCapacity,
          ParamType.double,
        ),
        'commissioningDate': serializeParam(
          _commissioningDate,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static SolarInstallationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SolarInstallationStruct(
        property: deserializeParam(
          data['property'],
          ParamType.String,
          false,
        ),
        mcs: deserializeParam(
          data['mcs'],
          ParamType.String,
          false,
        ),
        declaredNetCapacity: deserializeParam(
          data['declaredNetCapacity'],
          ParamType.double,
          false,
        ),
        commissioningDate: deserializeParam(
          data['commissioningDate'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'SolarInstallationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SolarInstallationStruct &&
        property == other.property &&
        mcs == other.mcs &&
        declaredNetCapacity == other.declaredNetCapacity &&
        commissioningDate == other.commissioningDate;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([property, mcs, declaredNetCapacity, commissioningDate]);
}

SolarInstallationStruct createSolarInstallationStruct({
  String? property,
  String? mcs,
  double? declaredNetCapacity,
  DateTime? commissioningDate,
}) =>
    SolarInstallationStruct(
      property: property,
      mcs: mcs,
      declaredNetCapacity: declaredNetCapacity,
      commissioningDate: commissioningDate,
    );
