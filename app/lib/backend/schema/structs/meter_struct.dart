// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MeterStruct extends BaseStruct {
  MeterStruct({
    String? id,
    String? serial,
    bool? prepayEnabled,
    double? balance,
  })  : _id = id,
        _serial = serial,
        _prepayEnabled = prepayEnabled,
        _balance = balance;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "serial" field.
  String? _serial;
  String get serial => _serial ?? '';
  set serial(String? val) => _serial = val;

  bool hasSerial() => _serial != null;

  // "prepayEnabled" field.
  bool? _prepayEnabled;
  bool get prepayEnabled => _prepayEnabled ?? false;
  set prepayEnabled(bool? val) => _prepayEnabled = val;

  bool hasPrepayEnabled() => _prepayEnabled != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  set balance(double? val) => _balance = val;

  void incrementBalance(double amount) => balance = balance + amount;

  bool hasBalance() => _balance != null;

  static MeterStruct fromMap(Map<String, dynamic> data) => MeterStruct(
        id: data['id'] as String?,
        serial: data['serial'] as String?,
        prepayEnabled: data['prepayEnabled'] as bool?,
        balance: castToType<double>(data['balance']),
      );

  static MeterStruct? maybeFromMap(dynamic data) =>
      data is Map ? MeterStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'serial': _serial,
        'prepayEnabled': _prepayEnabled,
        'balance': _balance,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'serial': serializeParam(
          _serial,
          ParamType.String,
        ),
        'prepayEnabled': serializeParam(
          _prepayEnabled,
          ParamType.bool,
        ),
        'balance': serializeParam(
          _balance,
          ParamType.double,
        ),
      }.withoutNulls;

  static MeterStruct fromSerializableMap(Map<String, dynamic> data) =>
      MeterStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        serial: deserializeParam(
          data['serial'],
          ParamType.String,
          false,
        ),
        prepayEnabled: deserializeParam(
          data['prepayEnabled'],
          ParamType.bool,
          false,
        ),
        balance: deserializeParam(
          data['balance'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'MeterStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MeterStruct &&
        id == other.id &&
        serial == other.serial &&
        prepayEnabled == other.prepayEnabled &&
        balance == other.balance;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, serial, prepayEnabled, balance]);
}

MeterStruct createMeterStruct({
  String? id,
  String? serial,
  bool? prepayEnabled,
  double? balance,
}) =>
    MeterStruct(
      id: id,
      serial: serial,
      prepayEnabled: prepayEnabled,
      balance: balance,
    );
