import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/logout_button_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/components/solar_contract_row_widget.dart';
import '/components/supply_contract_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getMeterSerialByTypeData] action in HomePage widget.
  String? solarMeterSerial;
  // Stores action output result for [Custom Action - getMeterSerialByTypeData] action in HomePage widget.
  String? supplyMeterSerial;
  // Stores action output result for [Backend Call - API (Get Wallets)] action in HomePage widget.
  ApiCallResponse? homePageGetWallets;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;
  // Model for SupplyContractRow component.
  late SupplyContractRowModel supplyContractRowModel;
  // Model for SolarContractRow component.
  late SolarContractRowModel solarContractRowModel;
  // Model for mobileNav component.
  late MobileNavModel mobileNavModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
    supplyContractRowModel =
        createModel(context, () => SupplyContractRowModel());
    solarContractRowModel = createModel(context, () => SolarContractRowModel());
    mobileNavModel = createModel(context, () => MobileNavModel());
  }

  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
    supplyContractRowModel.dispose();
    solarContractRowModel.dispose();
    mobileNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
