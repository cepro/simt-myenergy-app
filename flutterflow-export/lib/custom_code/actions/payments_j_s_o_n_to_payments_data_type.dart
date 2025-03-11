// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<PaymentStruct>> paymentsJSONToPaymentsDataType(
    dynamic paymentsJSON) async {
  List<PaymentStruct> payments = [];

  Map<String, dynamic> paymentsMap = paymentsJSON as Map<String, dynamic>;
  paymentsMap.forEach((key, payment) {
    DateTime createdAt = DateTime.parse(key);

    DateTime? scheduledAt = payment['scheduledAt'] != null
        ? DateTime.parse(payment['scheduledAt'])
        : null;
    DateTime? submittedAt = payment['submittedAt'] != null
        ? DateTime.parse(payment['submittedAt'])
        : null;

    payments.add(PaymentStruct(
        id: payment[' paymentIntent'],
        createdAt: createdAt,
        scheduledAt: scheduledAt,
        submittedAt: submittedAt,
        amount: payment['amountPence'],
        description: payment['description'],
        paymentIntent: payment['paymentIntent'],
        receiptUrl: payment['receiptUrl'],
        status: payment['status']));
  });

  // reverse date order (ie. latest date first)
  payments.sort((a, b) {
    if (a.createdAt == null && b.createdAt == null) {
      return 0;
    }
    if (a.createdAt == null) {
      return 1;
    }
    if (b.createdAt == null) {
      return -1;
    }
    return b.createdAt!.compareTo(a.createdAt!);
  });

  return payments;
}
