import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/change_phone_number_modal/change_phone_number_modal_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'user_profile_page_widget.dart' show UserProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfilePageModel extends FlutterFlowModel<UserProfilePageWidget> {
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

  TariffsStruct? tariffs;
  void updateTariffsStruct(Function(TariffsStruct) updateFn) {
    updateFn(tariffs ??= TariffsStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - decodeSupabaseJwt] action in UserProfilePage widget.
  SupabaseUserStruct? decodeTokenForProfileResponse;
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Stores action output result for [Backend Call - API (Customer details confirmed)] action in ConfirmDetails widget.
  ApiCallResponse? customerDetailsConfirmedResponse;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
  }
}
