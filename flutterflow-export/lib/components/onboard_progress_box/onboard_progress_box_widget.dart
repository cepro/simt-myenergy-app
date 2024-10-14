import '/components/onboard_progress_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboard_progress_box_model.dart';
export 'onboard_progress_box_model.dart';

class OnboardProgressBoxWidget extends StatefulWidget {
  const OnboardProgressBoxWidget({super.key});

  @override
  State<OnboardProgressBoxWidget> createState() =>
      _OnboardProgressBoxWidgetState();
}

class _OnboardProgressBoxWidgetState extends State<OnboardProgressBoxWidget> {
  late OnboardProgressBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardProgressBoxModel());

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
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
                        'Onboarding Progress',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .headlineMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .headlineMediumFamily),
                            ),
                      ),
                    ],
                  ),
                  wrapWithModel(
                    model: _model.onboardProgressRowModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: OnboardProgressRowWidget(
                      checked: true,
                      title: 'Accept your invitation',
                      navigateAction: () async {},
                    ),
                  ),
                  wrapWithModel(
                    model: _model.onboardProgressRowModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: OnboardProgressRowWidget(
                      checked: FFAppState().customer.confirmedDetailsAt != null,
                      title: 'Confirm your contact details',
                      linkLabel: 'Go to profile',
                      navigateAction: () async {
                        context.pushNamed('UserProfilePage');
                      },
                    ),
                  ),
                  if (FFAppState().haveSupplyContract)
                    wrapWithModel(
                      model: _model.onboardProgressRowModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: OnboardProgressRowWidget(
                        checked: FFAppState().supplyContractSigned,
                        title: 'Sign your supply contract',
                        linkLabel: 'Go to contract',
                        navigateAction: () async {
                          await action_blocks.openSupplyContract(context);
                        },
                      ),
                    ),
                  if (FFAppState().haveSolarContract)
                    wrapWithModel(
                      model: _model.onboardProgressRowModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: OnboardProgressRowWidget(
                        checked: FFAppState().solarContractSigned,
                        title: 'Sign your solar contract',
                        linkLabel: 'Go to contract',
                        navigateAction: () async {
                          await action_blocks.openSolarContract(context);
                        },
                      ),
                    ),
                  wrapWithModel(
                    model: _model.onboardProgressRowModel5,
                    updateCallback: () => safeSetState(() {}),
                    child: OnboardProgressRowWidget(
                      checked: false,
                      title: 'Add your payment method',
                      linkLabel: 'Go to payments',
                      navigateAction: () async {
                        context.pushNamed('PaymentsPage');
                      },
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
