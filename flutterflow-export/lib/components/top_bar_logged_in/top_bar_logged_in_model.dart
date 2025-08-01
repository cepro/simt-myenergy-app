import '/backend/schema/enums/enums.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/stop_impersonating_link_widget.dart';
import '/components/sys_info_button/sys_info_button_widget.dart';
import '/components/user_profile_button/user_profile_button_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'top_bar_logged_in_widget.dart' show TopBarLoggedInWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopBarLoggedInModel extends FlutterFlowModel<TopBarLoggedInWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for StopImpersonatingLink component.
  late StopImpersonatingLinkModel stopImpersonatingLinkModel;
  // Model for SysInfoButton component.
  late SysInfoButtonModel sysInfoButtonModel;
  // Model for UserProfileButton component.
  late UserProfileButtonModel userProfileButtonModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;

  @override
  void initState(BuildContext context) {
    stopImpersonatingLinkModel =
        createModel(context, () => StopImpersonatingLinkModel());
    sysInfoButtonModel = createModel(context, () => SysInfoButtonModel());
    userProfileButtonModel =
        createModel(context, () => UserProfileButtonModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
  }

  @override
  void dispose() {
    stopImpersonatingLinkModel.dispose();
    sysInfoButtonModel.dispose();
    userProfileButtonModel.dispose();
    logoutButtonModel.dispose();
  }
}
