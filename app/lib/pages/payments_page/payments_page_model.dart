import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/topup_list/topup_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'payments_page_widget.dart' show PaymentsPageWidget;
import 'package:flutter/material.dart';

class PaymentsPageModel extends FlutterFlowModel<PaymentsPageWidget> {
  ///  Local state fields for this page.

  dynamic paymentMethods;

  List<PaymentStruct> payments = [];
  void addToPayments(PaymentStruct item) => payments.add(item);
  void removeFromPayments(PaymentStruct item) => payments.remove(item);
  void removeAtIndexFromPayments(int index) => payments.removeAt(index);
  void insertAtIndexInPayments(int index, PaymentStruct item) =>
      payments.insert(index, item);
  void updatePaymentsAtIndex(int index, Function(PaymentStruct) updateFn) =>
      payments[index] = updateFn(payments[index]);

  bool loadPaymentHistoryFailure = false;

  bool loadingPaymentHistory = false;

  bool loadingMethod = false;

  List<TopupStruct> topups = [];
  void addToTopups(TopupStruct item) => topups.add(item);
  void removeFromTopups(TopupStruct item) => topups.remove(item);
  void removeAtIndexFromTopups(int index) => topups.removeAt(index);
  void insertAtIndexInTopups(int index, TopupStruct item) =>
      topups.insert(index, item);
  void updateTopupsAtIndex(int index, Function(TopupStruct) updateFn) =>
      topups[index] = updateFn(topups[index]);

  bool loadTopupHistoryFailure = false;

  bool loadingTopupHistory = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - activeUserToken] action in PaymentsPage widget.
  String? userToken;
  // Stores action output result for [Backend Call - API (Get Customers Payment Methods)] action in PaymentsPage widget.
  ApiCallResponse? getPaymentMethodsOutput;
  // Stores action output result for [Backend Call - API (Get Payments)] action in PaymentsPage widget.
  ApiCallResponse? getPaymentsOutput;
  // Stores action output result for [Custom Action - paymentsJSONToPaymentsDataType] action in PaymentsPage widget.
  List<PaymentStruct>? paymentsTyped;
  // Stores action output result for [Backend Call - API (Get Topups)] action in PaymentsPage widget.
  ApiCallResponse? getTopupsOutput;
  // Stores action output result for [Custom Action - topupsJSONToTopupsDataType] action in PaymentsPage widget.
  List<TopupStruct>? topupsTyped;
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PropertyNameWithTooltip component.
  late PropertyNameWithTooltipModel propertyNameWithTooltipModel;
  // Model for PaymentsList component.
  late PaymentsListModel paymentsListModel;
  // Model for TopupList component.
  late TopupListModel topupListModel;
  // Model for DirectDebit component.
  late DirectDebitModel directDebitModel;
  // Model for CreditCard component.
  late CreditCardWidgetModel creditCardModel;
  // Stores action output result for [Backend Call - API (Delete Customers Payment Method)] action in Button widget.
  ApiCallResponse? deletePaymentMethodResult;
  // Stores action output result for [Backend Call - API (Create Stripe Checkout Session)] action in Button widget.
  ApiCallResponse? checkoutPageURI;
  // Model for ComingSoonForPreonboarding component.
  late ComingSoonForPreonboardingModel comingSoonForPreonboardingModel;
  // Model for ComingSoonForLandlords.
  late ComingSoonForPreonboardingModel comingSoonForLandlordsModel;


  bool haveWallet = false;

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Get Wallets)] action in TopupPage widget.
  ApiCallResponse? topupPreferencesGetOutput;
  // Model for MainWebNav component.

  // State field(s) for MinimumBalance widget.
  FocusNode? minimumBalanceFocusNode;
  TextEditingController? minimumBalanceTextController;
  String? Function(BuildContext, String?)?
      minimumBalanceTextControllerValidator;
  String? _minimumBalanceTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Enter a number for the Threshold';
    }
    return null;
  }

  // State field(s) for TopUpAmount widget.
  FocusNode? topUpAmountFocusNode;
  TextEditingController? topUpAmountTextController;
  String? Function(BuildContext, String?)? topUpAmountTextControllerValidator;
  String? _topUpAmountTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Enter a number for the Amount';
    }
    return null;
  }
  
  // Stores action output result for [Backend Call - API (Update Topup Preferences)] action in Button widget.
  ApiCallResponse? updateTopupPreferenceOutput;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    propertyNameWithTooltipModel =
        createModel(context, () => PropertyNameWithTooltipModel());
    paymentsListModel = createModel(context, () => PaymentsListModel());
    topupListModel = createModel(context, () => TopupListModel());
    directDebitModel = createModel(context, () => DirectDebitModel());
    creditCardModel = createModel(context, () => CreditCardWidgetModel());
    minimumBalanceTextControllerValidator =
        _minimumBalanceTextControllerValidator;
    topUpAmountTextControllerValidator = _topUpAmountTextControllerValidator;
    comingSoonForPreonboardingModel =
        createModel(context, () => ComingSoonForPreonboardingModel());
    comingSoonForLandlordsModel =
        createModel(context, () => ComingSoonForPreonboardingModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    propertyNameWithTooltipModel.dispose();
    paymentsListModel.dispose();
    topupListModel.dispose();
    directDebitModel.dispose();
    creditCardModel.dispose();
    minimumBalanceFocusNode?.dispose();
    minimumBalanceTextController?.dispose();
    topUpAmountFocusNode?.dispose();
    topUpAmountTextController?.dispose();
    comingSoonForPreonboardingModel.dispose();
    comingSoonForLandlordsModel.dispose();
  }
}
