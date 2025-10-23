import '/components/property_list/property_list_widget.dart';
import '/components/property_table/property_table_widget.dart';
import '/components/sidebar_property_list/sidebar_property_list_widget.dart';
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

  String errorMessage = 'unknown';

  bool paymentSuccess = false;

  bool? sendPaymentFailure = false;

  ///  State fields for stateful widgets in this page.

  // Model for SidebarPropertyList component.
  late SidebarPropertyListModel sidebarPropertyListModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for PropertyList component.
  late PropertyListModel propertyListModel;
  // Model for PropertyTable component.
  late PropertyTableModel propertyTableModel;

  @override
  void initState(BuildContext context) {
    sidebarPropertyListModel =
        createModel(context, () => SidebarPropertyListModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    propertyListModel = createModel(context, () => PropertyListModel());
    propertyTableModel = createModel(context, () => PropertyTableModel());
  }

  @override
  void dispose() {
    sidebarPropertyListModel.dispose();
    topBarLoggedInModel.dispose();
    propertyListModel.dispose();
    propertyTableModel.dispose();
  }
}
