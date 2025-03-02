import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stop_impersonating_link_model.dart';
export 'stop_impersonating_link_model.dart';

class StopImpersonatingLinkWidget extends StatefulWidget {
  const StopImpersonatingLinkWidget({super.key});

  @override
  State<StopImpersonatingLinkWidget> createState() =>
      _StopImpersonatingLinkWidgetState();
}

class _StopImpersonatingLinkWidgetState
    extends State<StopImpersonatingLinkWidget> {
  late StopImpersonatingLinkModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StopImpersonatingLinkModel());

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

    return Visibility(
      visible: FFAppState().impersonationToken != null &&
          FFAppState().impersonationToken != '',
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(ImpersonateUserWidget.routeName);
          },
          child: Text(
            'Impersonating ${FFAppState().impersonationEmail}',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).error,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).bodyMediumFamily),
                ),
          ),
        ),
      ),
    );
  }
}
