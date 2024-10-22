import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'coming_soon_for_preonboarding_model.dart';
export 'coming_soon_for_preonboarding_model.dart';

class ComingSoonForPreonboardingWidget extends StatefulWidget {
  const ComingSoonForPreonboardingWidget({super.key});

  @override
  State<ComingSoonForPreonboardingWidget> createState() =>
      _ComingSoonForPreonboardingWidgetState();
}

class _ComingSoonForPreonboardingWidgetState
    extends State<ComingSoonForPreonboardingWidget> {
  late ComingSoonForPreonboardingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComingSoonForPreonboardingModel());

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
      visible: FFAppState().customer.status == 'preonboarding',
      child: Align(
        alignment: AlignmentDirectional(-1.0, 0.0),
        child: Text(
          'Coming Soon!',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
              ),
        ),
      ),
    );
  }
}
