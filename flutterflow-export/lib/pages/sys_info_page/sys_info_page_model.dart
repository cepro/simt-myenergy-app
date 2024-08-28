import '/components/logout_button/logout_button_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'sys_info_page_widget.dart' show SysInfoPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SysInfoPageModel extends FlutterFlowModel<SysInfoPageWidget> {
  ///  Local state fields for this page.

  bool haveWallet = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
  }
}
