import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'confirm_details_confirmation_modal_widget.dart'
    show ConfirmDetailsConfirmationModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
