import '/backend/api_requests/api_calls.dart';
import '/components/credit_card_widget.dart';
import '/components/direct_debit_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/mobile_nav_widget.dart';
import '/components/top_bar_logged_in_widget.dart';
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
import 'payment_page_model.dart';
export 'payment_page_model.dart';

class PaymentPageWidget extends StatefulWidget {
  const PaymentPageWidget({super.key});

  @override
  State<PaymentPageWidget> createState() => _PaymentPageWidgetState();
}

class _PaymentPageWidgetState extends State<PaymentPageWidget> {
  late PaymentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.jwtToken = await actions.getJwtToken();
      _model.getPaymentMethodsOutput =
          await GetCustomersPaymentMethodsCall.call(
        bearerToken: _model.jwtToken,
      );
      if ((_model.getPaymentMethodsOutput?.succeeded ?? true)) {
        setState(() {
          _model.paymentMethods =
              (_model.getPaymentMethodsOutput?.jsonBody ?? '');
        });
      } else {
        await action_blocks.handleMyEnergyApiCallFailure(
          context,
          wwwAuthenticateHeader:
              (_model.getPaymentMethodsOutput?.getHeader('www-authenticate') ??
                  ''),
          httpStatusCode: (_model.getPaymentMethodsOutput?.statusCode ?? 200),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.mainWebNavModel,
                updateCallback: () => setState(() {}),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  wrapWithModel(
                                    model: _model.topBarLoggedInModel,
                                    updateCallback: () => setState(() {}),
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
                                      color: FlutterFlowTheme.of(context)
                                          .lineColor,
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Divider(
                                      height: 24.0,
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .lineColor,
                                    ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (functions
                                              .arrayLengthOrNegativeOneIfNotArray(
                                                  _model.paymentMethods) >
                                          0)
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 230.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 210.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 375.0,
                                                      maxHeight: 210.0,
                                                    ),
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (getJsonField(
                                                              (_model.getPaymentMethodsOutput
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$[0].card''',
                                                            ) !=
                                                            null)
                                                          wrapWithModel(
                                                            model: _model
                                                                .creditCardModel,
                                                            updateCallback:
                                                                () => setState(
                                                                    () {}),
                                                            child:
                                                                CreditCardWidget(
                                                              last4Digits:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].card.last4''',
                                                              ).toString(),
                                                              expiryYear:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].card.expiryYear''',
                                                              ),
                                                              expiryMonth:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].card.expiryMonth''',
                                                              ),
                                                              cardBrand:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].card.brand''',
                                                              ).toString(),
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
                                                            model: _model
                                                                .directDebitModel,
                                                            updateCallback:
                                                                () => setState(
                                                                    () {}),
                                                            child:
                                                                DirectDebitWidget(
                                                              last4Digits:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].directDebit.last4''',
                                                              ).toString(),
                                                              sortCode:
                                                                  getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].directDebit.sortCode''',
                                                              ).toString(),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200.0,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        50.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      20.0),
                                                          child: Text(
                                                            'Extra Details (remove me):',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      18.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      40.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Id:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      18.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            (_model.getPaymentMethodsOutput
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$[0].id''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Email:',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      18.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                          ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            (_model.getPaymentMethodsOutput
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$[0].email''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    20.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.deletePaymentMethodResult =
                                                                await DeleteCustomersPaymentMethodCall
                                                                    .call(
                                                              bearerToken:
                                                                  _model
                                                                      .jwtToken,
                                                              id: getJsonField(
                                                                (_model.getPaymentMethodsOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$[0].id''',
                                                              ).toString(),
                                                            );
                                                            if ((_model.deletePaymentMethodResult
                                                                        ?.statusCode ??
                                                                    200) ==
                                                                200) {
                                                              context.pushNamed(
                                                                  'PaymentPage');
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

                                                            setState(() {});
                                                          },
                                                          text: 'Remove',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 30.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        0.0,
                                                                        24.0,
                                                                        0.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily,
                                                                      color: Colors
                                                                          .white,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).titleSmallFamily),
                                                                    ),
                                                            elevation: 3.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                      if (functions
                                              .arrayLengthOrNegativeOneIfNotArray(
                                                  _model.paymentMethods) ==
                                          0)
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Add a new payment method',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          fontSize: 28.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 15.0, 0.0, 0.0),
                                                child: Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id lectus eu purus scelerisque hendrerit.\n\nAenean placerat libero et velit interdum, nec dictum arcu egestas.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 20.0, 0.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    _model.checkoutPageURI =
                                                        await CreateStripeCheckoutSessionCall
                                                            .call(
                                                      bearerToken:
                                                          _model.jwtToken,
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

                                                    setState(() {});
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
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.mobileNavModel,
                    updateCallback: () => setState(() {}),
                    child: MobileNavWidget(
                      navOneIcon: Icon(
                        Icons.home_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navTwoIcon: Icon(
                        Icons.credit_card_rounded,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      navThreeIcon: Icon(
                        Icons.contact_page,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navFourIcon: Icon(
                        Icons.settings,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navFiveIcon: Icon(
                        Icons.home_work_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
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
