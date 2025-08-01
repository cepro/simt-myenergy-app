import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'topup_page_widget.dart' show TopupPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopupPageModel extends FlutterFlowModel<TopupPageWidget> {
  ///  Local state fields for this page.

  bool haveWallet = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Get Wallets)] action in TopupPage widget.
  ApiCallResponse? topupPreferencesGetOutput;
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;
  // State field(s) for MinimumBalance widget.
  FocusNode? minimumBalanceFocusNode;
  TextEditingController? minimumBalanceTextController;
  String? Function(BuildContext, String?)?
      minimumBalanceTextControllerValidator;
  String? _minimumBalanceTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Enter a number for the Threshold';
    }
    return null;
  }

  // State field(s) for TopUpAmount widget.
  FocusNode? topUpAmountFocusNode;
  TextEditingController? topUpAmountTextController;
  String? Function(BuildContext, String?)? topUpAmountTextControllerValidator;
  String? _topUpAmountTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    if (!RegExp('^\\d{1,3}\$').hasMatch(val)) {
      return 'Enter a number for the Amount';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (Update Topup Preferences)] action in Button widget.
  ApiCallResponse? updateTopupPreferenceOutput;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
    minimumBalanceTextControllerValidator =
        _minimumBalanceTextControllerValidator;
    topUpAmountTextControllerValidator = _topUpAmountTextControllerValidator;
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
    minimumBalanceFocusNode?.dispose();
    minimumBalanceTextController?.dispose();

    topUpAmountFocusNode?.dispose();
    topUpAmountTextController?.dispose();
  }
}
