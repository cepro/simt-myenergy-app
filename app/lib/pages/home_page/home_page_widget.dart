import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/home_notification_box/home_notification_box_widget.dart';
import '/components/info_tooltip_widget.dart';
import '/components/labeled_value_widget.dart';
import '/components/labeled_value_with_unit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/onboard_progress_box/onboard_progress_box_widget.dart';
import '/components/product_roadmap_box/product_roadmap_box_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/solar_contract_row/solar_contract_row_widget.dart';
import '/components/supply_contract_row/supply_contract_row_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/welcome_box/welcome_box_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/home';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      if (!FFAppState().isCeproUser) {
        await action_blocks.setContractStatusFlags(context);
        safeSetState(() {});
        _model.solarMeter = await actions.getMeterByType(
          FFAppState().property,
          'solar',
          FFAppState().meters,
        );
        _model.supplyMeter = await actions.getMeterByType(
          FFAppState().property,
          'supply',
          FFAppState().meters,
        );
        _model.getSolarInstallationOutput =
            await actions.getSolarInstallationById(
          FFAppState().solarInstallations,
          FFAppState().property.id,
        );
        _model.userToken = await actions.activeUserToken();
        _model.homePageGetWallets = await GetWalletsCall.call(
          bearerToken: _model.userToken,
        );

        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
        if ((_model.homePageGetWallets?.succeeded != false) &&
            ((_model.homePageGetWallets?.jsonBody ?? '') != null)) {
          _model.singleWalletBalance = functions.formatGBPAmount(getJsonField(
            (_model.homePageGetWallets?.jsonBody ?? ''),
            r'''$[0].balance''',
          ));
          _model.inPrepayMode = functions.isPrepayMode(_model.supplyMeter);
          _model.supplyTariffCurrent =
              functions.supplyTariffCurrent(FFAppState().tariffs);
          _model.solarCreditTariffCurrent =
              functions.solarTariffCurrent(FFAppState().tariffs);
          safeSetState(() {});
          await Future.wait([
            Future(() async {
              // First time only load usage, costs and tariffs in the background which will speed up the first load of MyEnergy page.
              if ((FFAppState().tariffs == null) ||
                  (functions.diffNowInMinutes(
                          FFAppState().lastMonthlyCostAndUsageLoad!) >=
                      10)) {
                // GetUsageInBackground
                await action_blocks.getTariffsCostsUsage(context);
                _model.supplyTariffCurrent =
                    functions.supplyTariffCurrent(FFAppState().tariffs);
                _model.solarCreditTariffCurrent =
                    functions.solarTariffCurrent(FFAppState().tariffs);
                safeSetState(() {});
                return;
              } else {
                return;
              }
            }),
            Future(() async {
              if (functions.diffNowInMinutes(
                      FFAppState().lastPendingPaymentsLoad!) >=
                  10) {
                await action_blocks.pendingPayments(context);
                return;
              } else {
                return;
              }
            }),
          ]);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failure getting wallet balance',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: const Duration(milliseconds: 10000),
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          );
          return;
        }
      } else {
        context.pushNamed(PropertySelectionPageWidget.routeName);

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
                  navOne: FlutterFlowTheme.of(context).alternate,
                  navTwo: FlutterFlowTheme.of(context).secondaryText,
                  navThree: FlutterFlowTheme.of(context).secondaryText,
                  navFour: FlutterFlowTheme.of(context).secondaryText,
                  navFive: FlutterFlowTheme.of(context).secondaryText,
                  navSix: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                key: const ValueKey('scrollingColumn'),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 0.0, 15.0, 100.0),
                      child: Container(
                        key: const ValueKey('maxWidthContainer'),
                        constraints: const BoxConstraints(
                          maxWidth: 1024.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            key: const ValueKey('mainPageColumn'),
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
                                  key: const ValueKey('welcomeColumn'),
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                      child: Text(
                                        'Welcome ${FFAppState().customer.name}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmallFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts:
                                                  !FlutterFlowTheme.of(context)
                                                      .bodySmallIsCustom,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      'Property',
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
                                              alignment: const AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                        PropertySelectionPageWidget
                                                            .routeName);
                                                  },
                                                  text: 'Change',
                                                  options: FFButtonOptions(
                                                    height: 25.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                              !FlutterFlowTheme
                                                                      .of(context)
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
                              if (FFAppState().pendingPayments.isNotEmpty)
                                wrapWithModel(
                                  model: _model.homeNotificationBoxModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const HomeNotificationBoxWidget(),
                                ),
                              if ((FFAppState().customer.status ==
                                      'preonboarding') ||
                                  (FFAppState().customer.status ==
                                      'onboarding') ||
                                  (FFAppState().customer.status == 'pending'))
                                wrapWithModel(
                                  model: _model.onboardProgressBoxModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: OnboardProgressBoxWidget(
                                    haveSupplyContract:
                                        FFAppState().haveSupplyContract,
                                    haveSolarContract:
                                        FFAppState().haveSolarContract,
                                    confirmedDetails: FFAppState()
                                            .customer
                                            .confirmedDetailsAt !=
                                        null,
                                    hasPaymentMethod:
                                        FFAppState().customer.hasPaymentMethod,
                                    isOccupier: FFAppState()
                                            .supplyAccount
                                            .customerAccount
                                            .role ==
                                        'occupier',
                                    isOwner: FFAppState()
                                            .solarAccount
                                            .customerAccount
                                            .role ==
                                        'owner',
                                  ),
                                ),
                              wrapWithModel(
                                model: _model.welcomeBoxModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const WelcomeBoxWidget(),
                              ),
                              wrapWithModel(
                                model: _model.productRoadmapBoxModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const ProductRoadmapBoxWidget(),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 30.0, 0.0, 0.0),
                                child: Container(
                                  key: const ValueKey('supplyAccountView'),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          key: const ValueKey('supplyHeader'),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: Icon(
                                                    Icons
                                                        .lightbulb_outline_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    size: 32.0,
                                                  ),
                                                ),
                                                AlignedTooltip(
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(4.0),
                                                    child: Text(
                                                      'Role: ${FFAppState().supplyAccount.customerAccount.role}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                    ),
                                                  ),
                                                  offset: 4.0,
                                                  preferredDirection:
                                                      AxisDirection.down,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 4.0,
                                                  tailBaseWidth: 24.0,
                                                  tailLength: 12.0,
                                                  waitDuration: const Duration(
                                                      milliseconds: 100),
                                                  showDuration: const Duration(
                                                      milliseconds: 1500),
                                                  triggerMode:
                                                      TooltipTriggerMode.tap,
                                                  child: Text(
                                                    'Electricity Supply',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: Wrap(
                                            key: const ValueKey('supplyRow1'),
                                            spacing: 10.0,
                                            runSpacing: 0.0,
                                            alignment: WrapAlignment.center,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            direction: Axis.horizontal,
                                            runAlignment: WrapAlignment.start,
                                            verticalDirection:
                                                VerticalDirection.down,
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                constraints: const BoxConstraints(
                                                  minWidth: 300.0,
                                                ),
                                                decoration: const BoxDecoration(),
                                                child: Visibility(
                                                  visible: _model.supplyMeter !=
                                                      null,
                                                  child: Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    elevation: 3.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .electric_bolt,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 24.0,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Meter Details',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
                                                                        0.0,
                                                                        12.0),
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .labeledValueModel1,
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  LabeledValueWidget(
                                                                label: 'Mode',
                                                                value: _model
                                                                            .inPrepayMode ==
                                                                        null
                                                                    ? 'Mode:  loading ...'
                                                                    : (_model
                                                                            .inPrepayMode!
                                                                        ? 'Mode:  Prepayment'
                                                                        : 'Mode:  Credit'),
                                                                buttonAction:
                                                                    () async {},
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        12.0),
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .labeledValueModel2,
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  LabeledValueWidget(
                                                                label: 'Serial',
                                                                value: _model
                                                                    .supplyMeter
                                                                    ?.serial,
                                                                buttonAction:
                                                                    () async {},
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minWidth: 200.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child: Visibility(
                                                              visible: (_model
                                                                          .supplyMeter !=
                                                                      null) &&
                                                                  _model
                                                                      .supplyMeter!
                                                                      .prepayEnabled,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            16.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Current Balance',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color:
                                                                                const Color(0x8A000000),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            8.0,
                                                                            0.0,
                                                                            16.0),
                                                                    child: Text(
                                                                      functions.formatGBPAmount(_model
                                                                          .supplyMeter
                                                                          ?.balance),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleLarge
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleLargeFamily,
                                                                            color:
                                                                                const Color(0xFF388E3C),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: const BoxConstraints(
                                                  minWidth: 300.0,
                                                ),
                                                decoration: const BoxDecoration(),
                                                child: Visibility(
                                                  visible: _model
                                                          .supplyTariffCurrent !=
                                                      null,
                                                  child: Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    elevation: 3.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .bar_chart,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 24.0,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Tariff Information',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                        ),
                                                                  ),
                                                                ),
                                                                wrapWithModel(
                                                                  model: _model
                                                                      .infoTooltipModel1,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      InfoTooltipWidget(
                                                                    infoText:
                                                                        'Benchmark Tariff: ${functions.formatGBPAmount(0.51)}${functions.newLineChar()}See ofgem rates at ...',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (_model
                                                                  .supplyTariffCurrent
                                                                  ?.unitRate !=
                                                              null)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          12.0),
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .labeledValueWithUnitModel1,
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    LabeledValueWithUnitWidget(
                                                                  label:
                                                                      'Unit Rate',
                                                                  value: functions
                                                                      .formatGBPPenceAmount(_model
                                                                          .supplyTariffCurrent!
                                                                          .unitRate),
                                                                  unit:
                                                                      'Per kWh',
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model
                                                                  .supplyTariffCurrent
                                                                  ?.standingCharge !=
                                                              null)
                                                            wrapWithModel(
                                                              model: _model
                                                                  .labeledValueWithUnitModel2,
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  LabeledValueWithUnitWidget(
                                                                label:
                                                                    'Standing Charge',
                                                                value: functions
                                                                    .formatGBPPenceAmount(_model
                                                                        .supplyTariffCurrent!
                                                                        .standingCharge),
                                                                unit: 'Per Day',
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: const BoxConstraints(
                                                  maxWidth: 400.0,
                                                ),
                                                decoration: const BoxDecoration(),
                                                child: Visibility(
                                                  visible: FFAppState()
                                                          .supplyContractSigned &&
                                                      (FFAppState()
                                                              .supplyAccount
                                                              .customerAccount
                                                              .role ==
                                                          'occupier') &&
                                                      (FFAppState()
                                                              .contractTerms !=
                                                          null) &&
                                                      (FFAppState()
                                                              .contractTerms
                                                              .where((e) =>
                                                                  e.type ==
                                                                  'supply')
                                                              .toList().isNotEmpty) &&
                                                      (functions.getContractByType(
                                                              FFAppState()
                                                                  .accountsForCurrentProperty
                                                                  .toList(),
                                                              'supply') !=
                                                          null),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 16.0,
                                                                0.0, 0.0),
                                                    child: Card(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 3.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(
                                                            16.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .edit_document,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 24.0,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Contract Details',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  wrapWithModel(
                                                                model: _model
                                                                    .supplyContractRowModel,
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    SupplyContractRowWidget(
                                                                  isSigned: functions.getContractByType(FFAppState().accountsForCurrentProperty.toList(), 'supply')?.signedDate !=
                                                                          null &&
                                                                      functions
                                                                              .getContractByType(FFAppState().accountsForCurrentProperty.toList(), 'supply')
                                                                              ?.signedDate !=
                                                                          '',
                                                                  contract: functions.getContractByType(
                                                                      FFAppState()
                                                                          .accountsForCurrentProperty
                                                                          .toList(),
                                                                      'supply')!,
                                                                  contractTerms: FFAppState()
                                                                      .contractTerms
                                                                      .where((e) =>
                                                                          e.type ==
                                                                          'supply')
                                                                      .toList()
                                                                      .firstOrNull ??
                                                                      ContractTermsStruct(),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
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
                                ),
                              ),
                              if (FFAppState().haveSolarContract)
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Icon(
                                                      Icons
                                                          .solar_power_outlined,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      size: 32.0,
                                                    ),
                                                  ),
                                                  AlignedTooltip(
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(4.0),
                                                      child: Text(
                                                        'Role: ${FFAppState().supplyAccount.customerAccount.role}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLargeFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyLargeIsCustom,
                                                                ),
                                                      ),
                                                    ),
                                                    offset: 4.0,
                                                    preferredDirection:
                                                        AxisDirection.down,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    elevation: 4.0,
                                                    tailBaseWidth: 24.0,
                                                    tailLength: 12.0,
                                                    waitDuration: const Duration(
                                                        milliseconds: 100),
                                                    showDuration: const Duration(
                                                        milliseconds: 1500),
                                                    triggerMode:
                                                        TooltipTriggerMode.tap,
                                                    child: Text(
                                                      'Solar Installation',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMediumIsCustom,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Wrap(
                                                spacing: 10.0,
                                                runSpacing: 0.0,
                                                alignment: WrapAlignment.center,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                direction: Axis.horizontal,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Container(
                                                    constraints: const BoxConstraints(
                                                      minWidth: 300.0,
                                                    ),
                                                    decoration: const BoxDecoration(),
                                                    child: Visibility(
                                                      visible: (_model
                                                                  .solarMeter !=
                                                              null) &&
                                                          (_model.getSolarInstallationOutput !=
                                                              null),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 3.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  16.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .electric_bolt,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'Meter Details',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            12.0),
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .labeledValueModel3,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      LabeledValueWidget(
                                                                    label:
                                                                        'Serial',
                                                                    value: _model
                                                                        .solarMeter
                                                                        ?.serial,
                                                                    buttonAction:
                                                                        () async {},
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .getSolarInstallationOutput !=
                                                                  null)
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .labeledValueModel4,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        LabeledValueWidget(
                                                                      label:
                                                                          'Certificate',
                                                                      value: _model
                                                                          .getSolarInstallationOutput
                                                                          ?.mcs,
                                                                      buttonLabel:
                                                                          'View',
                                                                      buttonAction:
                                                                          () async {
                                                                        var shouldSetState =
                                                                            false;
                                                                        _model.certificateURL =
                                                                            await actions.getStorageURL(
                                                                          functions.bucketNameFromEsco(FFAppState()
                                                                              .esco!
                                                                              .name)!,
                                                                          functions.mcsFileName(
                                                                              _model.getSolarInstallationOutput!.mcs,
                                                                              functions.streetNumberFromPropertyDescription(FFAppState().property.description)!),
                                                                        );
                                                                        shouldSetState =
                                                                            true;
                                                                        if (_model.certificateURL !=
                                                                                null &&
                                                                            _model.certificateURL !=
                                                                                '') {
                                                                          await actions
                                                                              .openPDF(
                                                                            _model.certificateURL!,
                                                                          );
                                                                          if (shouldSetState) {
                                                                            safeSetState(() {});
                                                                          }
                                                                          return;
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'MCS Certificate path failed to build',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                ),
                                                                              ),
                                                                              duration: const Duration(milliseconds: 10000),
                                                                              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                          );
                                                                          if (shouldSetState) {
                                                                            safeSetState(() {});
                                                                          }
                                                                          return;
                                                                        }

                                                                        if (shouldSetState) {
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_model
                                                                      .getSolarInstallationOutput !=
                                                                  null)
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .labeledValueModel5,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        LabeledValueWidget(
                                                                      label:
                                                                          'Net Capacity',
                                                                      value:
                                                                          '${_model.getSolarInstallationOutput?.declaredNetCapacity.toString()} kW',
                                                                      buttonAction:
                                                                          () async {},
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_model
                                                                      .getSolarInstallationOutput !=
                                                                  null)
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .labeledValueModel6,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        LabeledValueWidget(
                                                                      label:
                                                                          'Commissioning Date',
                                                                      value: dateTimeFormat(
                                                                          "dd/MM/yyyy",
                                                                          _model
                                                                              .getSolarInstallationOutput
                                                                              ?.commissioningDate),
                                                                      buttonAction:
                                                                          () async {},
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: const BoxConstraints(
                                                      minWidth: 300.0,
                                                    ),
                                                    decoration: const BoxDecoration(),
                                                    child: Visibility(
                                                      visible: _model
                                                              .solarCreditTariffCurrent !=
                                                          null,
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 3.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  16.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  maxWidth:
                                                                      400.0,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .bar_chart,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'Tariff Information',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    wrapWithModel(
                                                                      model: _model
                                                                          .infoTooltipModel2,
                                                                      updateCallback:
                                                                          () =>
                                                                              safeSetState(() {}),
                                                                      child:
                                                                          InfoTooltipWidget(
                                                                        infoText:
                                                                            'Benchmark Tariff: ${functions.formatGBPAmount(0.51)}${functions.newLineChar()}See ofgem rates at ...',
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .solarCreditTariffCurrent
                                                                      ?.creditPencePerYear !=
                                                                  null)
                                                                wrapWithModel(
                                                                  model: _model
                                                                      .labeledValueWithUnitModel3,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      LabeledValueWithUnitWidget(
                                                                    label:
                                                                        'Solar Credit',
                                                                    value: functions.formatGBPAmount(_model
                                                                            .solarCreditTariffCurrent!
                                                                            .creditPencePerYear /
                                                                        100),
                                                                    unit:
                                                                        ' Per kW installed',
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: const BoxConstraints(
                                                      maxWidth: 400.0,
                                                    ),
                                                    decoration: const BoxDecoration(),
                                                    child: Visibility(
                                                      visible: FFAppState()
                                                              .solarContractSigned &&
                                                          (FFAppState()
                                                                  .solarAccount
                                                                  .customerAccount
                                                                  .role ==
                                                              'owner'),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 3.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  16.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .edit_document,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        'Contract Details',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                                                              letterSpacing: 0.0,
                                                                              useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    wrapWithModel(
                                                                  model: _model
                                                                      .solarContractRowModel,
                                                                  updateCallback: () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                  child:
                                                                      SolarContractRowWidget(
                                                                    isSigned:
                                                                        FFAppState()
                                                                            .solarContractSigned,
                                                                    contract: functions.getContractByType(
                                                                        FFAppState()
                                                                            .accountsForCurrentProperty
                                                                            .toList(),
                                                                        'solar')!,
                                                                    description: functions
                                                                        .getTermsById(
                                                                            functions.getContractByType(FFAppState().accountsForCurrentProperty.toList(), 'solar')!.termsId,
                                                                            FFAppState().contractTerms.toList())!
                                                                        .shortDescription,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
