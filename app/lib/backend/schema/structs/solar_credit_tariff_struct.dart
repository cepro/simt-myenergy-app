// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SolarCreditTariffStruct extends BaseStruct {
  SolarCreditTariffStruct({
    DateTime? periodStart,
    double? creditPencePerYear,
  })  : _periodStart = periodStart,
        _creditPencePerYear = creditPencePerYear;

  // "periodStart" field.
  DateTime? _periodStart;
  DateTime? get periodStart => _periodStart;
  set periodStart(DateTime? val) => _periodStart = val;

  bool hasPeriodStart() => _periodStart != null;

  // "creditPencePerYear" field.
  double? _creditPencePerYear;
  double get creditPencePerYear => _creditPencePerYear ?? 0.0;
  set creditPencePerYear(double? val) => _creditPencePerYear = val;

  void incrementCreditPencePerYear(double amount) =>
      creditPencePerYear = creditPencePerYear + amount;

  bool hasCreditPencePerYear() => _creditPencePerYear != null;

  static SolarCreditTariffStruct fromMap(Map<String, dynamic> data) =>
      SolarCreditTariffStruct(
        periodStart: data['periodStart'] as DateTime?,
        creditPencePerYear: castToType<double>(data['creditPencePerYear']),
      );

  static SolarCreditTariffStruct? maybeFromMap(dynamic data) => data is Map
      ? SolarCreditTariffStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'periodStart': _periodStart,
        'creditPencePerYear': _creditPencePerYear,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'periodStart': serializeParam(
          _periodStart,
          ParamType.DateTime,
        ),
        'creditPencePerYear': serializeParam(
          _creditPencePerYear,
          ParamType.double,
        ),
      }.withoutNulls;

  static SolarCreditTariffStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SolarCreditTariffStruct(
        periodStart: deserializeParam(
          data['periodStart'],
          ParamType.DateTime,
          false,
        ),
        creditPencePerYear: deserializeParam(
          data['creditPencePerYear'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'SolarCreditTariffStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SolarCreditTariffStruct &&
        periodStart == other.periodStart &&
        creditPencePerYear == other.creditPencePerYear;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([periodStart, creditPencePerYear]);
}

SolarCreditTariffStruct createSolarCreditTariffStruct({
  DateTime? periodStart,
  double? creditPencePerYear,
}) =>
    SolarCreditTariffStruct(
      periodStart: periodStart,
      creditPencePerYear: creditPencePerYear,
    );
