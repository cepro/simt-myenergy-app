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

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // Stores action output result for [Action Block - GetCustomerDetailsAndInitAppState] action in Button-Login widget.
  bool? getAccountsFromSigninResult;
  // Stores action output result for [Action Block - GetAndSaveContractTerms] action in Button-Login widget.
  bool? getTermsFromSigninResult;
  // State field(s) for emailAddress-Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateTextController;
  String? Function(BuildContext, String?)?
      emailAddressCreateTextControllerValidator;
  // State field(s) for password-Create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateTextController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)?
      passwordCreateTextControllerValidator;
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
    passwordVisibility = false;
    passwordCreateVisibility = false;
    confirmCreateVisibility = false;
  }

  @override
  void dispose() {
    logoContainerRowModel.dispose();
    tabBarController?.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateTextController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateTextController?.dispose();

    confirmCreateFocusNode?.dispose();
    confirmCreateTextController?.dispose();
  }
}
