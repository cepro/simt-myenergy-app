import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'labeled_value_with_unit_model.dart';
export 'labeled_value_with_unit_model.dart';

class LabeledValueWithUnitWidget extends StatefulWidget {
  const LabeledValueWithUnitWidget({
    super.key,
    required this.label,
    this.value,
    required this.unit,
  });

  final String? label;
  final String? value;
  final String? unit;

  @override
  State<LabeledValueWithUnitWidget> createState() =>
      _LabeledValueWithUnitWidgetState();
}

class _LabeledValueWithUnitWidgetState
    extends State<LabeledValueWithUnitWidget> {
  late LabeledValueWithUnitModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabeledValueWithUnitModel());

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
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              valueOrDefault<String>(
                widget.label,
                'Label',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: const Color(0x8A000000),
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  valueOrDefault<String>(
                    widget.unit,
                    'Unit',
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        color: const Color(0xFF04A2F2),
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              widget.value,
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
      ],
    );
  }
}
