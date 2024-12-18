import '/auth/base_auth_user_provider.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/logo_container_row/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  Local state fields for this page.

  bool loginError = false;

  bool signupPasswordMismatch = false;

  bool signupPasswordWeak = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getHostname] action in LoginPage widget.
  String? getHostnameOutput;
  // Model for LogoContainerRow component.
  late LogoContainerRowModel logoContainerRowModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for email widget.
  FocusNode? emailFocusNode1;
  TextEditingController? emailTextController1;
  String? Function(BuildContext, String?)? emailTextController1Validator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode1;
  TextEditingController? passwordTextController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? passwordTextController1Validator;
  // Stores action output result for [Action Block - GetCustomerDetailsAndInitAppState] action in Button-Login widget.
  bool? getAccountsFromSigninResult;
  // Stores action output result for [Action Block - GetAndSaveContractTerms] action in Button-Login widget.
  bool? getTermsFromSigninResult;
  // State field(s) for email widget.
  FocusNode? emailFocusNode2;
  TextEditingController? emailTextController2;
  String? Function(BuildContext, String?)? emailTextController2Validator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode2;
  TextEditingController? passwordTextController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? passwordTextController2Validator;
  // State field(s) for confirm-Create widget.
  FocusNode? confirmCreateFocusNode;
  TextEditingController? confirmCreateTextController;
  late bool confirmCreateVisibility;
  String? Function(BuildContext, String?)? confirmCreateTextControllerValidator;
  // Stores action output result for [Action Block - GetCustomerDetailsAndInitAppState] action in Button-Create-Account widget.
  bool? getAccountsFromSignupResult;
  // Stores action output result for [Action Block - GetAndSaveContractTerms] action in Button-Create-Account widget.
  bool? getTermsFromSignupResult;

  @override
  void initState(BuildContext context) {
    logoContainerRowModel = createModel(context, () => LogoContainerRowModel());
    passwordVisibility1 = false;
    passwordVisibility2 = false;
    confirmCreateVisibility = false;
  }

  @override
  void dispose() {
    logoContainerRowModel.dispose();
    tabBarController?.dispose();
    emailFocusNode1?.dispose();
    emailTextController1?.dispose();

    passwordFocusNode1?.dispose();
    passwordTextController1?.dispose();

    emailFocusNode2?.dispose();
    emailTextController2?.dispose();

    passwordFocusNode2?.dispose();
    passwordTextController2?.dispose();

    confirmCreateFocusNode?.dispose();
    confirmCreateTextController?.dispose();
  }
}
