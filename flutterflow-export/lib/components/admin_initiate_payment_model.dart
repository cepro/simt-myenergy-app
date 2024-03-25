import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'admin_initiate_payment_widget.dart' show AdminInitiatePaymentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminInitiatePaymentModel
    extends FlutterFlowModel<AdminInitiatePaymentWidget> {
  ///  Local state fields for this component.

  bool sendPaymentFailure = false;

  bool paymentSuccess = false;

  String? errorMessage;

  ///  State fields for stateful widgets in this component.

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

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customerIdFieldFocusNode?.dispose();
    customerIdFieldController?.dispose();

    amountFieldFocusNode?.dispose();
    amountFieldController?.dispose();

    descriptionFieldFocusNode?.dispose();
    descriptionFieldController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
