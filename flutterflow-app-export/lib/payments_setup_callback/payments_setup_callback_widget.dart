import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payments_setup_callback_model.dart';
export 'payments_setup_callback_model.dart';

class PaymentsSetupCallbackWidget extends StatefulWidget {
  const PaymentsSetupCallbackWidget({Key? key}) : super(key: key);

  @override
  _PaymentsSetupCallbackWidgetState createState() =>
      _PaymentsSetupCallbackWidgetState();
}

class _PaymentsSetupCallbackWidgetState
    extends State<PaymentsSetupCallbackWidget> {
  late PaymentsSetupCallbackModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentsSetupCallbackModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'This is a landing page that stripe will redirect to after payment setup has completed.\n\nIt might possibly fold into the main payments or settings page eventually. We could detect in initState that it was from stripe and handle appropriately.',
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
