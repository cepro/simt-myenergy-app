// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PropertyStruct extends BaseStruct {
  PropertyStruct({
    String? id,
    String? plot,
    String? description,
    String? supplyMeterUUID,
    String? solarMeterUUID,
    String? owner,
    EscoStruct? esco,
  })  : _id = id,
        _plot = plot,
        _description = description,
        _supplyMeterUUID = supplyMeterUUID,
        _solarMeterUUID = solarMeterUUID,
        _owner = owner,
        _esco = esco;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "plot" field.
  String? _plot;
  String get plot => _plot ?? '';
  set plot(String? val) => _plot = val;

  bool hasPlot() => _plot != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "supplyMeterUUID" field.
  String? _supplyMeterUUID;
  String get supplyMeterUUID => _supplyMeterUUID ?? '';
  set supplyMeterUUID(String? val) => _supplyMeterUUID = val;

  bool hasSupplyMeterUUID() => _supplyMeterUUID != null;

  // "solarMeterUUID" field.
  String? _solarMeterUUID;
  String get solarMeterUUID => _solarMeterUUID ?? '';
  set solarMeterUUID(String? val) => _solarMeterUUID = val;

  bool hasSolarMeterUUID() => _solarMeterUUID != null;

  // "owner" field.
  String? _owner;
  String get owner => _owner ?? '';
  set owner(String? val) => _owner = val;

  bool hasOwner() => _owner != null;

  // "esco" field.
  EscoStruct? _esco;
  EscoStruct get esco => _esco ?? EscoStruct();
  set esco(EscoStruct? val) => _esco = val;

  void updateEsco(Function(EscoStruct) updateFn) {
    updateFn(_esco ??= EscoStruct());
  }

  bool hasEsco() => _esco != null;

  static PropertyStruct fromMap(Map<String, dynamic> data) => PropertyStruct(
        id: data['id'] as String?,
        plot: data['plot'] as String?,
        description: data['description'] as String?,
        supplyMeterUUID: data['supplyMeterUUID'] as String?,
        solarMeterUUID: data['solarMeterUUID'] as String?,
        owner: data['owner'] as String?,
        esco: EscoStruct.maybeFromMap(data['esco']),
      );

  static PropertyStruct? maybeFromMap(dynamic data) =>
      data is Map ? PropertyStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'plot': _plot,
        'description': _description,
        'supplyMeterUUID': _supplyMeterUUID,
        'solarMeterUUID': _solarMeterUUID,
        'owner': _owner,
        'esco': _esco?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'plot': serializeParam(
          _plot,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'supplyMeterUUID': serializeParam(
          _supplyMeterUUID,
          ParamType.String,
        ),
        'solarMeterUUID': serializeParam(
          _solarMeterUUID,
          ParamType.String,
        ),
        'owner': serializeParam(
          _owner,
          ParamType.String,
        ),
        'esco': serializeParam(
          _esco,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static PropertyStruct fromSerializableMap(Map<String, dynamic> data) =>
      PropertyStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        plot: deserializeParam(
          data['plot'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        supplyMeterUUID: deserializeParam(
          data['supplyMeterUUID'],
          ParamType.String,
          false,
        ),
        solarMeterUUID: deserializeParam(
          data['solarMeterUUID'],
          ParamType.String,
          false,
        ),
        owner: deserializeParam(
          data['owner'],
          ParamType.String,
          false,
        ),
        esco: deserializeStructParam(
          data['esco'],
          ParamType.DataStruct,
          false,
          structBuilder: EscoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PropertyStruct &&
        id == other.id &&
        plot == other.plot &&
        description == other.description &&
        supplyMeterUUID == other.supplyMeterUUID &&
        solarMeterUUID == other.solarMeterUUID &&
        owner == other.owner &&
        esco == other.esco;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, plot, description, supplyMeterUUID, solarMeterUUID, owner, esco]);
}

PropertyStruct createPropertyStruct({
  String? id,
  String? plot,
  String? description,
  String? supplyMeterUUID,
  String? solarMeterUUID,
  String? owner,
  EscoStruct? esco,
}) =>
    PropertyStruct(
      id: id,
      plot: plot,
      description: description,
      supplyMeterUUID: supplyMeterUUID,
      solarMeterUUID: solarMeterUUID,
      owner: owner,
      esco: esco ?? EscoStruct(),
    );
