import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'payments_page_model.dart';
import 'components/payment_history_section.dart';
import 'components/topup_history_section.dart';
import 'components/payment_method_section.dart';
import 'components/topup_settings_section.dart';
import 'components/add_payment_method_section.dart';
export 'payments_page_model.dart';

class PaymentsPageWidget extends StatefulWidget {
  const PaymentsPageWidget({super.key});

  static String routeName = 'PaymentsPage';
  static String routePath = '/payments';

  @override
  State<PaymentsPageWidget> createState() => _PaymentsPageWidgetState();
}

class _PaymentsPageWidgetState extends State<PaymentsPageWidget> {
  late PaymentsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      _model.loadPaymentHistoryFailure = false;
      _model.loadingPaymentHistory = true;
      _model.loadingMethod = true;
      _model.loadingTopupHistory = true;
      _model.loadTopupHistoryFailure = false;
      safeSetState(() {});
      _model.userToken = await actions.activeUserToken();
      if (!mounted) return;
      await Future.wait([
        Future(() async {
          _model.getPaymentMethodsOutput =
              await GetCustomersPaymentMethodsCall.call(
            bearerToken: _model.userToken,
            esco: FFAppState().esco?.name,
          );

          _model.loadingMethod = false;
          if ((_model.getPaymentMethodsOutput?.succeeded != false)) {
            _model.paymentMethods =
                (_model.getPaymentMethodsOutput?.jsonBody ?? '');
            // This is a hack to workaround the fact that we don't receive realtime update immediately after redirect from stripe back to the app (after adding a payment method).  Ideally we can fix that but until then this check will look for app state being out of date with the fact we just got payment methods.
            if ((functions.jsonArrayLengthOrNegativeOne(
                        (_model.getPaymentMethodsOutput?.jsonBody ?? '')) >
                    0) &&
                (FFAppState().customer.hasPaymentMethod == false)) {
              FFAppState().updateCustomerStruct(
                (e) => e..hasPaymentMethod = true,
              );
              // Here we just want to update the customer status but use the action block that refetches everything. This is fine. Not advantage to only updated customer status on it's own as we still need to fetch the accounts data from the backend and the update part is super fast.
              // RefreshCustomerStatus
              if (!mounted) return;
              await action_blocks.getCustomerDetailsAndInitAppState(context);
            }
            if (!mounted) return;
            safeSetState(() {});
            return;
          } else {
            if (!mounted) return;
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader: (_model.getPaymentMethodsOutput
                      ?.getHeader('www-authenticate') ??
                  ''),
              httpStatusCode:
                  (_model.getPaymentMethodsOutput?.statusCode ?? 200),
            );
            return;
          }
        }),
        Future(() async {
          _model.getPaymentsOutput = await GetPaymentsCall.call(
            bearerToken: _model.userToken,
          );

          _model.loadingPaymentHistory = false;
          if ((_model.getPaymentsOutput?.succeeded != false)) {
            _model.paymentsTyped = await actions.paymentsJSONToPaymentsDataType(
              (_model.getPaymentsOutput?.jsonBody ?? ''),
            );
            _model.payments =
                _model.paymentsTyped!.toList().cast<PaymentStruct>();
          } else {
            if (!mounted) return;
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader:
                  (_model.getPaymentsOutput?.getHeader('www-authenticate') ??
                      ''),
              httpStatusCode: (_model.getPaymentsOutput?.statusCode ?? 200),
            );
            _model.loadPaymentHistoryFailure = true;
          }
          if (!mounted) return;
          safeSetState(() {});
        }),
        Future(() async {
          _model.getTopupsOutput = await GetTopupsCall.call(
            bearerToken: _model.userToken,
          );

          _model.loadingTopupHistory = false;
          if ((_model.getTopupsOutput?.succeeded != false)) {
            _model.topupsTyped = await actions.topupsJSONToTopupsDataType(
              (_model.getTopupsOutput?.jsonBody ?? ''),
            );
            _model.topups = _model.topupsTyped!.toList().cast<TopupStruct>();
          } else {
            if (!mounted) return;
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader:
                  (_model.getTopupsOutput?.getHeader('www-authenticate') ?? ''),
              httpStatusCode: (_model.getTopupsOutput?.statusCode ?? 200),
            );
            _model.loadTopupHistoryFailure = true;
          }
          if (!mounted) return;
          safeSetState(() {});
        }),
        Future(() async {
          _model.topupPreferencesGetOutput = await GetWalletsCall.call(
            bearerToken: currentJwtToken,
          );

          if ((_model.topupPreferencesGetOutput?.succeeded != false) == true) {
            if (!functions.isListEmpty(
                (_model.topupPreferencesGetOutput?.jsonBody ?? ''))) {
              _model.minimumBalanceTextController?.text =
                  valueOrDefault<String>(
                getJsonField(
                  (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                  r'''$[0].minimumBalance''',
                )?.toString(),
                '30',
              );
              _model.targetBalanceTextController?.text = valueOrDefault<String>(
                getJsonField(
                  (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                  r'''$[0].targetBalance''',
                )?.toString(),
                '50',
              );
              _model.balanceEnumValue = getJsonField(
                (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                r'''$[0].balanceEnum''',
              )?.toString();
              _model.paymentTimingValue = getJsonField(
                (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                r'''$[0].paymentTiming''',
              )?.toString();
              _model.haveWallet = true;

              // Update controllers with actual API response values
              _model.paymentTimingController?.value = _model.paymentTimingValue;
              _model.balanceEnumValueController?.value = _model.balanceEnumValue;

              if (!mounted) return;
              safeSetState(() {});
            } else {
              // Probably redundant as it initializes to false but being explicit to be certain here.
              _model.haveWallet = false;
            }
          } else {
            if (!mounted) return;
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader: (_model.topupPreferencesGetOutput
                      ?.getHeader('www-authenticate') ??
                  ''),
              httpStatusCode:
                  (_model.topupPreferencesGetOutput?.statusCode ?? 200),
            );
          }
        }),
      ]);
    });

    _model.minimumBalanceTextController ??= TextEditingController(text: '30');
    _model.minimumBalanceFocusNode ??= FocusNode();

    _model.targetBalanceTextController ??= TextEditingController(text: '50');
    _model.targetBalanceFocusNode ??= FocusNode();

    // Initialize form field controllers with proper initial values
    _model.paymentTimingController ??= FormFieldController<String>(_model.paymentTimingValue ?? 'monthly');
    _model.balanceEnumValueController ??= FormFieldController<String>(_model.balanceEnumValue ?? 'simple');
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
                  navTwo: FlutterFlowTheme.of(context).secondaryText,
                  navThree: FlutterFlowTheme.of(context).alternate,
                  navFour: FlutterFlowTheme.of(context).secondaryText,
                  navFive: FlutterFlowTheme.of(context).secondaryText,
                  navSix: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 0.0, 15.0, 100.0),
                      child: Container(
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
                                alignment:
                                    const AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            -1.0, 0.0),
                                        child: Text(
                                          'Payments',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMediumFamily,
                                                letterSpacing: 0.0,
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 30.0),
                                      child: wrapWithModel(
                                        model:
                                            _model.propertyNameWithTooltipModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child:
                                            const PropertyNameWithTooltipWidget(),
                                      ),
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
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
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if ((FFAppState().customer.status !=
                                      'preonboarding') &&
                                  (FFAppState().customer.status !=
                                      'onboarding'))
                                PaymentHistorySection(
                                  payments: _model.payments,
                                  loading: _model.loadingPaymentHistory,
                                ),
                              if ((FFAppState().customer.status !=
                                      'preonboarding') &&
                                  (FFAppState().customer.status !=
                                      'onboarding') &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier'))
                                TopupHistorySection(
                                  topups: _model.topups,
                                  loading: _model.loadingTopupHistory,
                                ),
                              // Payment Method and Topup Settings - side by side on desktop/tablet
                              if ((functions.jsonArrayLengthOrNegativeOne(
                                          _model.paymentMethods) >
                                      0) &&
                                  !_model.loadingMethod &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier') &&
                                  (MediaQuery.sizeOf(context).width >= 768))
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Payment Method Box
                                    Expanded(
                                      child: PaymentMethodSection(
                                        paymentMethodsJson: _model.getPaymentMethodsOutput?.jsonBody ?? '',
                                        onPaymentMethodDeleted: () {
                                          context.pushNamed(PaymentsPageWidget.routeName);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    // Topup Settings Box
                                    Expanded(
                                      child: TopupSettingsSection(
                                        minimumBalanceController: _model.minimumBalanceTextController!,
                                        targetBalanceController: _model.targetBalanceTextController!,
                                        minimumBalanceFocusNode: _model.minimumBalanceFocusNode!,
                                        targetBalanceFocusNode: _model.targetBalanceFocusNode!,
                                        balanceEnumValue: _model.balanceEnumValue,
                                        balanceEnumValueController: _model.balanceEnumValueController,
                                        formKey: _model.formKey,
                                        topupPreferencesGetOutput: _model.topupPreferencesGetOutput,
                                        onBalanceEnumChanged: (val) {
                                          _model.balanceEnumValue = val;
                                        },
                                        paymentTimingValue: _model.paymentTimingValue,
                                        paymentTimingController: _model.paymentTimingController,
                                        onPaymentTimingChanged: (val) {
                                          _model.paymentTimingValue = val;
                                          _model.paymentTimingController?.value = val;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              // Payment Method and Topup Settings - stacked vertically on mobile
                              if ((functions.jsonArrayLengthOrNegativeOne(
                                          _model.paymentMethods) >
                                      0) &&
                                  !_model.loadingMethod &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier') &&
                                  (MediaQuery.sizeOf(context).width < 768))
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // Payment Method Box
                                    PaymentMethodSection(
                                      paymentMethodsJson: _model.getPaymentMethodsOutput?.jsonBody ?? '',
                                      onPaymentMethodDeleted: () {
                                        context.pushNamed(PaymentsPageWidget.routeName);
                                      },
                                    ),
                                    const SizedBox(height: 30.0),
                                    // Topup Settings Box
                                    TopupSettingsSection(
                                      minimumBalanceController: _model.minimumBalanceTextController!,
                                      targetBalanceController: _model.targetBalanceTextController!,
                                      minimumBalanceFocusNode: _model.minimumBalanceFocusNode!,
                                      targetBalanceFocusNode: _model.targetBalanceFocusNode!,
                                      balanceEnumValue: _model.balanceEnumValue,
                                      balanceEnumValueController: _model.balanceEnumValueController,
                                      formKey: _model.formKey,
                                      topupPreferencesGetOutput: _model.topupPreferencesGetOutput,
                                      onBalanceEnumChanged: (val) {
                                        _model.balanceEnumValue = val;
                                      },
                                      paymentTimingValue: _model.paymentTimingValue,
                                      paymentTimingController: _model.paymentTimingController,
                                      onPaymentTimingChanged: (val) {
                                        _model.paymentTimingValue = val;
                                        _model.paymentTimingController?.value = val;
                                      },
                                    ),
                                  ],
                                ),
                              if (_model.loadingMethod &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier'))
                                const SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: custom_widgets.LoadingSpinner(
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                                                            if ((functions.jsonArrayLengthOrNegativeOne(
                                          _model.paymentMethods) ==
                                      0) &&
                                  !_model.loadingMethod &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier'))
                                const AddPaymentMethodSection(),
                              if (FFAppState()
                                      .supplyAccount
                                      .customerAccount
                                      .role ==
                                  'owner')
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.comingSoonForLandlordsModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child:
                                        const ComingSoonForPreonboardingWidget(),
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
