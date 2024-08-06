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
    SiteStruct? site,
    String? owner,
  })  : _id = id,
        _plot = plot,
        _description = description,
        _supplyMeterUUID = supplyMeterUUID,
        _solarMeterUUID = solarMeterUUID,
        _site = site,
        _owner = owner;

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

  // "site" field.
  SiteStruct? _site;
  SiteStruct get site => _site ?? SiteStruct();
  set site(SiteStruct? val) => _site = val;

  void updateSite(Function(SiteStruct) updateFn) {
    updateFn(_site ??= SiteStruct());
  }

  bool hasSite() => _site != null;

  // "owner" field.
  String? _owner;
  String get owner => _owner ?? '';
  set owner(String? val) => _owner = val;

  bool hasOwner() => _owner != null;

  static PropertyStruct fromMap(Map<String, dynamic> data) => PropertyStruct(
        id: data['id'] as String?,
        plot: data['plot'] as String?,
        description: data['description'] as String?,
        supplyMeterUUID: data['supplyMeterUUID'] as String?,
        solarMeterUUID: data['solarMeterUUID'] as String?,
        site: SiteStruct.maybeFromMap(data['site']),
        owner: data['owner'] as String?,
      );

  static PropertyStruct? maybeFromMap(dynamic data) =>
      data is Map ? PropertyStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'plot': _plot,
        'description': _description,
        'supplyMeterUUID': _supplyMeterUUID,
        'solarMeterUUID': _solarMeterUUID,
        'site': _site?.toMap(),
        'owner': _owner,
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
        'site': serializeParam(
          _site,
          ParamType.DataStruct,
        ),
        'owner': serializeParam(
          _owner,
          ParamType.String,
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
        site: deserializeStructParam(
          data['site'],
          ParamType.DataStruct,
          false,
          structBuilder: SiteStruct.fromSerializableMap,
        ),
        owner: deserializeParam(
          data['owner'],
          ParamType.String,
          false,
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
        site == other.site &&
        owner == other.owner;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, plot, description, supplyMeterUUID, solarMeterUUID, site, owner]);
}

PropertyStruct createPropertyStruct({
  String? id,
  String? plot,
  String? description,
  String? supplyMeterUUID,
  String? solarMeterUUID,
  SiteStruct? site,
  String? owner,
}) =>
    PropertyStruct(
      id: id,
      plot: plot,
      description: description,
      supplyMeterUUID: supplyMeterUUID,
      solarMeterUUID: solarMeterUUID,
      site: site ?? SiteStruct(),
      owner: owner,
    );
