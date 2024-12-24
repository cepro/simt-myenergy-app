import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payments_page_model.dart';
export 'payments_page_model.dart';

class PaymentsPageWidget extends StatefulWidget {
  const PaymentsPageWidget({super.key});

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
      _model.loadHistoryFailure = false;
      _model.loadingHistory = true;
      _model.loadingMethod = true;
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
          if ((_model.getPaymentMethodsOutput?.succeeded ?? true)) {
            _model.paymentMethods =
                (_model.getPaymentMethodsOutput?.jsonBody ?? '');
            safeSetState(() {});
            // This is a hack to workaround the fact that we don't receive realtime update immediately after redirect from stripe back to the app (after adding a payment method).  Ideally we can fix that but until then this check will look for app state being out of date with the fact we just got payment methods.
            if ((functions.arrayLengthOrNegativeOneIfNotArray(
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

          _model.loadingHistory = false;
          safeSetState(() {});
          if ((_model.getPaymentsOutput?.succeeded ?? true)) {
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
            _model.loadHistoryFailure = true;
            safeSetState(() {});
            return;
          }
        }),
      ]);
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 0.0, 15.0, 100.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 1024.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 25.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 30.0),
                                          child: Text(
                                            'Payments',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMediumFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(FlutterFlowTheme
                                                              .of(context)
                                                          .headlineMediumFamily),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_model.loadingHistory)
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  child: custom_widgets.LoadingSpinner(
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                              if ((FFAppState().customer.status !=
                                      'preonboarding') &&
                                  (FFAppState().customer.status !=
                                      'onboarding') &&
                                  (_model.payments.isNotEmpty))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
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
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
                                                child: Text(
                                                  'Payment History',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            if (false)
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 15.0, 0.0, 0.0),
                                                  child: Text(
                                                    () {
                                                      if (_model
                                                          .loadHistoryFailure) {
                                                        return 'Failure occurred loading history ...';
                                                      } else if (_model
                                                          .loadingHistory) {
                                                        return 'Loading ...';
                                                      } else if (_model.payments
                                                              .length ==
                                                          0) {
                                                        return 'No payments';
                                                      } else {
                                                        return _model
                                                            .payments.length
                                                            .toString();
                                                      }
                                                    }(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((functions.arrayLengthOrNegativeOneIfNotArray(
                                          _model.paymentMethods) >
                                      0) &&
                                  !_model.loadingMethod)
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    constraints: BoxConstraints(
                                      maxWidth: 333.0,
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
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 15.0),
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
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily),
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
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 30.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: (FFAppState()
                                                                .impersonationToken !=
                                                            null &&
                                                        FFAppState()
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
                                                              'PaymentsPage');
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
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
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmallFamily),
                                                          ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
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
                              if ((functions.arrayLengthOrNegativeOneIfNotArray(
                                          _model.paymentMethods) ==
                                      0) &&
                                  !_model.loadingMethod)
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
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
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
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
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 15.0, 0.0, 0.0),
                                            child: Text(
                                              'Customers use Stripe payments to automatically and securely add credit to your energy meter. Stripe supports either a Direct Debit mandate (protected by the Direct Debit Guarantee) or you may make payment with a debit card.\n\nNo payments will be taken until your energy supply contract has been signed. Once under contract customers nominate a day of the month to make payment. You pay each month for the following month\'s use, based on our projected use estimation for that month. If your usage is higher than expected, and the meter hits a user-defined threshold, a further payment is taken to avoid running out of credit. If your usage is lower than expected, the balance rolls over and the next month\'s payment is adjusted down.\n\nYou will be invited to sign contracts for energy supply. You will be notified by email 24 hours before any payments are taken.\n',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
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
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
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
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily),
                                                        ),
                                                    elevation: 3.0,
                                                    borderSide: BorderSide(
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
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20.0, 0.0, 0.0, 0.0),
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .comingSoonForPreonboardingModel,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        ComingSoonForPreonboardingWidget(),
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
                              if (_model.loadingMethod)
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  child: custom_widgets.LoadingSpinner(
                                    width: 100.0,
                                    height: 100.0,
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
