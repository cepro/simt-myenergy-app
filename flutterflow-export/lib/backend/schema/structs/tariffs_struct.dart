// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TariffsStruct extends BaseStruct {
  TariffsStruct({
    List<TariffStruct>? benchmarkTariffs,
    List<TariffStruct>? microgridTariffs,
    List<TariffStruct>? customerTariffs,
  })  : _benchmarkTariffs = benchmarkTariffs,
        _microgridTariffs = microgridTariffs,
        _customerTariffs = customerTariffs;

  // "benchmarkTariffs" field.
  List<TariffStruct>? _benchmarkTariffs;
  List<TariffStruct> get benchmarkTariffs => _benchmarkTariffs ?? const [];
  set benchmarkTariffs(List<TariffStruct>? val) => _benchmarkTariffs = val;

  void updateBenchmarkTariffs(Function(List<TariffStruct>) updateFn) {
    updateFn(_benchmarkTariffs ??= []);
  }

  bool hasBenchmarkTariffs() => _benchmarkTariffs != null;

  // "microgridTariffs" field.
  List<TariffStruct>? _microgridTariffs;
  List<TariffStruct> get microgridTariffs => _microgridTariffs ?? const [];
  set microgridTariffs(List<TariffStruct>? val) => _microgridTariffs = val;

  void updateMicrogridTariffs(Function(List<TariffStruct>) updateFn) {
    updateFn(_microgridTariffs ??= []);
  }

  bool hasMicrogridTariffs() => _microgridTariffs != null;

  // "customerTariffs" field.
  List<TariffStruct>? _customerTariffs;
  List<TariffStruct> get customerTariffs => _customerTariffs ?? const [];
  set customerTariffs(List<TariffStruct>? val) => _customerTariffs = val;

  void updateCustomerTariffs(Function(List<TariffStruct>) updateFn) {
    updateFn(_customerTariffs ??= []);
  }

  bool hasCustomerTariffs() => _customerTariffs != null;

  static TariffsStruct fromMap(Map<String, dynamic> data) => TariffsStruct(
        benchmarkTariffs: getStructList(
          data['benchmarkTariffs'],
          TariffStruct.fromMap,
        ),
        microgridTariffs: getStructList(
          data['microgridTariffs'],
          TariffStruct.fromMap,
        ),
        customerTariffs: getStructList(
          data['customerTariffs'],
          TariffStruct.fromMap,
        ),
      );

  static TariffsStruct? maybeFromMap(dynamic data) =>
      data is Map ? TariffsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'benchmarkTariffs': _benchmarkTariffs?.map((e) => e.toMap()).toList(),
        'microgridTariffs': _microgridTariffs?.map((e) => e.toMap()).toList(),
        'customerTariffs': _customerTariffs?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'benchmarkTariffs': serializeParam(
          _benchmarkTariffs,
          ParamType.DataStruct,
          isList: true,
        ),
        'microgridTariffs': serializeParam(
          _microgridTariffs,
          ParamType.DataStruct,
          isList: true,
        ),
        'customerTariffs': serializeParam(
          _customerTariffs,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TariffsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TariffsStruct(
        benchmarkTariffs: deserializeStructParam<TariffStruct>(
          data['benchmarkTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: TariffStruct.fromSerializableMap,
        ),
        microgridTariffs: deserializeStructParam<TariffStruct>(
          data['microgridTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: TariffStruct.fromSerializableMap,
        ),
        customerTariffs: deserializeStructParam<TariffStruct>(
          data['customerTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: TariffStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TariffsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TariffsStruct &&
        listEquality.equals(benchmarkTariffs, other.benchmarkTariffs) &&
        listEquality.equals(microgridTariffs, other.microgridTariffs) &&
        listEquality.equals(customerTariffs, other.customerTariffs);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([benchmarkTariffs, microgridTariffs, customerTariffs]);
}

TariffsStruct createTariffsStruct() => TariffsStruct();
