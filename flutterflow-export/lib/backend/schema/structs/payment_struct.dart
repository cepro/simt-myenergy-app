// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentStruct extends BaseStruct {
  PaymentStruct({
    String? id,
    int? amount,
    String? description,
  })  : _id = id,
        _amount = amount,
        _description = description;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  static PaymentStruct fromMap(Map<String, dynamic> data) => PaymentStruct(
        id: data['id'] as String?,
        amount: castToType<int>(data['amount']),
        description: data['description'] as String?,
      );

  static PaymentStruct? maybeFromMap(dynamic data) =>
      data is Map ? PaymentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'amount': _amount,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static PaymentStruct fromSerializableMap(Map<String, dynamic> data) =>
      PaymentStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PaymentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PaymentStruct &&
        id == other.id &&
        amount == other.amount &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality().hash([id, amount, description]);
}

PaymentStruct createPaymentStruct({
  String? id,
  int? amount,
  String? description,
}) =>
    PaymentStruct(
      id: id,
      amount: amount,
      description: description,
    );
