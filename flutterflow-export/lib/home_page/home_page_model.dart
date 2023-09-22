import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/contract_list_row_widget.dart';
import '/components/logout_button_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getContractsByTypeFromAccountsJSON] action in HomePage widget.
  dynamic? supplyContract;
  // Stores action output result for [Custom Action - getContractsByTypeFromAccountsJSON] action in HomePage widget.
  dynamic? solarContract;
  // Stores action output result for [Custom Action - getMeterSerialByType] action in HomePage widget.
  String? solarMeterSerial;
  // Stores action output result for [Custom Action - getMeterSerialByType] action in HomePage widget.
  String? supplyMeterSerial;
  // Stores action output result for [Backend Call - API (Get Wallets)] action in HomePage widget.
  ApiCallResponse? homePageGetWallets;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;
  // Model for ContractListRow component.
  late ContractListRowModel contractListRowModel1;
  // Model for ContractListRow component.
  late ContractListRowModel contractListRowModel2;
  // Model for mobileNav component.
  late MobileNavModel mobileNavModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
    contractListRowModel1 = createModel(context, () => ContractListRowModel());
    contractListRowModel2 = createModel(context, () => ContractListRowModel());
    mobileNavModel = createModel(context, () => MobileNavModel());
  }

  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
    contractListRowModel1.dispose();
    contractListRowModel2.dispose();
    mobileNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
