// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyUsageStruct extends BaseStruct {
  MonthlyUsageStruct({
    double? usageHeat,
    double? usagePower,
    String? month,
  })  : _usageHeat = usageHeat,
        _usagePower = usagePower,
        _month = month;

  // "usage_heat" field.
  double? _usageHeat;
  double get usageHeat => _usageHeat ?? 0.0;
  set usageHeat(double? val) => _usageHeat = val;
  void incrementUsageHeat(double amount) => _usageHeat = usageHeat + amount;
  bool hasUsageHeat() => _usageHeat != null;

  // "usage_power" field.
  double? _usagePower;
  double get usagePower => _usagePower ?? 0.0;
  set usagePower(double? val) => _usagePower = val;
  void incrementUsagePower(double amount) => _usagePower = usagePower + amount;
  bool hasUsagePower() => _usagePower != null;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;
  bool hasMonth() => _month != null;

  static MonthlyUsageStruct fromMap(Map<String, dynamic> data) =>
      MonthlyUsageStruct(
        usageHeat: castToType<double>(data['usage_heat']),
        usagePower: castToType<double>(data['usage_power']),
        month: data['month'] as String?,
      );

  static MonthlyUsageStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyUsageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'usage_heat': _usageHeat,
        'usage_power': _usagePower,
        'month': _month,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'usage_heat': serializeParam(
          _usageHeat,
          ParamType.double,
        ),
        'usage_power': serializeParam(
          _usagePower,
          ParamType.double,
        ),
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
      }.withoutNulls;

  static MonthlyUsageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MonthlyUsageStruct(
        usageHeat: deserializeParam(
          data['usage_heat'],
          ParamType.double,
          false,
        ),
        usagePower: deserializeParam(
          data['usage_power'],
          ParamType.double,
          false,
        ),
        month: deserializeParam(
          data['month'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MonthlyUsageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MonthlyUsageStruct &&
        usageHeat == other.usageHeat &&
        usagePower == other.usagePower &&
        month == other.month;
  }

  @override
  int get hashCode => const ListEquality().hash([usageHeat, usagePower, month]);
}

MonthlyUsageStruct createMonthlyUsageStruct({
  double? usageHeat,
  double? usagePower,
  String? month,
}) =>
    MonthlyUsageStruct(
      usageHeat: usageHeat,
      usagePower: usagePower,
      month: month,
    );
