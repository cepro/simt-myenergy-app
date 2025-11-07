import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/monthly_costs/monthly_costs_widget.dart';
import '/components/monthly_generation/monthly_generation_widget.dart';
import '/components/monthly_usage/monthly_usage_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/custom_code/actions/build_monthly_costs_chart_url.dart'
    as build_costs_chart;
import '/custom_code/actions/build_monthly_usage_chart_url.dart'
    as build_usage_chart;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'my_energy_page_v2_model.dart';
export 'my_energy_page_v2_model.dart';

class MyEnergyPageV2Widget extends StatefulWidget {
  const MyEnergyPageV2Widget({super.key});

  static String routeName = 'MyEnergyPageV2';
  static String routePath = '/myenergyv2';

  @override
  State<MyEnergyPageV2Widget> createState() => _MyEnergyPageV2WidgetState();
}

class _MyEnergyPageV2WidgetState extends State<MyEnergyPageV2Widget> {
  late MyEnergyPageV2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Graph URLs - built dynamically from data
  String _costsGraphUrl = '';
  String _energyGraphUrl = '';

  /// Gets the dynamic chart width based on screen size
  int get _chartWidth {
    final screenWidth = MediaQuery.of(context).size.width;

    // Mobile: smaller width
    if (screenWidth < 768) {
      return 400;
    }
    // Tablet: medium width
    else if (screenWidth < 1024) {
      return 600;
    }
    // Desktop: larger width
    else {
      return 1000;
    }
  }

  /// Builds the costs chart URL from monthly costs data
  Future<void> _buildCostsChartUrl() async {
    if (FFAppState().monthlyCosts.isNotEmpty) {
      final url = await build_costs_chart.buildMonthlyCostsChartUrl(
          FFAppState().monthlyCosts, width: _chartWidth);
      if (mounted) {
        setState(() {
          _costsGraphUrl = url;
        });
      }
    }
  }

  /// Builds the energy usage chart URL from monthly usage data
  Future<void> _buildEnergyChartUrl() async {
    if (FFAppState().monthlyUsage.isNotEmpty) {
      final url = await build_usage_chart.buildMonthlyUsageChartUrl(
          FFAppState().monthlyUsage, width: _chartWidth);
      if (mounted) {
        setState(() {
          _energyGraphUrl = url;
        });
      }
    }
  }

  /// Gets the costs graph URL, building it if necessary
  String get costsGraphUrl {
    if (_costsGraphUrl.isEmpty && FFAppState().monthlyCosts.isNotEmpty) {
      // Build URL asynchronously
      _buildCostsChartUrl();
      // Return placeholder while building
      return 'https://quickchart.io/chart?c=%7B%22type%22%3A%22bar%22%7D&width=550&height=350';
    }
    return _costsGraphUrl;
  }

  /// Gets the energy graph URL, building it if necessary
  String get energyGraphUrl {
    if (_energyGraphUrl.isEmpty && FFAppState().monthlyUsage.isNotEmpty) {
      // Build URL asynchronously
      _buildEnergyChartUrl();
      // Return placeholder while building
      return 'https://quickchart.io/chart?c=%7B%22type%22%3A%22line%22%7D&width=550&height=350';
    }
    return _energyGraphUrl;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyEnergyPageV2Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Build chart URLs from existing data
      await _buildCostsChartUrl();
      await _buildEnergyChartUrl();

      // First time only load usage, costs and tariffs in the background which will speed up the first load of MyEnergy page.
      if ((!FFAppState().monthlyCostsLoading &&
              !FFAppState().monthlyUsageLoading) &&
          ((FFAppState().tariffs == null) ||
              (functions.diffNowInMinutes(
                      FFAppState().lastMonthlyCostAndUsageLoad!) >=
                  10))) {
        // RefreshTariffsCostsUsage
        await action_blocks.getTariffsCostsUsage(context);

        // Rebuild chart URLs after loading new data
        await _buildCostsChartUrl();
        await _buildEnergyChartUrl();
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

  Widget _buildGraphPane(String imageUrl, String title, String emoji) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).lineColor,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  emoji,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'NotoColorEmoji',
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                  child: Text(
                    title,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SvgPicture.network(
                  imageUrl,
                  width: double.infinity,
                  height: 400.0,
                  fit: BoxFit.contain,
                  placeholderBuilder: (context) => Container(
                    width: double.infinity,
                    height: 400.0,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                        const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 100.0),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 1024.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            wrapWithModel(
                              model: _model.topBarLoggedInModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const TopBarLoggedInWidget(),
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
                              alignment: const AlignmentDirectional(-1.0, 0.0),
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
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .headlineMediumIsCustom,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
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
                                              const PropertyNameWithTooltipWidget(),
                                        ),
                                        if (responsiveVisibility(
                                          context: context,
                                          tabletLandscape: false,
                                          desktop: false,
                                        ))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 1.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
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
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
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
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallIsCustom,
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: _buildGraphPane(
                                    costsGraphUrl, 'Cost Breakdown', '💰'),
                              ),
                            if (FFAppState()
                                    .supplyAccount
                                    .customerAccount
                                    .role ==
                                'occupier')
                              wrapWithModel(
                                model: _model.monthlyCostsModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const MonthlyCostsWidget(),
                              ),
                            if (FFAppState()
                                    .supplyAccount
                                    .customerAccount
                                    .role ==
                                'occupier')
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: _buildGraphPane(
                                    energyGraphUrl, 'Energy Forecast', '⚡'),
                              ),
                            if (FFAppState()
                                    .supplyAccount
                                    .customerAccount
                                    .role ==
                                'occupier')
                              wrapWithModel(
                                model: _model.monthlyUsageModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const MonthlyUsageWidget(),
                              ),
                            if (FFAppState()
                                    .solarAccount
                                    .customerAccount
                                    .role ==
                                'owner')
                              wrapWithModel(
                                model: _model.monthlyGenerationModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const MonthlyGenerationWidget(),
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
