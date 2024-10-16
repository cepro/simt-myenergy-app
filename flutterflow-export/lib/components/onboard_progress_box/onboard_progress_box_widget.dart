import '/components/onboard_progress_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.actionsDone =
          (bool solarSigned, bool supplySigned, bool confirmedDetails) {
        return [solarSigned, supplySigned, confirmedDetails]
                .where((value) => value)
                .length +
            1;
      }(FFAppState().solarContractSigned, FFAppState().supplyContractSigned,
              (FFAppState().customer.confirmedDetailsAt != null));
      safeSetState(() {});
    });

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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Onboarding Progress',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
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
                            checked: FFAppState().customer.confirmedDetailsAt !=
                                null,
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
                      child: CircularPercentIndicator(
                        percent: _model.actionsDone / 5,
                        radius: 60.0,
                        lineWidth: 12.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).primary,
                        backgroundColor: FlutterFlowTheme.of(context).accent4,
                        center: Text(
                          '${formatNumber(
                            _model.actionsDone / 5,
                            formatType: FormatType.percent,
                          )}',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineSmallFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .headlineSmallFamily),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
