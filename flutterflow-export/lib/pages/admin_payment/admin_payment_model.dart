import '/components/admin_initiate_payment_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'admin_payment_widget.dart' show AdminPaymentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminPaymentModel extends FlutterFlowModel<AdminPaymentWidget> {
  ///  Local state fields for this page.

  String errorMessage = 'unknown';

  bool paymentSuccess = false;

  bool? sendPaymentFailure = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for TopBarLoggedIn component.
  late TopBarLoggedInModel topBarLoggedInModel;
  // Model for AdminInitiatePayment component.
  late AdminInitiatePaymentModel adminInitiatePaymentModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    topBarLoggedInModel = createModel(context, () => TopBarLoggedInModel());
    adminInitiatePaymentModel =
        createModel(context, () => AdminInitiatePaymentModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    topBarLoggedInModel.dispose();
    adminInitiatePaymentModel.dispose();
  }
}
