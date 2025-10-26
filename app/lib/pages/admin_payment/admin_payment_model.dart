import '/components/admin_initiate_payment_widget.dart';
import '/components/sidebar_property_list/sidebar_property_list_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'admin_payment_widget.dart' show AdminPaymentWidget;
import 'package:flutter/material.dart';

class AdminPaymentModel extends FlutterFlowModel<AdminPaymentWidget> {
  ///  Local state fields for this page.

  String errorMessage = 'unknown';

  bool paymentSuccess = false;

  bool? sendPaymentFailure = false;

  ///  State fields for stateful widgets in this page.

  // Model for SidebarPropertyList component.
  late SidebarPropertyListModel sidebarPropertyListModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for AdminInitiatePayment component.
  late AdminInitiatePaymentModel adminInitiatePaymentModel;

  @override
  void initState(BuildContext context) {
    sidebarPropertyListModel =
        createModel(context, () => SidebarPropertyListModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    adminInitiatePaymentModel =
        createModel(context, () => AdminInitiatePaymentModel());
  }

  @override
  void dispose() {
    sidebarPropertyListModel.dispose();
    topBarLoggedInModel.dispose();
    adminInitiatePaymentModel.dispose();
  }
}
