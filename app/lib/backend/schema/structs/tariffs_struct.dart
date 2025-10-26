// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TariffsStruct extends BaseStruct {
  TariffsStruct({
    List<SupplyTariffStruct>? benchmarkTariffs,
    List<SupplyTariffStruct>? microgridTariffs,
    List<SupplyTariffStruct>? customerTariffs,
    List<SolarCreditTariffStruct>? solarCreditTariffs,
  })  : _benchmarkTariffs = benchmarkTariffs,
        _microgridTariffs = microgridTariffs,
        _customerTariffs = customerTariffs,
        _solarCreditTariffs = solarCreditTariffs;

  // "benchmarkTariffs" field.
  List<SupplyTariffStruct>? _benchmarkTariffs;
  List<SupplyTariffStruct> get benchmarkTariffs =>
      _benchmarkTariffs ?? const [];
  set benchmarkTariffs(List<SupplyTariffStruct>? val) =>
      _benchmarkTariffs = val;

  void updateBenchmarkTariffs(Function(List<SupplyTariffStruct>) updateFn) {
    updateFn(_benchmarkTariffs ??= []);
  }

  bool hasBenchmarkTariffs() => _benchmarkTariffs != null;

  // "microgridTariffs" field.
  List<SupplyTariffStruct>? _microgridTariffs;
  List<SupplyTariffStruct> get microgridTariffs =>
      _microgridTariffs ?? const [];
  set microgridTariffs(List<SupplyTariffStruct>? val) =>
      _microgridTariffs = val;

  void updateMicrogridTariffs(Function(List<SupplyTariffStruct>) updateFn) {
    updateFn(_microgridTariffs ??= []);
  }

  bool hasMicrogridTariffs() => _microgridTariffs != null;

  // "customerTariffs" field.
  List<SupplyTariffStruct>? _customerTariffs;
  List<SupplyTariffStruct> get customerTariffs => _customerTariffs ?? const [];
  set customerTariffs(List<SupplyTariffStruct>? val) => _customerTariffs = val;

  void updateCustomerTariffs(Function(List<SupplyTariffStruct>) updateFn) {
    updateFn(_customerTariffs ??= []);
  }

  bool hasCustomerTariffs() => _customerTariffs != null;

  // "solarCreditTariffs" field.
  List<SolarCreditTariffStruct>? _solarCreditTariffs;
  List<SolarCreditTariffStruct> get solarCreditTariffs =>
      _solarCreditTariffs ?? const [];
  set solarCreditTariffs(List<SolarCreditTariffStruct>? val) =>
      _solarCreditTariffs = val;

  void updateSolarCreditTariffs(
      Function(List<SolarCreditTariffStruct>) updateFn) {
    updateFn(_solarCreditTariffs ??= []);
  }

  bool hasSolarCreditTariffs() => _solarCreditTariffs != null;

  static TariffsStruct fromMap(Map<String, dynamic> data) => TariffsStruct(
        benchmarkTariffs: getStructList(
          data['benchmarkTariffs'],
          SupplyTariffStruct.fromMap,
        ),
        microgridTariffs: getStructList(
          data['microgridTariffs'],
          SupplyTariffStruct.fromMap,
        ),
        customerTariffs: getStructList(
          data['customerTariffs'],
          SupplyTariffStruct.fromMap,
        ),
        solarCreditTariffs: getStructList(
          data['solarCreditTariffs'],
          SolarCreditTariffStruct.fromMap,
        ),
      );

  static TariffsStruct? maybeFromMap(dynamic data) =>
      data is Map ? TariffsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'benchmarkTariffs': _benchmarkTariffs?.map((e) => e.toMap()).toList(),
        'microgridTariffs': _microgridTariffs?.map((e) => e.toMap()).toList(),
        'customerTariffs': _customerTariffs?.map((e) => e.toMap()).toList(),
        'solarCreditTariffs':
            _solarCreditTariffs?.map((e) => e.toMap()).toList(),
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
        'solarCreditTariffs': serializeParam(
          _solarCreditTariffs,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TariffsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TariffsStruct(
        benchmarkTariffs: deserializeStructParam<SupplyTariffStruct>(
          data['benchmarkTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: SupplyTariffStruct.fromSerializableMap,
        ),
        microgridTariffs: deserializeStructParam<SupplyTariffStruct>(
          data['microgridTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: SupplyTariffStruct.fromSerializableMap,
        ),
        customerTariffs: deserializeStructParam<SupplyTariffStruct>(
          data['customerTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: SupplyTariffStruct.fromSerializableMap,
        ),
        solarCreditTariffs: deserializeStructParam<SolarCreditTariffStruct>(
          data['solarCreditTariffs'],
          ParamType.DataStruct,
          true,
          structBuilder: SolarCreditTariffStruct.fromSerializableMap,
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
        listEquality.equals(customerTariffs, other.customerTariffs) &&
        listEquality.equals(solarCreditTariffs, other.solarCreditTariffs);
  }

  @override
  int get hashCode => const ListEquality().hash([
        benchmarkTariffs,
        microgridTariffs,
        customerTariffs,
        solarCreditTariffs
      ]);
}

TariffsStruct createTariffsStruct() => TariffsStruct();
