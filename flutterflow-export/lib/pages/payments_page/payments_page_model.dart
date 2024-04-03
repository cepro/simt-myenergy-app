import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'payments_page_widget.dart' show PaymentsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentsPageModel extends FlutterFlowModel<PaymentsPageWidget> {
  ///  Local state fields for this page.

  dynamic paymentMethods;

  bool sendPaymentFailure = false;

  bool paymentSuccess = false;

  String errorMessage = 'Send payment failed - see logs';

  List<PaymentStruct> payments = [];
  void addToPayments(PaymentStruct item) => payments.add(item);
  void removeFromPayments(PaymentStruct item) => payments.remove(item);
  void removeAtIndexFromPayments(int index) => payments.removeAt(index);
  void insertAtIndexInPayments(int index, PaymentStruct item) =>
      payments.insert(index, item);
  void updatePaymentsAtIndex(int index, Function(PaymentStruct) updateFn) =>
      payments[index] = updateFn(payments[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Get Customers Payment Methods)] action in PaymentsPage widget.
  ApiCallResponse? getPaymentMethodsOutput;
  // Stores action output result for [Backend Call - API (Get Customers Payments)] action in PaymentsPage widget.
  ApiCallResponse? getPaymentsOutput;
  // Stores action output result for [Custom Action - paymentsJSONToPaymentsDataType] action in PaymentsPage widget.
  List<PaymentStruct>? paymentsTyped;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PaymentsList component.
  late PaymentsListModel paymentsListModel;
  // Model for DirectDebit component.
  late DirectDebitModel directDebitModel;
  // Model for CreditCard component.
  late CreditCardWidgetModel creditCardModel;
  // Stores action output result for [Backend Call - API (Delete Customers Payment Method)] action in Button widget.
  ApiCallResponse? deletePaymentMethodResult;
  // Stores action output result for [Backend Call - API (Create Stripe Checkout Session)] action in Button widget.
  ApiCallResponse? checkoutPageURI;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    paymentsListModel = createModel(context, () => PaymentsListModel());
    directDebitModel = createModel(context, () => DirectDebitModel());
    creditCardModel = createModel(context, () => CreditCardWidgetModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    paymentsListModel.dispose();
    directDebitModel.dispose();
    creditCardModel.dispose();
  }
}
