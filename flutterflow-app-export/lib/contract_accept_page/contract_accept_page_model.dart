import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContractAcceptPageModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  String? description;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getJwtToken] action in ContractAcceptPage widget.
  String? jwtToken;
  // Stores action output result for [Backend Call - API (Get Customers Contracts)] action in ContractAcceptPage widget.
  ApiCallResponse? contractsCallOutput;
  // Stores action output result for [Backend Call - API (Mark Contract Signed)] action in AcceptButton widget.
  ApiCallResponse? contractSignedCallOutput;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
