import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/monthly_consumption/monthly_consumption_widget.dart';
import '/components/monthly_costs/monthly_costs_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'my_energy_page_v2_draft_widget.dart' show MyEnergyPageV2DraftWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyEnergyPageV2DraftModel
    extends FlutterFlowModel<MyEnergyPageV2DraftWidget> {
  ///  Local state fields for this page.

  String singleWalletBalance = 'unknown';

  bool isOwner = false;

  bool? inPrepayMode;

  List<MonthlyCostStruct> monthlyCosts = [];
  void addToMonthlyCosts(MonthlyCostStruct item) => monthlyCosts.add(item);
  void removeFromMonthlyCosts(MonthlyCostStruct item) =>
      monthlyCosts.remove(item);
  void removeAtIndexFromMonthlyCosts(int index) => monthlyCosts.removeAt(index);
  void insertAtIndexInMonthlyCosts(int index, MonthlyCostStruct item) =>
      monthlyCosts.insert(index, item);
  void updateMonthlyCostsAtIndex(
          int index, Function(MonthlyCostStruct) updateFn) =>
      monthlyCosts[index] = updateFn(monthlyCosts[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get Monthly Cost)] action in MyEnergyPageV2Draft widget.
  ApiCallResponse? getMonthlyCostResponse;
  // Stores action output result for [Custom Action - monthlyCostJSONToDataType] action in MyEnergyPageV2Draft widget.
  List<MonthlyCostStruct>? monthlyCostsTyped;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for MonthlyCosts component.
  late MonthlyCostsModel monthlyCostsModel;
  // Model for MonthlyConsumption component.
  late MonthlyConsumptionModel monthlyConsumptionModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    monthlyCostsModel = createModel(context, () => MonthlyCostsModel());
    monthlyConsumptionModel =
        createModel(context, () => MonthlyConsumptionModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    monthlyCostsModel.dispose();
    monthlyConsumptionModel.dispose();
  }
}
