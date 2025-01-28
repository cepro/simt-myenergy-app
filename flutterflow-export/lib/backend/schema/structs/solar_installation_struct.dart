// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SolarInstallationStruct extends BaseStruct {
  SolarInstallationStruct({
    String? id,
    String? mcs,
    double? declaredNetCapacity,
    DateTime? commissioningDate,
  })  : _id = id,
        _mcs = mcs,
        _declaredNetCapacity = declaredNetCapacity,
        _commissioningDate = commissioningDate;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

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
        id: data['id'] as String?,
        mcs: data['mcs'] as String?,
        declaredNetCapacity: castToType<double>(data['declaredNetCapacity']),
        commissioningDate: data['commissioningDate'] as DateTime?,
      );

  static SolarInstallationStruct? maybeFromMap(dynamic data) => data is Map
      ? SolarInstallationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'mcs': _mcs,
        'declaredNetCapacity': _declaredNetCapacity,
        'commissioningDate': _commissioningDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
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
        id: deserializeParam(
          data['id'],
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
        id == other.id &&
        mcs == other.mcs &&
        declaredNetCapacity == other.declaredNetCapacity &&
        commissioningDate == other.commissioningDate;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, mcs, declaredNetCapacity, commissioningDate]);
}

SolarInstallationStruct createSolarInstallationStruct({
  String? id,
  String? mcs,
  double? declaredNetCapacity,
  DateTime? commissioningDate,
}) =>
    SolarInstallationStruct(
      id: id,
      mcs: mcs,
      declaredNetCapacity: declaredNetCapacity,
      commissioningDate: commissioningDate,
    );
