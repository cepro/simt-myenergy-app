import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/components/monthly_consumption_widget.dart';
import '/components/solar_contract_row_widget.dart';
import '/components/supply_contract_row_widget.dart';
import '/components/top_bar_logged_in_widget.dart';
import '/components/welcome_box_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  bool isOwner = false;

  bool inPrepayMode = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getMeterByType] action in HomePage widget.
  MeterStruct? solarMeter;
  // Stores action output result for [Custom Action - getMeterByType] action in HomePage widget.
  MeterStruct? supplyMeter;
  // Stores action output result for [Backend Call - API (Get Wallets)] action in HomePage widget.
  ApiCallResponse? homePageGetWallets;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for WelcomeBox component.
  late WelcomeBoxModel welcomeBoxModel;
  // Model for SupplyContractRow component.
  late SupplyContractRowModel supplyContractRowModel;
  // Model for SolarContractRow component.
  late SolarContractRowModel solarContractRowModel;
  // Model for MonthlyConsumption component.
  late MonthlyConsumptionModel monthlyConsumptionModel;
  // Model for mobileNav component.
  late MobileNavModel mobileNavModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    welcomeBoxModel = createModel(context, () => WelcomeBoxModel());
    supplyContractRowModel =
        createModel(context, () => SupplyContractRowModel());
    solarContractRowModel = createModel(context, () => SolarContractRowModel());
    monthlyConsumptionModel =
        createModel(context, () => MonthlyConsumptionModel());
    mobileNavModel = createModel(context, () => MobileNavModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    welcomeBoxModel.dispose();
    supplyContractRowModel.dispose();
    solarContractRowModel.dispose();
    monthlyConsumptionModel.dispose();
    mobileNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
