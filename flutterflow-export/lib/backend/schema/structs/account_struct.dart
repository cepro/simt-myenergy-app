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
  })  : _id = id,
        _accountNumber = accountNumber,
        _property = property,
        _contract = contract;

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
      _accountNumber = accountNumber + amount;
  bool hasAccountNumber() => _accountNumber != null;

  // "property" field.
  PropertyStruct? _property;
  PropertyStruct get property => _property ?? PropertyStruct();
  set property(PropertyStruct? val) => _property = val;
  void updateProperty(Function(PropertyStruct) updateFn) =>
      updateFn(_property ??= PropertyStruct());
  bool hasProperty() => _property != null;

  // "contract" field.
  ContractStruct? _contract;
  ContractStruct get contract => _contract ?? ContractStruct();
  set contract(ContractStruct? val) => _contract = val;
  void updateContract(Function(ContractStruct) updateFn) =>
      updateFn(_contract ??= ContractStruct());
  bool hasContract() => _contract != null;

  static AccountStruct fromMap(Map<String, dynamic> data) => AccountStruct(
        id: data['id'] as String?,
        accountNumber: castToType<int>(data['accountNumber']),
        property: PropertyStruct.maybeFromMap(data['property']),
        contract: ContractStruct.maybeFromMap(data['contract']),
      );

  static AccountStruct? maybeFromMap(dynamic data) =>
      data is Map ? AccountStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'accountNumber': _accountNumber,
        'property': _property?.toMap(),
        'contract': _contract?.toMap(),
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
      );

  @override
  String toString() => 'AccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AccountStruct &&
        id == other.id &&
        accountNumber == other.accountNumber &&
        property == other.property &&
        contract == other.contract;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, accountNumber, property, contract]);
}

AccountStruct createAccountStruct({
  String? id,
  int? accountNumber,
  PropertyStruct? property,
  ContractStruct? contract,
}) =>
    AccountStruct(
      id: id,
      accountNumber: accountNumber,
      property: property ?? PropertyStruct(),
      contract: contract ?? ContractStruct(),
    );
