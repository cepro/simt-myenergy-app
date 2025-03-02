import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/property_list/property_list_widget.dart';
import '/components/sidebar_no_menu/sidebar_no_menu_widget.dart';
import '/components/stop_impersonating_link_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'property_selection_page_widget.dart' show PropertySelectionPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PropertySelectionPageModel
    extends FlutterFlowModel<PropertySelectionPageWidget> {
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

  // Stores action output result for [Custom Action - activeUserToken] action in PropertySelectionPage widget.
  String? userToken;
  // Stores action output result for [Backend Call - API (Get Topups)] action in PropertySelectionPage widget.
  ApiCallResponse? getTopupsOutput;
  // Stores action output result for [Custom Action - topupsJSONToTopupsDataType] action in PropertySelectionPage widget.
  List<TopupStruct>? topupsTyped;
  // Model for SidebarNoMenu component.
  late SidebarNoMenuModel sidebarNoMenuModel;
  // Model for ImpersonatingLink.
  late StopImpersonatingLinkModel impersonatingLinkModel;
  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;
  // Model for PropertyList component.
  late PropertyListModel propertyListModel;

  @override
  void initState(BuildContext context) {
    sidebarNoMenuModel = createModel(context, () => SidebarNoMenuModel());
    impersonatingLinkModel =
        createModel(context, () => StopImpersonatingLinkModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
    propertyListModel = createModel(context, () => PropertyListModel());
  }

  @override
  void dispose() {
    sidebarNoMenuModel.dispose();
    impersonatingLinkModel.dispose();
    logoutButtonModel.dispose();
    propertyListModel.dispose();
  }
}
