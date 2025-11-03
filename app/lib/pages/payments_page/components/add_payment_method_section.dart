import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';

class AddPaymentMethodSection extends StatefulWidget {
  const AddPaymentMethodSection({super.key});

  @override
  State<AddPaymentMethodSection> createState() => _AddPaymentMethodSectionState();
}

class _AddPaymentMethodSectionState extends State<AddPaymentMethodSection> {
  ApiCallResponse? checkoutPageURI;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-1.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
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
            children: [
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Text(
                  'Add a new payment method',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Text(
                  'Customers use Stripe payments to automatically and securely add credit to your energy meter. Stripe supports either a Direct Debit mandate (protected by the Direct Debit Guarantee) or you may make payment with a debit card.\n\nNo payments will be taken until your energy supply contract has been signed. Once under contract customers nominate a day of the month to make payment. You pay each month for the following month\'s use, based on our projected use estimation for that month. If your usage is higher than expected, and the meter hits a user-defined threshold, a further payment is taken to avoid running out of credit. If your usage is lower than expected, the balance rolls over and the next month\'s payment is adjusted down.\n\nYou will be invited to sign contracts for energy supply. You will be notified by email 24 hours before any payments are taken.\n',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: (FFAppState().customer.status == 'preonboarding')
                          ? null
                          : () async {
                              await action_blocks.checkAndBlockWriteableAPICall(context);
                              checkoutPageURI = await CreateStripeCheckoutSessionCall.call(
                                bearerToken: currentJwtToken,
                                esco: FFAppState().esco?.name,
                              );

                              if (!context.mounted) return;

                              if (checkoutPageURI != null) {
                                await actions.navigateToExternalURI(
                                  CreateStripeCheckoutSessionCall.checkoutPageURI(
                                    (checkoutPageURI?.jsonBody ?? ''),
                                  ).toString(),
                                );
                              } else {
                                await action_blocks.handleMyEnergyApiCallFailure(
                                  context,
                                  wwwAuthenticateHeader:
                                      (checkoutPageURI?.getHeader('www-authenticate') ?? ''),
                                  httpStatusCode: (checkoutPageURI?.statusCode ?? 200),
                                );
                              }

                              setState(() {});
                            },
                      text: 'Setup Payment with Stripe',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                            ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        disabledColor: FlutterFlowTheme.of(context).lineColor,
                        disabledTextColor: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: const ComingSoonForPreonboardingWidget(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
