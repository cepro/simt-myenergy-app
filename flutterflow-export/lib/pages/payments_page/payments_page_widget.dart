import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
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
      await action_blocks.ceproUserOnly(context);
      _model.userToken = await actions.activeUserToken();
      await Future.wait([
        Future(() async {
          _model.getPaymentMethodsOutput =
              await GetCustomersPaymentMethodsCall.call(
            bearerToken: _model.userToken,
            esco: FFAppState().esco?.name,
          );

          if ((_model.getPaymentMethodsOutput?.succeeded ?? true)) {
            _model.paymentMethods =
                (_model.getPaymentMethodsOutput?.jsonBody ?? '');
            safeSetState(() {});
          } else {
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader: (_model.getPaymentMethodsOutput
                      ?.getHeader('www-authenticate') ??
                  ''),
              httpStatusCode:
                  (_model.getPaymentMethodsOutput?.statusCode ?? 200),
            );
          }
        }),
        Future(() async {
          _model.getPaymentsOutput = await GetCustomersPaymentsCall.call(
            esco: FFAppState().esco?.name,
            bearerToken: _model.userToken,
          );

          if ((_model.getPaymentsOutput?.succeeded ?? true)) {
            _model.paymentsTyped = await actions.paymentsJSONToPaymentsDataType(
              (_model.getPaymentsOutput?.jsonBody ?? ''),
            );
            _model.payments =
                _model.paymentsTyped!.toList().cast<PaymentStruct>();
            safeSetState(() {});
          } else {
            await action_blocks.handleMyEnergyApiCallFailure(
              context,
              wwwAuthenticateHeader:
                  (_model.getPaymentsOutput?.getHeader('www-authenticate') ??
                      ''),
              httpStatusCode: (_model.getPaymentsOutput?.statusCode ?? 200),
            );
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
      onTap: () => FocusScope.of(context).unfocus(),
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
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Payments',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(FlutterFlowTheme
                                                          .of(context)
                                                      .headlineMediumFamily),
                                            ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Visibility(
                                            visible: FFAppState().isCeproUser,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 20.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Payment History',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .headlineSmallFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                if (!FFAppState().isCeproUser)
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  15.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        () {
                                                          if (!FFAppState()
                                                              .isCeproUser) {
                                                            return 'Coming Soon ...';
                                                          } else if (!(_model
                                                              .payments
                                                              .isNotEmpty)) {
                                                            return 'Loading ...';
                                                          } else if (_model
                                                                  .payments
                                                                  .length ==
                                                              0) {
                                                            return 'No payments';
                                                          } else {
                                                            return _model
                                                                .payments.length
                                                                .toString();
                                                          }
                                                        }(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                if (_model.payments.isNotEmpty)
                                                  wrapWithModel(
                                                    model: _model
                                                        .paymentsListModel,
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
                                    ],
                                  ),
                                ),
                              ),
                              if (FFAppState().isCeproUser &&
                                  (functions.arrayLengthOrNegativeOneIfNotArray(
                                          _model.paymentMethods) >
                                      0))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 333.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 3.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 30.0),
                                            child: Text(
                                              'Payment method',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
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
                                                  height: 30.0,
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
                              if (FFAppState().isCeproUser &&
                                  (functions.arrayLengthOrNegativeOneIfNotArray(
                                          _model.paymentMethods) ==
                                      0))
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            'Add a new payment method',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmallFamily),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 15.0, 0.0, 0.0),
                                          child: Text(
                                            'Customers use Stripe payments to automatically and securely add credit to your energy meter. Stripe supports either a Direct Debit mandate (protected by the Direct Debit Guarantee) or you may make payment with a debit card.\n\nNo payments will be taken until you contract for energy supply. Once under contract customers nominate a day of the month to make payment. You pay each month for the following month\'s use, based on our projected use estimation for that month. If your usage is higher than expected, and the meter hits a user-defined threshold, a further payment is taken to avoid running out of credit. If your usage is lower than expected, the balance rolls over and the next month\'s payment is adjusted down.\n\nYou will be invited to sign contracts for energy supply in April. You will be notified by email 24 hours before any payments are taken.\n',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
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
                                              text: 'Setup Payment with Stripe',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
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
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!FFAppState().isCeproUser)
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            'Add a new payment method',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmallFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmallFamily),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 15.0, 0.0, 0.0),
                                          child: Text(
                                            'Coming soon ...\n',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
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
          ],
        ),
      ),
    );
  }
}
