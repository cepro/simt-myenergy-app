// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
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
