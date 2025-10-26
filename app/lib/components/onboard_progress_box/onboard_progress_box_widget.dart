import '/components/onboard_progress_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'onboard_progress_box_model.dart';
export 'onboard_progress_box_model.dart';

class OnboardProgressBoxWidget extends StatefulWidget {
  const OnboardProgressBoxWidget({
    super.key,
    required this.haveSupplyContract,
    required this.haveSolarContract,
    required this.confirmedDetails,
    required this.hasPaymentMethod,
    bool? isOccupier,
    bool? isOwner,
  })  : isOccupier = isOccupier ?? false,
        isOwner = isOwner ?? false;

  final bool? haveSupplyContract;
  final bool? haveSolarContract;
  final bool? confirmedDetails;
  final bool? hasPaymentMethod;
  final bool isOccupier;
  final bool isOwner;

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
      _model.actionsDonePercent = functions.onboardingActionsDonePercent(
          FFAppState().solarContractSigned,
          FFAppState().supplyContractSigned,
          widget.haveSolarContract!,
          widget.haveSupplyContract!,
          widget.hasPaymentMethod!,
          widget.confirmedDetails!,
          widget.isOccupier,
          widget.isOwner)!;
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
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Setup Progress',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .headlineMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .headlineMediumIsCustom,
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
                              context
                                  .pushNamed(UserProfilePageWidget.routeName);
                            },
                          ),
                        ),
                        if (widget.haveSupplyContract! && widget.isOccupier)
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
                        if (widget.haveSolarContract! && widget.isOwner)
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
                        if (widget.isOccupier)
                          wrapWithModel(
                            model: _model.onboardProgressRowModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: OnboardProgressRowWidget(
                              checked: FFAppState().customer.hasPaymentMethod,
                              title: 'Add your payment method',
                              linkLabel: 'Go to payments',
                              navigateAction: () async {
                                context.pushNamed(PaymentsPageWidget.routeName);
                              },
                            ),
                          ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (() {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return false;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return false;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return true;
                        } else {
                          return true;
                        }
                      }())
                        CircularPercentIndicator(
                          percent: _model.actionsDonePercent,
                          radius: 60.0,
                          lineWidth: 12.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor: FlutterFlowTheme.of(context).accent4,
                          center: Text(
                            formatNumber(
                              _model.actionsDonePercent,
                              formatType: FormatType.percent,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                      if (() {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return false;
                        } else {
                          return false;
                        }
                      }())
                        CircularPercentIndicator(
                          percent: _model.actionsDonePercent,
                          radius: 40.0,
                          lineWidth: 8.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor: FlutterFlowTheme.of(context).accent4,
                          center: Text(
                            formatNumber(
                              _model.actionsDonePercent,
                              formatType: FormatType.percent,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
