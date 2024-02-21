import '/backend/api_requests/api_calls.dart';
import '/components/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'invite_landing_page_widget.dart' show InviteLandingPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InviteLandingPageModel extends FlutterFlowModel<InviteLandingPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Customer Invite Lookup)] action in InviteLandingPage widget.
  ApiCallResponse? inviteLookupResult;
  // Model for LogoContainerRow component.
  late LogoContainerRowModel logoContainerRowModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    logoContainerRowModel = createModel(context, () => LogoContainerRowModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    logoContainerRowModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
