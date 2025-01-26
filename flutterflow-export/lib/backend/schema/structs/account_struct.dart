// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AccountStruct extends BaseStruct {
  AccountStruct({
    String? id,
    int? accountNumber,
    PropertyStruct? property,
    ContractStruct? contract,
    String? status,
    String? type,
    String? name,
    String? endDate,
  })  : _id = id,
        _accountNumber = accountNumber,
        _property = property,
        _contract = contract,
        _status = status,
        _type = type,
        _name = name,
        _endDate = endDate;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "accountNumber" field.
  int? _accountNumber;
  int get accountNumber => _accountNumber ?? 0;
  set accountNumber(int? val) => _accountNumber = val;

  void incrementAccountNumber(int amount) =>
      accountNumber = accountNumber + amount;

  bool hasAccountNumber() => _accountNumber != null;

  // "property" field.
  PropertyStruct? _property;
  PropertyStruct get property => _property ?? PropertyStruct();
  set property(PropertyStruct? val) => _property = val;

  void updateProperty(Function(PropertyStruct) updateFn) {
    updateFn(_property ??= PropertyStruct());
  }

  bool hasProperty() => _property != null;

  // "contract" field.
  ContractStruct? _contract;
  ContractStruct get contract => _contract ?? ContractStruct();
  set contract(ContractStruct? val) => _contract = val;

  void updateContract(Function(ContractStruct) updateFn) {
    updateFn(_contract ??= ContractStruct());
  }

  bool hasContract() => _contract != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "endDate" field.
  String? _endDate;
  String get endDate => _endDate ?? '';
  set endDate(String? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  static AccountStruct fromMap(Map<String, dynamic> data) => AccountStruct(
        id: data['id'] as String?,
        accountNumber: castToType<int>(data['accountNumber']),
        property: data['property'] is PropertyStruct
            ? data['property']
            : PropertyStruct.maybeFromMap(data['property']),
        contract: data['contract'] is ContractStruct
            ? data['contract']
            : ContractStruct.maybeFromMap(data['contract']),
        status: data['status'] as String?,
        type: data['type'] as String?,
        name: data['name'] as String?,
        endDate: data['endDate'] as String?,
      );

  static AccountStruct? maybeFromMap(dynamic data) =>
      data is Map ? AccountStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'accountNumber': _accountNumber,
        'property': _property?.toMap(),
        'contract': _contract?.toMap(),
        'status': _status,
        'type': _type,
        'name': _name,
        'endDate': _endDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'accountNumber': serializeParam(
          _accountNumber,
          ParamType.int,
        ),
        'property': serializeParam(
          _property,
          ParamType.DataStruct,
        ),
        'contract': serializeParam(
          _contract,
          ParamType.DataStruct,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'endDate': serializeParam(
          _endDate,
          ParamType.String,
        ),
      }.withoutNulls;

  static AccountStruct fromSerializableMap(Map<String, dynamic> data) =>
      AccountStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        accountNumber: deserializeParam(
          data['accountNumber'],
          ParamType.int,
          false,
        ),
        property: deserializeStructParam(
          data['property'],
          ParamType.DataStruct,
          false,
          structBuilder: PropertyStruct.fromSerializableMap,
        ),
        contract: deserializeStructParam(
          data['contract'],
          ParamType.DataStruct,
          false,
          structBuilder: ContractStruct.fromSerializableMap,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        endDate: deserializeParam(
          data['endDate'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AccountStruct &&
        id == other.id &&
        accountNumber == other.accountNumber &&
        property == other.property &&
        contract == other.contract &&
        status == other.status &&
        type == other.type &&
        name == other.name &&
        endDate == other.endDate;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, accountNumber, property, contract, status, type, name, endDate]);
}

AccountStruct createAccountStruct({
  String? id,
  int? accountNumber,
  PropertyStruct? property,
  ContractStruct? contract,
  String? status,
  String? type,
  String? name,
  String? endDate,
}) =>
    AccountStruct(
      id: id,
      accountNumber: accountNumber,
      property: property ?? PropertyStruct(),
      contract: contract ?? ContractStruct(),
      status: status,
      type: type,
      name: name,
      endDate: endDate,
    );
