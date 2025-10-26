import '/backend/schema/structs/index.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sys_info_page_widget.dart' show SysInfoPageWidget;
import 'package:flutter/material.dart';

class SysInfoPageModel extends FlutterFlowModel<SysInfoPageWidget> {
  ///  Local state fields for this page.

  bool haveWallet = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getPackageInfo] action in SysInfoPage widget.
  PackageInfoStruct? packageInfo;
  // Model for MainWebNav component.
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
