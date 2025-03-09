import '';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/sidebar_property_list/sidebar_property_list_widget.dart';
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

  // Model for SidebarPropertyList component.
  late SidebarPropertyListModel sidebarPropertyListModel;
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

  @override
  void initState(BuildContext context) {
    sidebarPropertyListModel =
        createModel(context, () => SidebarPropertyListModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
  }

  @override
  void dispose() {
    sidebarPropertyListModel.dispose();
    topBarLoggedInModel.dispose();
    emailFieldFocusNode?.dispose();
    emailFieldTextController?.dispose();
  }
}
