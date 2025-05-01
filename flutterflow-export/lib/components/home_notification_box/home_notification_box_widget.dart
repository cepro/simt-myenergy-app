import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_notification_box_model.dart';
export 'home_notification_box_model.dart';

class HomeNotificationBoxWidget extends StatefulWidget {
  const HomeNotificationBoxWidget({super.key});

  @override
  State<HomeNotificationBoxWidget> createState() =>
      _HomeNotificationBoxWidgetState();
}

class _HomeNotificationBoxWidgetState extends State<HomeNotificationBoxWidget> {
  late HomeNotificationBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeNotificationBoxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).black600,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Notice - Upcoming payment',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: FlutterFlowTheme.of(context).headlineMedium,
                          color: FlutterFlowTheme.of(context).black600,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      'A payment for ${functions.formatGBPAmount(FFAppState().pendingPayments.firstOrNull!.amount.toDouble() / 100.0)} is scheduled for ${dateTimeFormat("dd/MM/yyyy HH:mm:ss", FFAppState().pendingPayments.firstOrNull?.scheduledAt)}.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: FlutterFlowTheme.of(context).bodyMedium,
                            color: FlutterFlowTheme.of(context).gray600,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
