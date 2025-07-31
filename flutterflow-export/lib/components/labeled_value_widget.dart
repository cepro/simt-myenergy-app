import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'labeled_value_model.dart';
export 'labeled_value_model.dart';

class LabeledValueWidget extends StatefulWidget {
  const LabeledValueWidget({
    super.key,
    required this.label,
    this.value,
    this.buttonLabel,
    this.buttonAction,
  });

  final String? label;
  final String? value;

  /// If passed along with buttonAction a button will be rendered with this
  /// label.
  final String? buttonLabel;

  /// Used with buttonLabel to render a button and action.
  final Future Function()? buttonAction;

  @override
  State<LabeledValueWidget> createState() => _LabeledValueWidgetState();
}

class _LabeledValueWidgetState extends State<LabeledValueWidget> {
  late LabeledValueModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabeledValueModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Label',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                color: Color(0x8A000000),
                letterSpacing: 0.0,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  widget!.value,
                  'value',
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).titleLargeIsCustom,
                    ),
              ),
            ),
            if (widget!.buttonLabel != null && widget!.buttonLabel != '')
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await widget.buttonAction?.call();
                    },
                    text: widget!.buttonLabel!,
                    options: FFButtonOptions(
                      height: 25.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
