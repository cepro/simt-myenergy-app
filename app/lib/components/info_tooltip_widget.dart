import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'info_tooltip_model.dart';
export 'info_tooltip_model.dart';

class InfoTooltipWidget extends StatefulWidget {
  const InfoTooltipWidget({
    super.key,
    required this.infoText,
  });

  final String? infoText;

  @override
  State<InfoTooltipWidget> createState() => _InfoTooltipWidgetState();
}

class _InfoTooltipWidgetState extends State<InfoTooltipWidget> {
  late InfoTooltipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoTooltipModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
      child: AlignedTooltip(
        content: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            widget!.infoText!,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyLargeIsCustom,
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
        waitDuration: Duration(milliseconds: 100),
        showDuration: Duration(milliseconds: 5000),
        triggerMode: TooltipTriggerMode.tap,
        child: Icon(
          Icons.info_outline,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 22.0,
        ),
      ),
    );
  }
}
