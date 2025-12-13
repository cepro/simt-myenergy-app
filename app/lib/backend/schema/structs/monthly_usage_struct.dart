// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyUsageStruct extends BaseStruct {
  MonthlyUsageStruct({
    double? usageHeat,
    double? usagePower,
    String? month,
    DateTime? monthDateTime,
  })  : _usageHeat = usageHeat,
        _usagePower = usagePower,
        _month = month,
        _monthDateTime = monthDateTime;

  // "usage_heat" field.
  double? _usageHeat;
  double get usageHeat => _usageHeat ?? 0.0;
  set usageHeat(double? val) => _usageHeat = val;

  // "monthDateTime" field.
  DateTime? _monthDateTime;
  DateTime? get monthDateTime => _monthDateTime;
  set monthDateTime(DateTime? val) => _monthDateTime = val;

  bool hasMonthDateTime() => _monthDateTime != null;

  void incrementUsageHeat(double amount) => usageHeat = usageHeat + amount;

  bool hasUsageHeat() => _usageHeat != null;

  // "usage_power" field.
  double? _usagePower;
  double get usagePower => _usagePower ?? 0.0;
  set usagePower(double? val) => _usagePower = val;

  void incrementUsagePower(double amount) => usagePower = usagePower + amount;

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
        monthDateTime: data['monthDateTime'] as DateTime?,
      );

  static MonthlyUsageStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyUsageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'usage_heat': _usageHeat,
        'usage_power': _usagePower,
        'month': _month,
        'monthDateTime': _monthDateTime,
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
        'monthDateTime': serializeParam(
          _monthDateTime,
          ParamType.DateTime,
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
        monthDateTime: deserializeParam(
          data['monthDateTime'],
          ParamType.DateTime,
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
        month == other.month &&
        monthDateTime == other.monthDateTime;
  }

  @override
  int get hashCode => const ListEquality().hash([usageHeat, usagePower, month, monthDateTime]);
}

MonthlyUsageStruct createMonthlyUsageStruct({
  double? usageHeat,
  double? usagePower,
  String? month,
  DateTime? monthDateTime,
}) =>
    MonthlyUsageStruct(
      usageHeat: usageHeat,
      usagePower: usagePower,
      month: month,
      monthDateTime: monthDateTime,
    );
