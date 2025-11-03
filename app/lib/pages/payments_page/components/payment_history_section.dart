import '/backend/schema/structs/index.dart';
import '/components/payments_list/payments_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';

class PaymentHistorySection extends StatelessWidget {
  const PaymentHistorySection({
    super.key,
    required this.payments,
    required this.loading,
  });

  final List<PaymentStruct> payments;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(
        width: 100.0,
        height: 100.0,
        child: custom_widgets.LoadingSpinner(
          width: 100.0,
          height: 100.0,
        ),
      );
    }

    return Align(
      alignment: const AlignmentDirectional(-1.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
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
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                    child: Text(
                      'Payment History',
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                          ),
                    ),
                  ),
                ),
                if (payments.isNotEmpty)
                  PaymentsListWidget(
                    payments: payments,
                  ),
                if (payments.isEmpty)
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'No payments',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
