import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/solar_contract_choose_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'solar_contract_row_widget.dart' show SolarContractRowWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SolarContractRowModel extends FlutterFlowModel<SolarContractRowWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Contract Terms latest)] action in Button widget.
  ApiCallResponse? contractTermsLatest;
  // Stores action output result for [Custom Action - getTermsFromLatestTermsJSON] action in Button widget.
  dynamic? termsSolarShortTerm;
  // Stores action output result for [Custom Action - getTermsFromLatestTermsJSON] action in Button widget.
  dynamic? termsSolar30Year;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
