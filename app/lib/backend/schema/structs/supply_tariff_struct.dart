// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SupplyTariffStruct extends BaseStruct {
  SupplyTariffStruct({
    DateTime? periodStart,
    double? unitRate,
    double? standingCharge,
  })  : _periodStart = periodStart,
        _unitRate = unitRate,
        _standingCharge = standingCharge;

  // "periodStart" field.
  DateTime? _periodStart;
  DateTime? get periodStart => _periodStart;
  set periodStart(DateTime? val) => _periodStart = val;

  bool hasPeriodStart() => _periodStart != null;

  // "unitRate" field.
  double? _unitRate;
  double get unitRate => _unitRate ?? 0.0;
  set unitRate(double? val) => _unitRate = val;

  void incrementUnitRate(double amount) => unitRate = unitRate + amount;

  bool hasUnitRate() => _unitRate != null;

  // "standingCharge" field.
  double? _standingCharge;
  double get standingCharge => _standingCharge ?? 0.0;
  set standingCharge(double? val) => _standingCharge = val;

  void incrementStandingCharge(double amount) =>
      standingCharge = standingCharge + amount;

  bool hasStandingCharge() => _standingCharge != null;

  static SupplyTariffStruct fromMap(Map<String, dynamic> data) =>
      SupplyTariffStruct(
        periodStart: data['periodStart'] as DateTime?,
        unitRate: castToType<double>(data['unitRate']),
        standingCharge: castToType<double>(data['standingCharge']),
      );

  static SupplyTariffStruct? maybeFromMap(dynamic data) => data is Map
      ? SupplyTariffStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'periodStart': _periodStart,
        'unitRate': _unitRate,
        'standingCharge': _standingCharge,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'periodStart': serializeParam(
          _periodStart,
          ParamType.DateTime,
        ),
        'unitRate': serializeParam(
          _unitRate,
          ParamType.double,
        ),
        'standingCharge': serializeParam(
          _standingCharge,
          ParamType.double,
        ),
      }.withoutNulls;

  static SupplyTariffStruct fromSerializableMap(Map<String, dynamic> data) =>
      SupplyTariffStruct(
        periodStart: deserializeParam(
          data['periodStart'],
          ParamType.DateTime,
          false,
        ),
        unitRate: deserializeParam(
          data['unitRate'],
          ParamType.double,
          false,
        ),
        standingCharge: deserializeParam(
          data['standingCharge'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'SupplyTariffStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SupplyTariffStruct &&
        periodStart == other.periodStart &&
        unitRate == other.unitRate &&
        standingCharge == other.standingCharge;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([periodStart, unitRate, standingCharge]);
}

SupplyTariffStruct createSupplyTariffStruct({
  DateTime? periodStart,
  double? unitRate,
  double? standingCharge,
}) =>
    SupplyTariffStruct(
      periodStart: periodStart,
      unitRate: unitRate,
      standingCharge: standingCharge,
    );
