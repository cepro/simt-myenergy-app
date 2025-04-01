import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/monthly_costs/monthly_costs_widget.dart';
import '/components/monthly_generation/monthly_generation_widget.dart';
import '/components/monthly_usage/monthly_usage_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_energy_page_model.dart';
export 'my_energy_page_model.dart';

class MyEnergyPageWidget extends StatefulWidget {
  const MyEnergyPageWidget({super.key});

  static String routeName = 'MyEnergyPage';
  static String routePath = '/myenergy';

  @override
  State<MyEnergyPageWidget> createState() => _MyEnergyPageWidgetState();
}

class _MyEnergyPageWidgetState extends State<MyEnergyPageWidget> {
  late MyEnergyPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyEnergyPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // First time only load usage, costs and tariffs in the background which will speed up the first load of MyEnergy page.
      if ((!FFAppState().monthlyCostsLoading &&
              !FFAppState().monthlyUsageLoading) &&
          ((FFAppState().tariffs == null) ||
              (functions.diffNowInMinutes(
                      FFAppState().lastMonthlyCostAndUsageLoad!) >=
                  10))) {
        // RefreshTariffsCostsUsage
        await action_blocks.getTariffsCostsUsage(context);
        return;
      } else {
        return;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.mainWebNavModel,
                updateCallback: () => safeSetState(() {}),
                child: MainWebNavWidget(
                  navOne: FlutterFlowTheme.of(context).secondaryText,
                  navTwo: FlutterFlowTheme.of(context).alternate,
                  navThree: FlutterFlowTheme.of(context).secondaryText,
                  navFour: FlutterFlowTheme.of(context).secondaryText,
                  navFive: FlutterFlowTheme.of(context).secondaryText,
                  navSix: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 100.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 1024.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            wrapWithModel(
                              model: _model.topBarLoggedInModel,
                              updateCallback: () => safeSetState(() {}),
                              child: TopBarLoggedInWidget(),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Divider(
                                height: 44.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                            if (responsiveVisibility(
                              context: context,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              Divider(
                                height: 24.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Energy',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily),
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        wrapWithModel(
                                          model: _model
                                              .propertyNameWithTooltipModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              PropertyNameWithTooltipWidget(),
                                        ),
                                        if (responsiveVisibility(
                                          context: context,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                      PropertySelectionPageWidget
                                                          .routeName);
                                                },
                                                text: 'Change',
                                                options: FFButtonOptions(
                                                  height: 25.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmallFamily),
                                                          ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (FFAppState()
                                    .supplyAccount
                                    .customerAccount
                                    .role ==
                                'occupier')
                              wrapWithModel(
                                model: _model.monthlyCostsModel,
                                updateCallback: () => safeSetState(() {}),
                                child: MonthlyCostsWidget(),
                              ),
                            if (FFAppState()
                                    .supplyAccount
                                    .customerAccount
                                    .role ==
                                'occupier')
                              wrapWithModel(
                                model: _model.monthlyUsageModel,
                                updateCallback: () => safeSetState(() {}),
                                child: MonthlyUsageWidget(),
                              ),
                            if (FFAppState()
                                    .solarAccount
                                    .customerAccount
                                    .role ==
                                'owner')
                              wrapWithModel(
                                model: _model.monthlyGenerationModel,
                                updateCallback: () => safeSetState(() {}),
                                child: MonthlyGenerationWidget(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
