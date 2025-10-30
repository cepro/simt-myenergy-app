import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/components/property_name_with_tooltip_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/topup_list/topup_list_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'payments_page_model.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loadPaymentHistoryFailure = false;
      _model.loadingPaymentHistory = true;
      _model.loadingMethod = true;
      _model.loadingTopupHistory = true;
      _model.loadTopupHistoryFailure = false;
      safeSetState(() {});
      _model.userToken = await actions.activeUserToken();
      await Future.wait([
        Future(() async {
          _model.getPaymentMethodsOutput =
              await GetCustomersPaymentMethodsCall.call(
            bearerToken: _model.userToken,
            esco: FFAppState().esco?.name,
          );

          _model.loadingMethod = false;
          safeSetState(() {});
          if ((_model.getPaymentMethodsOutput?.succeeded != false)) {
            _model.paymentMethods =
                (_model.getPaymentMethodsOutput?.jsonBody ?? '');
            safeSetState(() {});
            // This is a hack to workaround the fact that we don't receive realtime update immediately after redirect from stripe back to the app (after adding a payment method).  Ideally we can fix that but until then this check will look for app state being out of date with the fact we just got payment methods.
            if ((functions.jsonArrayLengthOrNegativeOne(
                        (_model.getPaymentMethodsOutput?.jsonBody ?? '')) >
                    0) &&
                (FFAppState().customer.hasPaymentMethod == false)) {
              FFAppState().updateCustomerStruct(
                (e) => e..hasPaymentMethod = true,
              );
              safeSetState(() {});
              // Here we just want to update the customer status but use the action block that refetches everything. This is fine. Not advantage to only updated customer status on it's own as we still need to fetch the accounts data from the backend and the update part is super fast.
              // RefreshCustomerStatus
              await action_blocks.getCustomerDetailsAndInitAppState(context);
            } else {
              return;
            }

            return;
          } else {
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
          safeSetState(() {});
          if ((_model.getPaymentsOutput?.succeeded != false)) {
            _model.paymentsTyped = await actions.paymentsJSONToPaymentsDataType(
              (_model.getPaymentsOutput?.jsonBody ?? ''),
            );
            _model.payments =
                _model.paymentsTyped!.toList().cast<PaymentStruct>();
            safeSetState(() {});
            return;
          } else {
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader:
                  (_model.getPaymentsOutput?.getHeader('www-authenticate') ??
                      ''),
              httpStatusCode: (_model.getPaymentsOutput?.statusCode ?? 200),
            );
            _model.loadPaymentHistoryFailure = true;
            safeSetState(() {});
            return;
          }
        }),
        Future(() async {
          _model.getTopupsOutput = await GetTopupsCall.call(
            bearerToken: _model.userToken,
          );

          _model.loadingTopupHistory = false;
          safeSetState(() {});
          if ((_model.getTopupsOutput?.succeeded != false)) {
            _model.topupsTyped = await actions.topupsJSONToTopupsDataType(
              (_model.getTopupsOutput?.jsonBody ?? ''),
            );
            _model.topups = _model.topupsTyped!.toList().cast<TopupStruct>();
            safeSetState(() {});
            return;
          } else {
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader:
                  (_model.getTopupsOutput?.getHeader('www-authenticate') ?? ''),
              httpStatusCode: (_model.getTopupsOutput?.statusCode ?? 200),
            );
            _model.loadTopupHistoryFailure = true;
            safeSetState(() {});
            return;
          }
        }),
        Future(() async {
          _model.topupPreferencesGetOutput = await GetWalletsCall.call(
            bearerToken: currentJwtToken,
          );

          if ((_model.topupPreferencesGetOutput?.succeeded != false) == true) {
            if (!functions.isListEmpty(
                (_model.topupPreferencesGetOutput?.jsonBody ?? ''))) {
              safeSetState(() {
                _model.minimumBalanceTextController?.text =
                    valueOrDefault<String>(
                  getJsonField(
                    (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                    r'''$[0].minimumBalance''',
                  )?.toString(),
                  '30',
                );
              });
              safeSetState(() {
                _model.targetBalanceTextController?.text = valueOrDefault<String>(
                  getJsonField(
                    (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                    r'''$[0].targetBalance''',
                  )?.toString(),
                  '50',
                );
              });
              safeSetState(() {
                _model.balanceEnumValue = getJsonField(
                  (_model.topupPreferencesGetOutput?.jsonBody ?? ''),
                  r'''$[0].balanceEnum''',
                )?.toString();
              });
              _model.haveWallet = true;
            } else {
              // Probably redundant as it initializes to false but being explicit to be certain here.
              _model.haveWallet = false;
            }
          } else {
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
                                      'onboarding') &&
                                  _model.loadingPaymentHistory)
                                const SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: custom_widgets.LoadingSpinner(
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                              if (!_model.loadingPaymentHistory)
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 30.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
                                                child: Text(
                                                  'Payment History',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            if (_model.payments.isNotEmpty)
                                              wrapWithModel(
                                                model: _model.paymentsListModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: PaymentsListWidget(
                                                  payments: _model.payments,
                                                ),
                                              ),
                                            if (_model.payments.isEmpty)
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                child: Text(
                                                  'No payments',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((FFAppState().customer.status !=
                                      'preonboarding') &&
                                  (FFAppState().customer.status !=
                                      'onboarding') &&
                                  _model.loadingTopupHistory)
                                const SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: custom_widgets.LoadingSpinner(
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                              if (!_model.loadingTopupHistory &&
                                  (FFAppState()
                                          .supplyAccount
                                          .customerAccount
                                          .role ==
                                      'occupier'))
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 30.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
                                                child: Text(
                                                  'Meter Topup History',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                            ),
                                            if (_model.topups.isNotEmpty)
                                              wrapWithModel(
                                                model: _model.topupListModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TopupListWidget(
                                                  topups: _model.topups,
                                                ),
                                              ),
                                            if (_model.topups.isEmpty)
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                child: Text(
                                                  'No topups',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 470.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 0.0, 15.0),
                                                child: Text(
                                                  'Payment method',
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme
                                                                        .of(context)
                                                                    .headlineMediumIsCustom,
                                                          ),
                                                ),
                                              ),
                                              if (getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].directDebit''',
                                                  ) !=
                                                  null)
                                                wrapWithModel(
                                                  model: _model.directDebitModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: DirectDebitWidget(
                                                    last4Digits: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].directDebit.last4''',
                                                    ).toString(),
                                                    sortCode: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].directDebit.sortCode''',
                                                    ).toString(),
                                                  ),
                                                ),
                                              if (getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].card''',
                                                  ) !=
                                                  null)
                                                wrapWithModel(
                                                  model: _model.creditCardModel,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: CreditCardWidget(
                                                    last4Digits: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].card.last4''',
                                                    ).toString(),
                                                    expiryYear: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].card.expiryYear''',
                                                    ),
                                                    expiryMonth: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].card.expiryMonth''',
                                                    ),
                                                    cardBrand: getJsonField(
                                                      (_model.getPaymentMethodsOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                      r'''$[0].card.brand''',
                                                    ).toString(),
                                                  ),
                                                ),
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 30.0, 0.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: (FFAppState()
                                                                .impersonationToken !=
                                                            '')
                                                        ? null
                                                        : () async {
                                                            await action_blocks
                                                                .checkAndBlockWriteableAPICall(
                                                                    context);
                                                            _model.deletePaymentMethodResult =
                                                                await DeleteCustomersPaymentMethodCall
                                                                    .call(
                                                              bearerToken:
                                                                  currentJwtToken,
                                                              id: getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].id''',
                                                              ).toString(),
                                                              esco: FFAppState()
                                                                  .esco
                                                                  ?.name,
                                                            );

                                                            if ((_model.deletePaymentMethodResult
                                                                        ?.statusCode ??
                                                                    200) ==
                                                                200) {
                                                              context.pushNamed(
                                                                  PaymentsPageWidget
                                                                      .routeName);
                                                            } else {
                                                              await action_blocks
                                                                  .handleMyEnergyApiCallFailure(
                                                                context,
                                                                wwwAuthenticateHeader: (_model
                                                                        .deletePaymentMethodResult
                                                                        ?.getHeader(
                                                                            'www-authenticate') ??
                                                                    ''),
                                                                httpStatusCode: (_model
                                                                        .checkoutPageURI
                                                                        ?.statusCode ??
                                                                    200),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                    text: 'Remove Payment Method',
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              24.0, 0.0, 24.0, 0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0, 0.0, 0.0, 0.0),
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
                                                                letterSpacing: 0.0,
                                                                useGoogleFonts:
                                                                    !FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmallIsCustom,
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: const BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1.0,
                                                      ),
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
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    // Topup Settings Box
                                    Expanded(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 470.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context).primary,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0.0, 0.0, 0.0, 15.0),
                                                  child: Text(
                                                    'Topup Settings',
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
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0, 8.0, 15.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Target Balance (£)',
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .labelMediumFamily,
                                                                          letterSpacing: 0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context)
                                                                                  .labelMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                  AlignedTooltip(
                                                                    content: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Text(
                                                                        'This is the target balance you want to maintain in your meter.',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily:
                                                                                  FlutterFlowTheme.of(context)
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
                                                                    preferredDirection: AxisDirection.down,
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    elevation: 4.0,
                                                                    tailBaseWidth: 24.0,
                                                                    tailLength: 12.0,
                                                                    waitDuration: const Duration(milliseconds: 100),
                                                                    showDuration: const Duration(milliseconds: 1500),
                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                    child: Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                      child: Icon(
                                                                        Icons.info_outline,
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                        size: 24.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  _model.targetBalanceTextController,
                                                              focusNode:
                                                                  _model.targetBalanceFocusNode,
                                                              autofocus: true,
                                                              obscureText: false,
                                                              onChanged: (_) => {
                                                                safeSetState(() {
                                                                  final targetValue = int.tryParse(_model.targetBalanceTextController.text);
                                                                  if (targetValue != null && targetValue > 10) {
                                                                    _model.minimumBalanceTextController?.text = (targetValue - 10).toString();
                                                                  }
                                                                })
                                                              },
                                                              decoration: InputDecoration(
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                                hintStyle:
                                                                    FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .labelMediumFamily,
                                                                          letterSpacing: 0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .labelMediumIsCustom,
                                                                        ),
                                                                enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                errorBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                    context)
                                                                                .bodyMediumIsCustom,
                                                                  ),
                                                              validator: (val) {
                                                                if (val == null || val.isEmpty) {
                                                                  return 'Target Balance is required';
                                                                }
                                                                final intValue = int.tryParse(val);
                                                                if (intValue == null) {
                                                                  return 'Please enter a valid number';
                                                                }
                                                                if (intValue < 30) {
                                                                  return 'Target Balance must be at least £30';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0, 8.0, 15.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(0.0, 0.0, 0.0, 1.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Minimum Balance (£)',
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .labelMediumFamily,
                                                                          letterSpacing: 0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context)
                                                                                  .labelMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                  AlignedTooltip(
                                                                    content: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Text(
                                                                        'This is the minimum balance before automatic top-up occurs.',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily:
                                                                                  FlutterFlowTheme.of(context)
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
                                                                    preferredDirection: AxisDirection.down,
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    elevation: 4.0,
                                                                    tailBaseWidth: 24.0,
                                                                    tailLength: 12.0,
                                                                    waitDuration: const Duration(milliseconds: 100),
                                                                    showDuration: const Duration(milliseconds: 1500),
                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                    child: Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                      child: Icon(
                                                                        Icons.info_outline,
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                        size: 24.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            TextFormField(
                                                              controller: _model
                                                                  .minimumBalanceTextController,
                                                              focusNode:
                                                                  _model.minimumBalanceFocusNode,
                                                              autofocus: false,
                                                              readOnly: true,
                                                              obscureText: false,
                                                              decoration: InputDecoration(
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                                hintStyle:
                                                                    FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .labelMediumFamily,
                                                                          letterSpacing: 0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .labelMediumIsCustom,
                                                                        ),
                                                                filled: true,
                                                                fillColor:
                                                                    FlutterFlowTheme.of(context).secondaryBackground,
                                                                enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                errorBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        FlutterFlowTheme.of(context)
                                                                            .error,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(8.0),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily,
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                    context)
                                                                                .bodyMediumIsCustom,
                                                                  ),
                                                              validator: _model
                                                                  .minimumBalanceTextControllerValidator
                                                                  .asValidator(context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0, 8.0, 15.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    'Payment Mode',
                                                                    style: FlutterFlowTheme.of(context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .labelMediumFamily,
                                                                          letterSpacing: 0.0,
                                                                          useGoogleFonts:
                                                                              !FlutterFlowTheme.of(context)
                                                                                  .labelMediumIsCustom,
                                                                        ),
                                                                  ),
                                                                  AlignedTooltip(
                                                                    content: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Text(
                                                                        'Choose between simple or smoothed prepayments.',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily:
                                                                                  FlutterFlowTheme.of(context)
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
                                                                    preferredDirection: AxisDirection.down,
                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                    elevation: 4.0,
                                                                    tailBaseWidth: 24.0,
                                                                    tailLength: 12.0,
                                                                    waitDuration: const Duration(milliseconds: 100),
                                                                    showDuration: const Duration(milliseconds: 1500),
                                                                    triggerMode: TooltipTriggerMode.tap,
                                                                    child: Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                      child: Icon(
                                                                        Icons.info_outline,
                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                        size: 24.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            FlutterFlowDropDown<String>(
                                                              controller: _model.balanceEnumValueController ??=
                                                                  FormFieldController<String>(
                                                                _model.balanceEnumValue ??= 'simple',
                                                              ),
                                                              options: const ['simple', 'smooth'],
                                                              optionLabels: const [
                                                                'Simple Prepayments',
                                                                'Smoothed Prepayments'
                                                              ],
                                                              onChanged: (val) =>
                                                                  safeSetState(() => _model.balanceEnumValue = val),
                                                              width: double.infinity,
                                                              height: 56.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      letterSpacing: 0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(context)
                                                                              .bodyMediumIsCustom,
                                                                    ),
                                                            hintText: 'Payment Mode',
                                                            icon: Icon(
                                                              Icons.keyboard_arrow_down_rounded,
                                                              color: FlutterFlowTheme.of(context)
                                                                  .secondaryText,
                                                            size: 24.0,
                                                            ),
                                                            fillColor:
                                                                FlutterFlowTheme.of(context)
                                                                    .secondaryBackground,
                                                            elevation: 2.0,
                                                            borderColor:
                                                                FlutterFlowTheme.of(context).alternate,
                                                            borderWidth: 2.0,
                                                            borderRadius: 8.0,
                                                            margin: const EdgeInsetsDirectional.fromSTEB(
                                                              16.0, 4.0, 16.0, 4.0),
                                                            hidesUnderline: true,
                                                            isOverButton: true,
                                                            isSearchable: false,
                                                            isMultiSelect: false,
                                                          ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            if (!_formKey.currentState!.validate()) {
                                                              return;
                                                            }
                                                            await action_blocks
                                                                .checkAndBlockWriteableAPICall(
                                                                    context);
                                                            _model.updateTopupPreferenceOutput =
                                                                await UpdateTopupPreferencesCall
                                                                    .call(
                                                              bearerToken: currentJwtToken,
                                                              minimumBalance: int.tryParse(_model
                                                                  .minimumBalanceTextController
                                                                  .text),
                                                              targetBalance: int.tryParse(_model
                                                                  .targetBalanceTextController
                                                                  .text),
                                                              walletId: getJsonField(
                                                                (_model.topupPreferencesGetOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].id''',
                                                              ).toString(),
                                                              balanceEnum: _model.balanceEnumValue,
                                                            );

                                                            if ((_model.updateTopupPreferenceOutput
                                                                        ?.succeeded ??
                                                                    true) ==
                                                                true) {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Topup preferences updated successfully',
                                                                    style: TextStyle(
                                                                      color:
                                                                          FlutterFlowTheme.of(
                                                                                  context)
                                                                              .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: const Duration(
                                                                      milliseconds: 4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            } else {
                                                              await action_blocks
                                                                  .handleMyEnergyApiCallFailure(
                                                                context,
                                                                wwwAuthenticateHeader: (_model
                                                                        .updateTopupPreferenceOutput
                                                                        ?.getHeader(
                                                                            'www-authenticate') ??
                                                                    ''),
                                                                httpStatusCode: (_model
                                                                        .updateTopupPreferenceOutput
                                                                        ?.statusCode ??
                                                                    200),
                                                              );
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text: 'Save',
                                                          options: FFButtonOptions(
                                                            height: 40.0,
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0, 0.0, 0.0, 0.0),
                                                            color: FlutterFlowTheme.of(context)
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
                                                                      letterSpacing: 0.0,
                                                                      useGoogleFonts:
                                                                          !FlutterFlowTheme.of(
                                                                                  context)
                                                                              .titleSmallIsCustom,
                                                                    ),
                                                            elevation: 3.0,
                                                            borderSide: const BorderSide(
                                                              color: Colors.transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
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
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 15.0),
                                              child: Text(
                                                'Payment method',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMediumIsCustom,
                                                        ),
                                              ),
                                            ),
                                            if (getJsonField(
                                                  (_model.getPaymentMethodsOutput
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$[0].directDebit''',
                                                ) !=
                                                null)
                                              wrapWithModel(
                                                model: _model.directDebitModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: DirectDebitWidget(
                                                  last4Digits: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].directDebit.last4''',
                                                  ).toString(),
                                                  sortCode: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].directDebit.sortCode''',
                                                  ).toString(),
                                                ),
                                              ),
                                            if (getJsonField(
                                                  (_model.getPaymentMethodsOutput
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$[0].card''',
                                                ) !=
                                                null)
                                              wrapWithModel(
                                                model: _model.creditCardModel,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: CreditCardWidget(
                                                  last4Digits: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].card.last4''',
                                                  ).toString(),
                                                  expiryYear: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].card.expiryYear''',
                                                  ),
                                                  expiryMonth: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].card.expiryMonth''',
                                                  ),
                                                  cardBrand: getJsonField(
                                                    (_model.getPaymentMethodsOutput
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$[0].card.brand''',
                                                  ).toString(),
                                                ),
                                              ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 30.0, 0.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: (FFAppState()
                                                              .impersonationToken !=
                                                          '')
                                                      ? null
                                                      : () async {
                                                          await action_blocks
                                                              .checkAndBlockWriteableAPICall(
                                                                  context);
                                                          _model.deletePaymentMethodResult =
                                                              await DeleteCustomersPaymentMethodCall
                                                                  .call(
                                                            bearerToken:
                                                                currentJwtToken,
                                                            id: getJsonField(
                                                              (_model.getPaymentMethodsOutput
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$[0].id''',
                                                            ).toString(),
                                                            esco: FFAppState()
                                                                .esco
                                                                ?.name,
                                                          );

                                                          if ((_model.deletePaymentMethodResult
                                                                      ?.statusCode ??
                                                                  200) ==
                                                              200) {
                                                            context.pushNamed(
                                                                PaymentsPageWidget
                                                                    .routeName);
                                                          } else {
                                                            await action_blocks
                                                                .handleMyEnergyApiCallFailure(
                                                              context,
                                                              wwwAuthenticateHeader: (_model
                                                                      .deletePaymentMethodResult
                                                                      ?.getHeader(
                                                                          'www-authenticate') ??
                                                                  ''),
                                                              httpStatusCode: (_model
                                                                      .checkoutPageURI
                                                                      ?.statusCode ??
                                                                  200),
                                                            );
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                  text: 'Remove Payment Method',
                                                  options: FFButtonOptions(
                                                    height: 40.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            24.0, 0.0, 24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
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
                                                              letterSpacing: 0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallIsCustom,
                                                            ),
                                                    elevation: 3.0,
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
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
                                    ),
                                    const SizedBox(height: 30.0),
                                    // Topup Settings Box
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).primary,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 15.0),
                                              child: Text(
                                                'Topup Settings',
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
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(8.0, 0.0, 8.0, 10.0),
                                                      child: TextFormField(
                                                        controller:
                                                            _model.targetBalanceTextController,
                                                        focusNode:
                                                            _model.targetBalanceFocusNode,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        onChanged: (_) {
                                                          safeSetState(() {
                                                            final targetValue = int.tryParse(_model.targetBalanceTextController.text);
                                                            if (targetValue != null && targetValue > 10) {
                                                              _model.minimumBalanceTextController?.text = (targetValue - 10).toString();
                                                            }
                                                          });
                                                        },
                                                        decoration: InputDecoration(
                                                          labelText: 'Target Balance (£)',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                          hintStyle:
                                                              FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          errorBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(context)
                                                                      .bodyMediumFamily,
                                                              letterSpacing: 0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                        validator: _model
                                                            .targetBalanceTextControllerValidator
                                                            .asValidator(context),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(8.0, 0.0, 8.0, 10.0),
                                                      child: TextFormField(
                                                        controller: _model
                                                            .minimumBalanceTextController,
                                                        focusNode:
                                                            _model.minimumBalanceFocusNode,
                                                        autofocus: false,
                                                        readOnly: true,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelText:
                                                              'Minimum Balance (£)',
                                                          labelStyle:
                                                              FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                          hintStyle:
                                                              FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                          filled: true,
                                                          fillColor:
                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          errorBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  FlutterFlowTheme.of(context)
                                                                      .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(8.0),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(context)
                                                                      .bodyMediumFamily,
                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                              letterSpacing: 0.0,
                                                              useGoogleFonts:
                                                                  !FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumIsCustom,
                                                            ),
                                                        validator: _model
                                                            .minimumBalanceTextControllerValidator
                                                            .asValidator(context),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(8.0, 0.0, 8.0, 10.0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                            child: Text(
                                                              'Payment Mode',
                                                              style: FlutterFlowTheme.of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .labelMediumFamily,
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(context)
                                                                            .labelMediumIsCustom,
                                                                  ),
                                                            ),
                                                          ),
                                                          FlutterFlowDropDown<String>(
                                                            controller: _model.balanceEnumValueController ??=
                                                                FormFieldController<String>(
                                                              _model.balanceEnumValue ??= 'simple',
                                                            ),
                                                            options: const ['simple', 'smooth'],
                                                            optionLabels: const [
                                                              'Simple Prepayments',
                                                              'Smoothed Prepayments'
                                                            ],
                                                            onChanged: (val) =>
                                                                safeSetState(() => _model.balanceEnumValue = val),
                                                            width: double.infinity,
                                                            height: 56.0,
                                                        textStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      FlutterFlowTheme.of(context)
                                                                          .bodyMediumFamily,
                                                                  letterSpacing: 0.0,
                                                                  useGoogleFonts:
                                                                      !FlutterFlowTheme.of(context)
                                                                          .bodyMediumIsCustom,
                                                                ),
                                                        hintText: 'Payment Mode',
                                                        icon: Icon(
                                                          Icons.keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme.of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                        fillColor:
                                                            FlutterFlowTheme.of(context)
                                                                .secondaryBackground,
                                                        elevation: 2.0,
                                                        borderColor:
                                                            FlutterFlowTheme.of(context).alternate,
                                                        borderWidth: 2.0,
                                                        borderRadius: 8.0,
                                                        margin: const EdgeInsetsDirectional.fromSTEB(
                                                            16.0, 4.0, 16.0, 4.0),
                                                        hidesUnderline: true,
                                                        isOverButton: true,
                                                        isSearchable: false,
                                                        isMultiSelect: false,
                                                      ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          await action_blocks
                                                              .checkAndBlockWriteableAPICall(
                                                                  context);
                                                          _model.updateTopupPreferenceOutput =
                                                              await UpdateTopupPreferencesCall
                                                                  .call(
                                                            bearerToken: currentJwtToken,
                                                            minimumBalance: int.tryParse(_model
                                                                .targetBalanceTextController
                                                                .text),
                                                            targetBalance: int.tryParse(_model
                                                                .minimumBalanceTextController
                                                                .text),
                                                            walletId: getJsonField(
                                                              (_model.topupPreferencesGetOutput
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$[0].id''',
                                                            ).toString(),
                                                            balanceEnum: _model.balanceEnumValue,
                                                          );

                                                          if ((_model.updateTopupPreferenceOutput
                                                                      ?.succeeded ??
                                                                  true) ==
                                                              true) {
                                                            ScaffoldMessenger.of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Topup preferences updated successfully',
                                                                  style: TextStyle(
                                                                    color:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .primaryText,
                                                                  ),
                                                                ),
                                                                duration: const Duration(
                                                                    milliseconds: 4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          } else {
                                                            await action_blocks
                                                                .handleMyEnergyApiCallFailure(
                                                              context,
                                                              wwwAuthenticateHeader: (_model
                                                                      .updateTopupPreferenceOutput
                                                                      ?.getHeader(
                                                                          'www-authenticate') ??
                                                                  ''),
                                                              httpStatusCode: (_model
                                                                      .updateTopupPreferenceOutput
                                                                      ?.statusCode ??
                                                                  200),
                                                            );
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                        text: 'Save',
                                                        options: FFButtonOptions(
                                                          height: 40.0,
                                                          padding: const EdgeInsetsDirectional
                                                              .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0, 0.0, 0.0, 0.0),
                                                          color: FlutterFlowTheme.of(context)
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
                                                                    letterSpacing: 0.0,
                                                                    useGoogleFonts:
                                                                        !FlutterFlowTheme.of(
                                                                                context)
                                                                            .titleSmallIsCustom,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide: const BorderSide(
                                                            color: Colors.transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(8.0),
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
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    -1.0, 0.0),
                                            child: Text(
                                              'Add a new payment method',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMediumIsCustom,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 15.0, 0.0, 0.0),
                                            child: Text(
                                              'Customers use Stripe payments to automatically and securely add credit to your energy meter. Stripe supports either a Direct Debit mandate (protected by the Direct Debit Guarantee) or you may make payment with a debit card.\n\nNo payments will be taken until your energy supply contract has been signed. Once under contract customers nominate a day of the month to make payment. You pay each month for the following month\'s use, based on our projected use estimation for that month. If your usage is higher than expected, and the meter hits a user-defined threshold, a further payment is taken to avoid running out of credit. If your usage is lower than expected, the balance rolls over and the next month\'s payment is adjusted down.\n\nYou will be invited to sign contracts for energy supply. You will be notified by email 24 hours before any payments are taken.\n',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: (FFAppState()
                                                              .customer
                                                              .status ==
                                                          'preonboarding')
                                                      ? null
                                                      : () async {
                                                          await action_blocks
                                                              .checkAndBlockWriteableAPICall(
                                                                  context);
                                                          _model.checkoutPageURI =
                                                              await CreateStripeCheckoutSessionCall
                                                                  .call(
                                                            bearerToken:
                                                                currentJwtToken,
                                                            esco: FFAppState()
                                                                .esco
                                                                ?.name,
                                                          );

                                                          if (_model
                                                                  .checkoutPageURI !=
                                                              null) {
                                                            await actions
                                                                .navigateToExternalURI(
                                                              CreateStripeCheckoutSessionCall
                                                                  .checkoutPageURI(
                                                                (_model.checkoutPageURI
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ).toString(),
                                                            );
                                                          } else {
                                                            await action_blocks
                                                                .handleMyEnergyApiCallFailure(
                                                              context,
                                                              wwwAuthenticateHeader: (_model
                                                                      .checkoutPageURI
                                                                      ?.getHeader(
                                                                          'www-authenticate') ??
                                                                  ''),
                                                              httpStatusCode: (_model
                                                                      .checkoutPageURI
                                                                      ?.statusCode ??
                                                                  200),
                                                            );
                                                          }

                                                          safeSetState(() {});
                                                        },
                                                  text:
                                                      'Setup Payment with Stripe',
                                                  options: FFButtonOptions(
                                                    height: 40.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                            24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
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
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts:
                                                              !FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleSmallIsCustom,
                                                        ),
                                                    elevation: 3.0,
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    disabledColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .lineColor,
                                                    disabledTextColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        -1.0, 0.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          20.0, 0.0, 0.0, 0.0),
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .comingSoonForPreonboardingModel,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        const ComingSoonForPreonboardingWidget(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
