import '/components/logout_button_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;
  // State field(s) for MinimumBalance widget.
  TextEditingController? minimumBalanceController;
  String? Function(BuildContext, String?)? minimumBalanceControllerValidator;
  String? _minimumBalanceControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // State field(s) for TopUpAmount widget.
  TextEditingController? topUpAmountController;
  String? Function(BuildContext, String?)? topUpAmountControllerValidator;
  String? _topUpAmountControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // Model for mobileNav component.
  late MobileNavModel mobileNavModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
    minimumBalanceControllerValidator = _minimumBalanceControllerValidator;
    topUpAmountControllerValidator = _topUpAmountControllerValidator;
    mobileNavModel = createModel(context, () => MobileNavModel());
  }

  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
    minimumBalanceController?.dispose();
    topUpAmountController?.dispose();
    mobileNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

}
