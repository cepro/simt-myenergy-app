import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'supply_contract_sign_or_view_modal_widget.dart'
    show SupplyContractSignOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SupplyContractSignOrViewModalModel
    extends FlutterFlowModel<SupplyContractSignOrViewModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Mark Contract Signed)] action in Button widget.
  ApiCallResponse? signSupplyContractResult;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
