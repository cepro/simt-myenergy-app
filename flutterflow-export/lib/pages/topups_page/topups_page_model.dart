import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/topup_list/topup_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'topups_page_widget.dart' show TopupsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopupsPageModel extends FlutterFlowModel<TopupsPageWidget> {
  ///  Local state fields for this page.

  List<TopupStruct> topups = [];
  void addToTopups(TopupStruct item) => topups.add(item);
  void removeFromTopups(TopupStruct item) => topups.remove(item);
  void removeAtIndexFromTopups(int index) => topups.removeAt(index);
  void insertAtIndexInTopups(int index, TopupStruct item) =>
      topups.insert(index, item);
  void updateTopupsAtIndex(int index, Function(TopupStruct) updateFn) =>
      topups[index] = updateFn(topups[index]);

  bool loadHistoryFailure = false;

  bool loadingHistory = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - activeUserToken] action in TopupsPage widget.
  String? userToken;
  // Stores action output result for [Backend Call - API (Get Topups)] action in TopupsPage widget.
  ApiCallResponse? getTopupsOutput;
  // Stores action output result for [Custom Action - topupsJSONToTopupsDataType] action in TopupsPage widget.
  List<TopupStruct>? topupsTyped;
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for TopupList component.
  late TopupListModel topupListModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    topupListModel = createModel(context, () => TopupListModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    topupListModel.dispose();
  }
}
