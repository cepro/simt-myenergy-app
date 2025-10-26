import '/backend/api_requests/api_calls.dart';
import '/components/logo_container_row/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'invite_landing_page_widget.dart' show InviteLandingPageWidget;
import 'package:flutter/material.dart';

class InviteLandingPageModel extends FlutterFlowModel<InviteLandingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Customer Invite Lookup)] action in InviteLandingPage widget.
  ApiCallResponse? inviteLookupResult;
  // Model for LogoContainerRow component.
  late LogoContainerRowModel logoContainerRowModel;

  @override
  void initState(BuildContext context) {
    logoContainerRowModel = createModel(context, () => LogoContainerRowModel());
  }

  @override
  void dispose() {
    logoContainerRowModel.dispose();
  }
}
