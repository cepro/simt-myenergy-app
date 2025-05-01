import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  });

  final String? label;
  final String? value;

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
                font: FlutterFlowTheme.of(context).bodyMedium,
                color: Color(0x8A000000),
                letterSpacing: 0.0,
              ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              widget!.value,
              'value',
            ),
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: FlutterFlowTheme.of(context).titleLarge,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }
}
