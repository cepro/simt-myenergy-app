import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/monthly_costs/monthly_costs_widget.dart';
import '/components/monthly_generation/monthly_generation_widget.dart';
import '/components/monthly_usage/monthly_usage_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_energy_page_widget.dart' show MyEnergyPageWidget;
import 'package:flutter/material.dart';

class MyEnergyPageModel extends FlutterFlowModel<MyEnergyPageWidget> {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  bool isOwner = false;

  bool? inPrepayMode;

  ///  State fields for stateful widgets in this page.

  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PropertyNameWithTooltip component.
  late PropertyNameWithTooltipModel propertyNameWithTooltipModel;
  // Model for MonthlyCosts component.
  late MonthlyCostsModel monthlyCostsModel;
  // Model for MonthlyUsage component.
  late MonthlyUsageModel monthlyUsageModel;
  // Model for MonthlyGeneration component.
  late MonthlyGenerationModel monthlyGenerationModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    propertyNameWithTooltipModel =
        createModel(context, () => PropertyNameWithTooltipModel());
    monthlyCostsModel = createModel(context, () => MonthlyCostsModel());
    monthlyUsageModel = createModel(context, () => MonthlyUsageModel());
    monthlyGenerationModel =
        createModel(context, () => MonthlyGenerationModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    propertyNameWithTooltipModel.dispose();
    monthlyCostsModel.dispose();
    monthlyUsageModel.dispose();
    monthlyGenerationModel.dispose();
  }
}
