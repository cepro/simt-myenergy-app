import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'property_name_with_tooltip_model.dart';
export 'property_name_with_tooltip_model.dart';

class PropertyNameWithTooltipWidget extends StatefulWidget {
  const PropertyNameWithTooltipWidget({super.key});

  @override
  State<PropertyNameWithTooltipWidget> createState() =>
      _PropertyNameWithTooltipWidgetState();
}

class _PropertyNameWithTooltipWidgetState
    extends State<PropertyNameWithTooltipWidget> {
  late PropertyNameWithTooltipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyNameWithTooltipModel());

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

    return AlignedTooltip(
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          '${FFAppState().property.plot}  Owner: ${FFAppState().property.ownerEmail}',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                letterSpacing: 0.0,
                useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
              ),
        ),
      ),
      offset: 4.0,
      preferredDirection: AxisDirection.down,
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      elevation: 4.0,
      tailBaseWidth: 24.0,
      tailLength: 12.0,
      waitDuration: const Duration(milliseconds: 100),
      showDuration: const Duration(milliseconds: 1500),
      triggerMode: TooltipTriggerMode.tap,
      child: Visibility(
        visible: FFAppState().properties.isNotEmpty,
        child: Text(
          FFAppState().property.description,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                letterSpacing: 0.0,
                useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
              ),
        ),
      ),
    );
  }
}
