// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyCostStruct extends BaseStruct {
  MonthlyCostStruct({
    String? month,
    double? costHeat,
    double? costPower,
  })  : _month = month,
        _costHeat = costHeat,
        _costPower = costPower;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  set month(String? val) => _month = val;

  bool hasMonth() => _month != null;

  // "cost_heat" field.
  double? _costHeat;
  double get costHeat => _costHeat ?? 0.0;
  set costHeat(double? val) => _costHeat = val;

  void incrementCostHeat(double amount) => costHeat = costHeat + amount;

  bool hasCostHeat() => _costHeat != null;

  // "cost_power" field.
  double? _costPower;
  double get costPower => _costPower ?? 0.0;
  set costPower(double? val) => _costPower = val;

  void incrementCostPower(double amount) => costPower = costPower + amount;

  bool hasCostPower() => _costPower != null;

  static MonthlyCostStruct fromMap(Map<String, dynamic> data) =>
      MonthlyCostStruct(
        month: data['month'] as String?,
        costHeat: castToType<double>(data['cost_heat']),
        costPower: castToType<double>(data['cost_power']),
      );

  static MonthlyCostStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyCostStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'month': _month,
        'cost_heat': _costHeat,
        'cost_power': _costPower,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'month': serializeParam(
          _month,
          ParamType.String,
        ),
        'cost_heat': serializeParam(
          _costHeat,
          ParamType.double,
        ),
        'cost_power': serializeParam(
          _costPower,
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
        costHeat: deserializeParam(
          data['cost_heat'],
          ParamType.double,
          false,
        ),
        costPower: deserializeParam(
          data['cost_power'],
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
        costHeat == other.costHeat &&
        costPower == other.costPower;
  }

  @override
  int get hashCode => const ListEquality().hash([month, costHeat, costPower]);
}

MonthlyCostStruct createMonthlyCostStruct({
  String? month,
  double? costHeat,
  double? costPower,
}) =>
    MonthlyCostStruct(
      month: month,
      costHeat: costHeat,
      costPower: costPower,
    );
