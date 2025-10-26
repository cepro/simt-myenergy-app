import '/components/logout_button/logout_button_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'accounts_list_page_widget.dart' show AccountsListPageWidget;
import 'package:flutter/material.dart';

class AccountsListPageModel extends FlutterFlowModel<AccountsListPageWidget> {
  ///  Local state fields for this page.

  dynamic paymentMethods;

  ///  State fields for stateful widgets in this page.

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
