import '/backend/schema/structs/index.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/property_list/property_list_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'property_selection_page_widget.dart' show PropertySelectionPageWidget;
import 'package:flutter/material.dart';
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

  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PropertyList component.
  late PropertyListModel propertyListModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    propertyListModel = createModel(context, () => PropertyListModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    propertyListModel.dispose();
  }
}
