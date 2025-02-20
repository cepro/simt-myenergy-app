import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'impersonate_user_widget.dart' show ImpersonateUserWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ImpersonateUserModel extends FlutterFlowModel<ImpersonateUserWidget> {
  ///  Local state fields for this page.

  bool loading = false;

  String? errorMessage;

  ///  State fields for stateful widgets in this page.

  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // State field(s) for emailField widget.
  FocusNode? emailFieldFocusNode;
  TextEditingController? emailFieldTextController;
  String? Function(BuildContext, String?)? emailFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Generate Token for Impersonate)] action in Button widget.
  ApiCallResponse? generateTokenResponse;
  // Stores action output result for [Action Block - GetCustomerDetailsAndInitAppState] action in Button widget.
  bool? impersonateCustomerDetailsResponse;
  // Stores action output result for [Custom Action - decodeSupabaseJwt] action in Button widget.
  SupabaseUserStruct? decodeTokenResponse;
  // Stores action output result for [Action Block - GetCustomerDetailsAndInitAppState] action in Button widget.
  bool? unimpersonateGetCustomerDetailsResponse;
  // Stores action output result for [Custom Action - decodeSupabaseJwt] action in Button widget.
  SupabaseUserStruct? decodeLoggedInUserTokenResponse;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    emailFieldFocusNode?.dispose();
    emailFieldTextController?.dispose();
  }
}
