import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_details_confirmation_modal_widget.dart'
    show ConfirmDetailsConfirmationModalWidget;
import 'package:flutter/material.dart';

class ConfirmDetailsConfirmationModalModel
    extends FlutterFlowModel<ConfirmDetailsConfirmationModalWidget> {
  ///  Local state fields for this component.

  bool showError = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Customer details confirmed)] action in Button widget.
  ApiCallResponse? customerDetailsConfirmedResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
