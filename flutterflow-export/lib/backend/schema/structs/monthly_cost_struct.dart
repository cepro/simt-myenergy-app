// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyCostStruct extends BaseStruct {
  MonthlyCostStruct({
    String? month,
    double? power,
    double? heat,
    double? standingCharge,
    double? total,
    double? microgridPower,
    double? microgridHeat,
    double? microgridStandingCharge,
    double? microgridTotal,
    double? benchmarkPower,
    double? benchmarkHeat,
    double? benchmarkStandingCharge,
    double? benchmarkTotal,
  })  : _month = month,
        _power = power,
        _heat = heat,
        _standingCharge = standingCharge,
        _total = total,
        _microgridPower = microgridPower,
        _microgridHeat = microgridHeat,
        _microgridStandingCharge = microgridStandingCharge,
        _microgridTotal = microgridTotal,
        _benchmarkPower = benchmarkPower,
        _benchmarkHeat = benchmarkHeat,
        _benchmarkStandingCharge = benchmarkStandingCharge,
        _benchmarkTotal = benchmarkTotal;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;

  bool hasMonth() => _month != null;

  // "power" field.
  double? _power;
  double get power => _power ?? 0.0;
  set power(double? val) => _power = val;

  void incrementPower(double amount) => power = power + amount;

  bool hasPower() => _power != null;

  // "heat" field.
  double? _heat;
  double get heat => _heat ?? 0.0;
  set heat(double? val) => _heat = val;

  void incrementHeat(double amount) => heat = heat + amount;

  bool hasHeat() => _heat != null;

  // "standing_charge" field.
  double? _standingCharge;
  double get standingCharge => _standingCharge ?? 0.0;
  set standingCharge(double? val) => _standingCharge = val;

  void incrementStandingCharge(double amount) =>
      standingCharge = standingCharge + amount;

  bool hasStandingCharge() => _standingCharge != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  set total(double? val) => _total = val;

  void incrementTotal(double amount) => total = total + amount;

  bool hasTotal() => _total != null;

  // "microgrid_power" field.
  double? _microgridPower;
  double get microgridPower => _microgridPower ?? 0.0;
  set microgridPower(double? val) => _microgridPower = val;

  void incrementMicrogridPower(double amount) =>
      microgridPower = microgridPower + amount;

  bool hasMicrogridPower() => _microgridPower != null;

  // "microgrid_heat" field.
  double? _microgridHeat;
  double get microgridHeat => _microgridHeat ?? 0.0;
  set microgridHeat(double? val) => _microgridHeat = val;

  void incrementMicrogridHeat(double amount) =>
      microgridHeat = microgridHeat + amount;

  bool hasMicrogridHeat() => _microgridHeat != null;

  // "microgrid_standing_charge" field.
  double? _microgridStandingCharge;
  double get microgridStandingCharge => _microgridStandingCharge ?? 0.0;
  set microgridStandingCharge(double? val) => _microgridStandingCharge = val;

  void incrementMicrogridStandingCharge(double amount) =>
      microgridStandingCharge = microgridStandingCharge + amount;

  bool hasMicrogridStandingCharge() => _microgridStandingCharge != null;

  // "microgrid_total" field.
  double? _microgridTotal;
  double get microgridTotal => _microgridTotal ?? 0.0;
  set microgridTotal(double? val) => _microgridTotal = val;

  void incrementMicrogridTotal(double amount) =>
      microgridTotal = microgridTotal + amount;

  bool hasMicrogridTotal() => _microgridTotal != null;

  // "benchmark_power" field.
  double? _benchmarkPower;
  double get benchmarkPower => _benchmarkPower ?? 0.0;
  set benchmarkPower(double? val) => _benchmarkPower = val;

  void incrementBenchmarkPower(double amount) =>
      benchmarkPower = benchmarkPower + amount;

  bool hasBenchmarkPower() => _benchmarkPower != null;

  // "benchmark_heat" field.
  double? _benchmarkHeat;
  double get benchmarkHeat => _benchmarkHeat ?? 0.0;
  set benchmarkHeat(double? val) => _benchmarkHeat = val;

  void incrementBenchmarkHeat(double amount) =>
      benchmarkHeat = benchmarkHeat + amount;

  bool hasBenchmarkHeat() => _benchmarkHeat != null;

  // "benchmark_standing_charge" field.
  double? _benchmarkStandingCharge;
  double get benchmarkStandingCharge => _benchmarkStandingCharge ?? 0.0;
  set benchmarkStandingCharge(double? val) => _benchmarkStandingCharge = val;

  void incrementBenchmarkStandingCharge(double amount) =>
      benchmarkStandingCharge = benchmarkStandingCharge + amount;

  bool hasBenchmarkStandingCharge() => _benchmarkStandingCharge != null;

  // "benchmark_total" field.
  double? _benchmarkTotal;
  double get benchmarkTotal => _benchmarkTotal ?? 0.0;
  set benchmarkTotal(double? val) => _benchmarkTotal = val;

  void incrementBenchmarkTotal(double amount) =>
      benchmarkTotal = benchmarkTotal + amount;

  bool hasBenchmarkTotal() => _benchmarkTotal != null;

  static MonthlyCostStruct fromMap(Map<String, dynamic> data) =>
      MonthlyCostStruct(
        month: data['month'] as String?,
        power: castToType<double>(data['power']),
        heat: castToType<double>(data['heat']),
        standingCharge: castToType<double>(data['standing_charge']),
        total: castToType<double>(data['total']),
        microgridPower: castToType<double>(data['microgrid_power']),
        microgridHeat: castToType<double>(data['microgrid_heat']),
        microgridStandingCharge:
            castToType<double>(data['microgrid_standing_charge']),
        microgridTotal: castToType<double>(data['microgrid_total']),
        benchmarkPower: castToType<double>(data['benchmark_power']),
        benchmarkHeat: castToType<double>(data['benchmark_heat']),
        benchmarkStandingCharge:
            castToType<double>(data['benchmark_standing_charge']),
        benchmarkTotal: castToType<double>(data['benchmark_total']),
      );

  static MonthlyCostStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyCostStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'power': _power,
        'heat': _heat,
        'standing_charge': _standingCharge,
        'total': _total,
        'microgrid_power': _microgridPower,
        'microgrid_heat': _microgridHeat,
        'microgrid_standing_charge': _microgridStandingCharge,
        'microgrid_total': _microgridTotal,
        'benchmark_power': _benchmarkPower,
        'benchmark_heat': _benchmarkHeat,
        'benchmark_standing_charge': _benchmarkStandingCharge,
        'benchmark_total': _benchmarkTotal,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
        'power': serializeParam(
          _power,
          ParamType.double,
        ),
        'heat': serializeParam(
          _heat,
          ParamType.double,
        ),
        'standing_charge': serializeParam(
          _standingCharge,
          ParamType.double,
        ),
        'total': serializeParam(
          _total,
          ParamType.double,
        ),
        'microgrid_power': serializeParam(
          _microgridPower,
          ParamType.double,
        ),
        'microgrid_heat': serializeParam(
          _microgridHeat,
          ParamType.double,
        ),
        'microgrid_standing_charge': serializeParam(
          _microgridStandingCharge,
          ParamType.double,
        ),
        'microgrid_total': serializeParam(
          _microgridTotal,
          ParamType.double,
        ),
        'benchmark_power': serializeParam(
          _benchmarkPower,
          ParamType.double,
        ),
        'benchmark_heat': serializeParam(
          _benchmarkHeat,
          ParamType.double,
        ),
        'benchmark_standing_charge': serializeParam(
          _benchmarkStandingCharge,
          ParamType.double,
        ),
        'benchmark_total': serializeParam(
          _benchmarkTotal,
          ParamType.double,
        ),
      }.withoutNulls;

  static MonthlyCostStruct fromSerializableMap(Map<String, dynamic> data) =>
      MonthlyCostStruct(
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
        power: deserializeParam(
          data['power'],
          ParamType.double,
          false,
        ),
        heat: deserializeParam(
          data['heat'],
          ParamType.double,
          false,
        ),
        standingCharge: deserializeParam(
          data['standing_charge'],
          ParamType.double,
          false,
        ),
        total: deserializeParam(
          data['total'],
          ParamType.double,
          false,
        ),
        microgridPower: deserializeParam(
          data['microgrid_power'],
          ParamType.double,
          false,
        ),
        microgridHeat: deserializeParam(
          data['microgrid_heat'],
          ParamType.double,
          false,
        ),
        microgridStandingCharge: deserializeParam(
          data['microgrid_standing_charge'],
          ParamType.double,
          false,
        ),
        microgridTotal: deserializeParam(
          data['microgrid_total'],
          ParamType.double,
          false,
        ),
        benchmarkPower: deserializeParam(
          data['benchmark_power'],
          ParamType.double,
          false,
        ),
        benchmarkHeat: deserializeParam(
          data['benchmark_heat'],
          ParamType.double,
          false,
        ),
        benchmarkStandingCharge: deserializeParam(
          data['benchmark_standing_charge'],
          ParamType.double,
          false,
        ),
        benchmarkTotal: deserializeParam(
          data['benchmark_total'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'MonthlyCostStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MonthlyCostStruct &&
        month == other.month &&
        power == other.power &&
        heat == other.heat &&
        standingCharge == other.standingCharge &&
        total == other.total &&
        microgridPower == other.microgridPower &&
        microgridHeat == other.microgridHeat &&
        microgridStandingCharge == other.microgridStandingCharge &&
        microgridTotal == other.microgridTotal &&
        benchmarkPower == other.benchmarkPower &&
        benchmarkHeat == other.benchmarkHeat &&
        benchmarkStandingCharge == other.benchmarkStandingCharge &&
        benchmarkTotal == other.benchmarkTotal;
  }

  @override
  int get hashCode => const ListEquality().hash([
        month,
        power,
        heat,
        standingCharge,
        total,
        microgridPower,
        microgridHeat,
        microgridStandingCharge,
        microgridTotal,
        benchmarkPower,
        benchmarkHeat,
        benchmarkStandingCharge,
        benchmarkTotal
      ]);
}

MonthlyCostStruct createMonthlyCostStruct({
  String? month,
  double? power,
  double? heat,
  double? standingCharge,
  double? total,
  double? microgridPower,
  double? microgridHeat,
  double? microgridStandingCharge,
  double? microgridTotal,
  double? benchmarkPower,
  double? benchmarkHeat,
  double? benchmarkStandingCharge,
  double? benchmarkTotal,
}) =>
    MonthlyCostStruct(
      month: month,
      power: power,
      heat: heat,
      standingCharge: standingCharge,
      total: total,
      microgridPower: microgridPower,
      microgridHeat: microgridHeat,
      microgridStandingCharge: microgridStandingCharge,
      microgridTotal: microgridTotal,
      benchmarkPower: benchmarkPower,
      benchmarkHeat: benchmarkHeat,
      benchmarkStandingCharge: benchmarkStandingCharge,
      benchmarkTotal: benchmarkTotal,
    );
