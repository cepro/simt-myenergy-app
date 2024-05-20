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

  bool showErrorMessage = false;

  bool paymentSuccess = false;

  String? errorMessage;

  ///  State fields for stateful widgets in this component.

  // State field(s) for customerIdField widget.
  FocusNode? customerIdFieldFocusNode;
  TextEditingController? customerIdFieldTextController;
  String? Function(BuildContext, String?)?
      customerIdFieldTextControllerValidator;
  // State field(s) for amountField widget.
  FocusNode? amountFieldFocusNode;
  TextEditingController? amountFieldTextController;
  String? Function(BuildContext, String?)? amountFieldTextControllerValidator;
  // State field(s) for descriptionField widget.
  FocusNode? descriptionFieldFocusNode;
  TextEditingController? descriptionFieldTextController;
  String? Function(BuildContext, String?)?
      descriptionFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Send Payment)] action in Button widget.
  ApiCallResponse? sendPaymentResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customerIdFieldFocusNode?.dispose();
    customerIdFieldTextController?.dispose();

    amountFieldFocusNode?.dispose();
    amountFieldTextController?.dispose();

    descriptionFieldFocusNode?.dispose();
    descriptionFieldTextController?.dispose();
  }
}
