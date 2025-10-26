// ignore_for_file: unnecessary_getters_setters


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
    String? ownerEmail,
    List<CustomerRoleStruct>? customerRoles,
    String? escoId,
    EscoStruct? escoDTO,
  })  : _id = id,
        _plot = plot,
        _description = description,
        _supplyMeterUUID = supplyMeterUUID,
        _solarMeterUUID = solarMeterUUID,
        _owner = owner,
        _ownerEmail = ownerEmail,
        _customerRoles = customerRoles,
        _escoId = escoId,
        _escoDTO = escoDTO;

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

  // "ownerEmail" field.
  String? _ownerEmail;
  String get ownerEmail => _ownerEmail ?? '';
  set ownerEmail(String? val) => _ownerEmail = val;

  bool hasOwnerEmail() => _ownerEmail != null;

  // "customerRoles" field.
  List<CustomerRoleStruct>? _customerRoles;
  List<CustomerRoleStruct> get customerRoles => _customerRoles ?? const [];
  set customerRoles(List<CustomerRoleStruct>? val) => _customerRoles = val;

  void updateCustomerRoles(Function(List<CustomerRoleStruct>) updateFn) {
    updateFn(_customerRoles ??= []);
  }

  bool hasCustomerRoles() => _customerRoles != null;

  // "escoId" field.
  String? _escoId;
  String get escoId => _escoId ?? '';
  set escoId(String? val) => _escoId = val;

  bool hasEscoId() => _escoId != null;

  // "escoDTO" field.
  EscoStruct? _escoDTO;
  EscoStruct get escoDTO => _escoDTO ?? EscoStruct();
  set escoDTO(EscoStruct? val) => _escoDTO = val;

  void updateEscoDTO(Function(EscoStruct) updateFn) {
    updateFn(_escoDTO ??= EscoStruct());
  }

  bool hasEscoDTO() => _escoDTO != null;

  static PropertyStruct fromMap(Map<String, dynamic> data) => PropertyStruct(
        id: data['id'] as String?,
        plot: data['plot'] as String?,
        description: data['description'] as String?,
        supplyMeterUUID: data['supplyMeterUUID'] as String?,
        solarMeterUUID: data['solarMeterUUID'] as String?,
        owner: data['owner'] as String?,
        ownerEmail: data['ownerEmail'] as String?,
        customerRoles: getStructList(
          data['customerRoles'],
          CustomerRoleStruct.fromMap,
        ),
        escoId: data['escoId'] as String?,
        escoDTO: data['escoDTO'] is EscoStruct
            ? data['escoDTO']
            : EscoStruct.maybeFromMap(data['escoDTO']),
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
        'ownerEmail': _ownerEmail,
        'customerRoles': _customerRoles?.map((e) => e.toMap()).toList(),
        'escoId': _escoId,
        'escoDTO': _escoDTO?.toMap(),
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
        'ownerEmail': serializeParam(
          _ownerEmail,
          ParamType.String,
        ),
        'customerRoles': serializeParam(
          _customerRoles,
          ParamType.DataStruct,
          isList: true,
        ),
        'escoId': serializeParam(
          _escoId,
          ParamType.String,
        ),
        'escoDTO': serializeParam(
          _escoDTO,
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
        ownerEmail: deserializeParam(
          data['ownerEmail'],
          ParamType.String,
          false,
        ),
        customerRoles: deserializeStructParam<CustomerRoleStruct>(
          data['customerRoles'],
          ParamType.DataStruct,
          true,
          structBuilder: CustomerRoleStruct.fromSerializableMap,
        ),
        escoId: deserializeParam(
          data['escoId'],
          ParamType.String,
          false,
        ),
        escoDTO: deserializeStructParam(
          data['escoDTO'],
          ParamType.DataStruct,
          false,
          structBuilder: EscoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PropertyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PropertyStruct &&
        id == other.id &&
        plot == other.plot &&
        description == other.description &&
        supplyMeterUUID == other.supplyMeterUUID &&
        solarMeterUUID == other.solarMeterUUID &&
        owner == other.owner &&
        ownerEmail == other.ownerEmail &&
        listEquality.equals(customerRoles, other.customerRoles) &&
        escoId == other.escoId &&
        escoDTO == other.escoDTO;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        plot,
        description,
        supplyMeterUUID,
        solarMeterUUID,
        owner,
        ownerEmail,
        customerRoles,
        escoId,
        escoDTO
      ]);
}

PropertyStruct createPropertyStruct({
  String? id,
  String? plot,
  String? description,
  String? supplyMeterUUID,
  String? solarMeterUUID,
  String? owner,
  String? ownerEmail,
  String? escoId,
  EscoStruct? escoDTO,
}) =>
    PropertyStruct(
      id: id,
      plot: plot,
      description: description,
      supplyMeterUUID: supplyMeterUUID,
      solarMeterUUID: solarMeterUUID,
      owner: owner,
      ownerEmail: ownerEmail,
      escoId: escoId,
      escoDTO: escoDTO ?? EscoStruct(),
    );
