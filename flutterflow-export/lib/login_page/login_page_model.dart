import '/auth/base_auth_user_provider.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/components/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  Local state fields for this page.

  bool loginError = false;

  bool signupPasswordMismatch = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for LogoContainerRow component.
  late LogoContainerRowModel logoContainerRowModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // Stores action output result for [Action Block - GetAndSaveAccounts] action in Button-Login widget.
  bool? getAccountsFromSigninResult;
  // Stores action output result for [Action Block - GetAndSaveContractTerms] action in Button-Login widget.
  bool? getTermsFromSigninResult;
  // State field(s) for emailAddress-Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateController;
  String? Function(BuildContext, String?)?
      emailAddressCreateControllerValidator;
  // State field(s) for password-Create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;
  // State field(s) for confirm-Create widget.
  FocusNode? confirmCreateFocusNode;
  TextEditingController? confirmCreateController;
  late bool confirmCreateVisibility;
  String? Function(BuildContext, String?)? confirmCreateControllerValidator;
  // Stores action output result for [Action Block - GetAndSaveAccounts] action in Button-Create-Account widget.
  bool? getAccountsFromSignupResult;
  // Stores action output result for [Action Block - GetAndSaveContractTerms] action in Button-Create-Account widget.
  bool? getTermsFromSignupResult;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    logoContainerRowModel = createModel(context, () => LogoContainerRowModel());
    passwordVisibility = false;
    passwordCreateVisibility = false;
    confirmCreateVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    logoContainerRowModel.dispose();
    tabBarController?.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateController?.dispose();

    confirmCreateFocusNode?.dispose();
    confirmCreateController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
