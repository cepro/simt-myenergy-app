import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/home_notification_box/home_notification_box_widget.dart';
import '/components/info_tooltip_widget.dart';
import '/components/labeled_value_widget.dart';
import '/components/labeled_value_with_unit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/onboard_progress_box/onboard_progress_box_widget.dart';
import '/components/product_roadmap_box/product_roadmap_box_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/solar_contract_row/solar_contract_row_widget.dart';
import '/components/supply_contract_row/supply_contract_row_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/welcome_box/welcome_box_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  bool? inPrepayMode;

  SolarInstallationStruct? solarInstallation;
  void updateSolarInstallationStruct(
      Function(SolarInstallationStruct) updateFn) {
    updateFn(solarInstallation ??= SolarInstallationStruct());
  }

  SupplyTariffStruct? supplyTariffCurrent;
  void updateSupplyTariffCurrentStruct(Function(SupplyTariffStruct) updateFn) {
    updateFn(supplyTariffCurrent ??= SupplyTariffStruct());
  }

  SolarCreditTariffStruct? solarCreditTariffCurrent;
  void updateSolarCreditTariffCurrentStruct(
      Function(SolarCreditTariffStruct) updateFn) {
    updateFn(solarCreditTariffCurrent ??= SolarCreditTariffStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMeterByType] action in HomePage widget.
  MeterStruct? solarMeter;
  // Stores action output result for [Custom Action - getMeterByType] action in HomePage widget.
  MeterStruct? supplyMeter;
  // Stores action output result for [Custom Action - getSolarInstallationById] action in HomePage widget.
  SolarInstallationStruct? getSolarInstallationOutput;
  // Stores action output result for [Custom Action - activeUserToken] action in HomePage widget.
  String? userToken;
  // Stores action output result for [Backend Call - API (Get Wallets)] action in HomePage widget.
  ApiCallResponse? homePageGetWallets;
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PropertyNameWithTooltip component.
  late PropertyNameWithTooltipModel propertyNameWithTooltipModel;
  // Model for HomeNotificationBox component.
  late HomeNotificationBoxModel homeNotificationBoxModel;
  // Model for OnboardProgressBox component.
  late OnboardProgressBoxModel onboardProgressBoxModel;
  // Model for WelcomeBox component.
  late WelcomeBoxModel welcomeBoxModel;
  // Model for ProductRoadmapBox component.
  late ProductRoadmapBoxModel productRoadmapBoxModel;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel1;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel2;
  // Model for InfoTooltip component.
  late InfoTooltipModel infoTooltipModel1;
  // Model for LabeledValueWithUnit component.
  late LabeledValueWithUnitModel labeledValueWithUnitModel1;
  // Model for LabeledValueWithUnit component.
  late LabeledValueWithUnitModel labeledValueWithUnitModel2;
  // Model for SupplyContractRow component.
  late SupplyContractRowModel supplyContractRowModel;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel3;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel4;
  // Stores action output result for [Custom Action - getStorageURL] action in LabeledValue widget.
  String? certificateURL;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel5;
  // Model for LabeledValue component.
  late LabeledValueModel labeledValueModel6;
  // Model for InfoTooltip component.
  late InfoTooltipModel infoTooltipModel2;
  // Model for LabeledValueWithUnit component.
  late LabeledValueWithUnitModel labeledValueWithUnitModel3;
  // Model for SolarContractRow component.
  late SolarContractRowModel solarContractRowModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    propertyNameWithTooltipModel =
        createModel(context, () => PropertyNameWithTooltipModel());
    homeNotificationBoxModel =
        createModel(context, () => HomeNotificationBoxModel());
    onboardProgressBoxModel =
        createModel(context, () => OnboardProgressBoxModel());
    welcomeBoxModel = createModel(context, () => WelcomeBoxModel());
    productRoadmapBoxModel =
        createModel(context, () => ProductRoadmapBoxModel());
    labeledValueModel1 = createModel(context, () => LabeledValueModel());
    labeledValueModel2 = createModel(context, () => LabeledValueModel());
    infoTooltipModel1 = createModel(context, () => InfoTooltipModel());
    labeledValueWithUnitModel1 =
        createModel(context, () => LabeledValueWithUnitModel());
    labeledValueWithUnitModel2 =
        createModel(context, () => LabeledValueWithUnitModel());
    supplyContractRowModel =
        createModel(context, () => SupplyContractRowModel());
    labeledValueModel3 = createModel(context, () => LabeledValueModel());
    labeledValueModel4 = createModel(context, () => LabeledValueModel());
    labeledValueModel5 = createModel(context, () => LabeledValueModel());
    labeledValueModel6 = createModel(context, () => LabeledValueModel());
    infoTooltipModel2 = createModel(context, () => InfoTooltipModel());
    labeledValueWithUnitModel3 =
        createModel(context, () => LabeledValueWithUnitModel());
    solarContractRowModel = createModel(context, () => SolarContractRowModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    propertyNameWithTooltipModel.dispose();
    homeNotificationBoxModel.dispose();
    onboardProgressBoxModel.dispose();
    welcomeBoxModel.dispose();
    productRoadmapBoxModel.dispose();
    labeledValueModel1.dispose();
    labeledValueModel2.dispose();
    infoTooltipModel1.dispose();
    labeledValueWithUnitModel1.dispose();
    labeledValueWithUnitModel2.dispose();
    supplyContractRowModel.dispose();
    labeledValueModel3.dispose();
    labeledValueModel4.dispose();
    labeledValueModel5.dispose();
    labeledValueModel6.dispose();
    infoTooltipModel2.dispose();
    labeledValueWithUnitModel3.dispose();
    solarContractRowModel.dispose();
  }
}
