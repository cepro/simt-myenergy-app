import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/credit_card_widget.dart';
import '/components/direct_debit_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/components/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'payment_page_widget.dart' show PaymentPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentPageModel extends FlutterFlowModel<PaymentPageWidget> {
  ///  Local state fields for this page.

  dynamic paymentMethods;

  bool sendPaymentFailure = false;

  bool paymentSuccess = false;

  String errorMessage = 'Send payment failed - see logs';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getJwtToken] action in PaymentPage widget.
  String? jwtToken;
  // Stores action output result for [Backend Call - API (Get Customers Payment Methods)] action in PaymentPage widget.
  ApiCallResponse? getPaymentMethodsOutput;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for DirectDebit component.
  late DirectDebitModel directDebitModel;
  // Model for CreditCard component.
  late CreditCardWidgetModel creditCardModel;
  // Stores action output result for [Backend Call - API (Delete Customers Payment Method)] action in Button widget.
  ApiCallResponse? deletePaymentMethodResult;
  // Stores action output result for [Backend Call - API (Create Stripe Checkout Session)] action in Button widget.
  ApiCallResponse? checkoutPageURI;
  // State field(s) for customerIdField widget.
  FocusNode? customerIdFieldFocusNode;
  TextEditingController? customerIdFieldController;
  String? Function(BuildContext, String?)? customerIdFieldControllerValidator;
  // State field(s) for amountField widget.
  FocusNode? amountFieldFocusNode;
  TextEditingController? amountFieldController;
  String? Function(BuildContext, String?)? amountFieldControllerValidator;
  // State field(s) for descriptionField widget.
  FocusNode? descriptionFieldFocusNode;
  TextEditingController? descriptionFieldController;
  String? Function(BuildContext, String?)? descriptionFieldControllerValidator;
  // Stores action output result for [Backend Call - API (Send Payment)] action in Button widget.
  ApiCallResponse? sendPaymentResult;
  // Model for mobileNav component.
  late MobileNavModel mobileNavModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    directDebitModel = createModel(context, () => DirectDebitModel());
    creditCardModel = createModel(context, () => CreditCardWidgetModel());
    mobileNavModel = createModel(context, () => MobileNavModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    directDebitModel.dispose();
    creditCardModel.dispose();
    customerIdFieldFocusNode?.dispose();
    customerIdFieldController?.dispose();

    amountFieldFocusNode?.dispose();
    amountFieldController?.dispose();

    descriptionFieldFocusNode?.dispose();
    descriptionFieldController?.dispose();

    mobileNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
