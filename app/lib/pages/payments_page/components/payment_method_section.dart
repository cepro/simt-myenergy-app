import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/credit_card/credit_card_widget.dart';
import '/components/direct_debit/direct_debit_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({
    super.key,
    required this.paymentMethodsJson,
    required this.onPaymentMethodDeleted,
  });

  final dynamic paymentMethodsJson;
  final VoidCallback onPaymentMethodDeleted;

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  ApiCallResponse? deletePaymentMethodResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 470.0,
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
              child: Text(
                'Payment method',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                    ),
              ),
            ),
            if (getJsonField(widget.paymentMethodsJson, r'''$[0].directDebit''') != null)
              DirectDebitWidget(
                last4Digits: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].directDebit.last4''',
                ).toString(),
                sortCode: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].directDebit.sortCode''',
                ).toString(),
              ),
            if (getJsonField(widget.paymentMethodsJson, r'''$[0].card''') != null)
              CreditCardWidget(
                last4Digits: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].card.last4''',
                ).toString(),
                expiryYear: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].card.expiryYear''',
                ),
                expiryMonth: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].card.expiryMonth''',
                ),
                cardBrand: getJsonField(
                  widget.paymentMethodsJson,
                  r'''$[0].card.brand''',
                ).toString(),
              ),
            Align(
              alignment: const AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: (FFAppState().impersonationToken != '') ? null : () async {
                    await action_blocks.checkAndBlockWriteableAPICall(context);
                    deletePaymentMethodResult = await DeleteCustomersPaymentMethodCall.call(
                      bearerToken: currentJwtToken,
                      id: getJsonField(
                        widget.paymentMethodsJson,
                        r'''$[0].id''',
                      ).toString(),
                      esco: FFAppState().esco?.name,
                    );

                    if (!context.mounted) return;

                    if ((deletePaymentMethodResult?.statusCode ?? 200) == 200) {
                      widget.onPaymentMethodDeleted();
                    } else {
                      await action_blocks.handleMyEnergyApiCallFailure(
                        context,
                        wwwAuthenticateHeader: (deletePaymentMethodResult?.getHeader('www-authenticate') ?? ''),
                        httpStatusCode: (deletePaymentMethodResult?.statusCode ?? 200),
                      );
                    }

                    setState(() {});
                  },
                  text: 'Remove Payment Method',
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
