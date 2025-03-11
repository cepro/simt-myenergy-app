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
    DateTime? createdAt,
    String? receiptUrl,
    String? status,
    String? paymentIntent,
    DateTime? scheduledAt,
    DateTime? submittedAt,
  })  : _id = id,
        _amount = amount,
        _description = description,
        _createdAt = createdAt,
        _receiptUrl = receiptUrl,
        _status = status,
        _paymentIntent = paymentIntent,
        _scheduledAt = scheduledAt,
        _submittedAt = submittedAt;

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

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "receiptUrl" field.
  String? _receiptUrl;
  String get receiptUrl => _receiptUrl ?? '';
  set receiptUrl(String? val) => _receiptUrl = val;

  bool hasReceiptUrl() => _receiptUrl != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "paymentIntent" field.
  String? _paymentIntent;
  String get paymentIntent => _paymentIntent ?? '';
  set paymentIntent(String? val) => _paymentIntent = val;

  bool hasPaymentIntent() => _paymentIntent != null;

  // "scheduledAt" field.
  DateTime? _scheduledAt;
  DateTime? get scheduledAt => _scheduledAt;
  set scheduledAt(DateTime? val) => _scheduledAt = val;

  bool hasScheduledAt() => _scheduledAt != null;

  // "submittedAt" field.
  DateTime? _submittedAt;
  DateTime? get submittedAt => _submittedAt;
  set submittedAt(DateTime? val) => _submittedAt = val;

  bool hasSubmittedAt() => _submittedAt != null;

  static PaymentStruct fromMap(Map<String, dynamic> data) => PaymentStruct(
        id: data['id'] as String?,
        amount: castToType<int>(data['amount']),
        description: data['description'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        receiptUrl: data['receiptUrl'] as String?,
        status: data['status'] as String?,
        paymentIntent: data['paymentIntent'] as String?,
        scheduledAt: data['scheduledAt'] as DateTime?,
        submittedAt: data['submittedAt'] as DateTime?,
      );

  static PaymentStruct? maybeFromMap(dynamic data) =>
      data is Map ? PaymentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'amount': _amount,
        'description': _description,
        'createdAt': _createdAt,
        'receiptUrl': _receiptUrl,
        'status': _status,
        'paymentIntent': _paymentIntent,
        'scheduledAt': _scheduledAt,
        'submittedAt': _submittedAt,
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
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'receiptUrl': serializeParam(
          _receiptUrl,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'paymentIntent': serializeParam(
          _paymentIntent,
          ParamType.String,
        ),
        'scheduledAt': serializeParam(
          _scheduledAt,
          ParamType.DateTime,
        ),
        'submittedAt': serializeParam(
          _submittedAt,
          ParamType.DateTime,
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
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        receiptUrl: deserializeParam(
          data['receiptUrl'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        paymentIntent: deserializeParam(
          data['paymentIntent'],
          ParamType.String,
          false,
        ),
        scheduledAt: deserializeParam(
          data['scheduledAt'],
          ParamType.DateTime,
          false,
        ),
        submittedAt: deserializeParam(
          data['submittedAt'],
          ParamType.DateTime,
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
        description == other.description &&
        createdAt == other.createdAt &&
        receiptUrl == other.receiptUrl &&
        status == other.status &&
        paymentIntent == other.paymentIntent &&
        scheduledAt == other.scheduledAt &&
        submittedAt == other.submittedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        amount,
        description,
        createdAt,
        receiptUrl,
        status,
        paymentIntent,
        scheduledAt,
        submittedAt
      ]);
}

PaymentStruct createPaymentStruct({
  String? id,
  int? amount,
  String? description,
  DateTime? createdAt,
  String? receiptUrl,
  String? status,
  String? paymentIntent,
  DateTime? scheduledAt,
  DateTime? submittedAt,
}) =>
    PaymentStruct(
      id: id,
      amount: amount,
      description: description,
      createdAt: createdAt,
      receiptUrl: receiptUrl,
      status: status,
      paymentIntent: paymentIntent,
      scheduledAt: scheduledAt,
      submittedAt: submittedAt,
    );
