import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/onboard_progress_box/onboard_progress_box_widget.dart';
import '/components/product_roadmap_box/product_roadmap_box_widget.dart';
import '/components/supply_contract_row/supply_contract_row_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/welcome_box/welcome_box_widget.dart';
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

  bool? inPrepayMode;

  ///  State fields for stateful widgets in this page.

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
  // Model for OnboardProgressBox component.
  late OnboardProgressBoxModel onboardProgressBoxModel;
  // Model for WelcomeBox component.
  late WelcomeBoxModel welcomeBoxModel;
  // Model for ProductRoadmapBox component.
  late ProductRoadmapBoxModel productRoadmapBoxModel;
  // Model for SupplyContractRow component.
  late SupplyContractRowModel supplyContractRowModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    onboardProgressBoxModel =
        createModel(context, () => OnboardProgressBoxModel());
    welcomeBoxModel = createModel(context, () => WelcomeBoxModel());
    productRoadmapBoxModel =
        createModel(context, () => ProductRoadmapBoxModel());
    supplyContractRowModel =
        createModel(context, () => SupplyContractRowModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    onboardProgressBoxModel.dispose();
    welcomeBoxModel.dispose();
    productRoadmapBoxModel.dispose();
    supplyContractRowModel.dispose();
  }
}
