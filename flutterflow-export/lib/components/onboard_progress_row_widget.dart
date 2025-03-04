import '';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboard_progress_row_model.dart';
export 'onboard_progress_row_model.dart';

class OnboardProgressRowWidget extends StatefulWidget {
  const OnboardProgressRowWidget({
    super.key,
    required this.checked,
    required this.title,
    this.linkLabel,
    this.navigateAction,
  });

  final bool? checked;
  final String? title;
  final String? linkLabel;
  final Future Function()? navigateAction;

  @override
  State<OnboardProgressRowWidget> createState() =>
      _OnboardProgressRowWidgetState();
}

class _OnboardProgressRowWidgetState extends State<OnboardProgressRowWidget> {
  late OnboardProgressRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardProgressRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget!.checked ?? true)
            Icon(
              Icons.check_box,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
          if (!widget!.checked!)
            Icon(
              Icons.access_time_filled,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget!.title,
                    'unknown',
                  ),
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).titleMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).titleMediumFamily),
                      ),
                ),
                if (widget!.linkLabel != null && widget!.linkLabel != '')
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await widget.navigateAction?.call();
                    },
                    child: Text(
                      valueOrDefault<String>(
                        widget!.linkLabel,
                        'unknown',
                      ),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            decoration: TextDecoration.underline,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
