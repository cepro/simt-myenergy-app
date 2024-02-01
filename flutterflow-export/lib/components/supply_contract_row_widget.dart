import '/backend/schema/structs/index.dart';
import '/components/supply_contract_sign_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'supply_contract_row_model.dart';
export 'supply_contract_row_model.dart';

class SupplyContractRowWidget extends StatefulWidget {
  const SupplyContractRowWidget({
    super.key,
    required this.contract,
    required this.readOnly,
  });

  final ContractStruct? contract;
  final bool? readOnly;

  @override
  State<SupplyContractRowWidget> createState() =>
      _SupplyContractRowWidgetState();
}

class _SupplyContractRowWidgetState extends State<SupplyContractRowWidget> {
  late SupplyContractRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupplyContractRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Color(0x428377F3),
              borderRadius: BorderRadius.circular(16.0),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Icon(
              Icons.contact_page_outlined,
              color: FlutterFlowTheme.of(context).primary,
              size: 32.0,
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.contract?.description,
                      '<description not set>',
                    ),
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Builder(
                  builder: (context) => FFButtonWidget(
                    onPressed: () async {
                      if (widget.readOnly!) {
                        await actions.openPDF(
                          widget.contract!.signedContractURL,
                        );
                      } else {
                        _model.supplyContractTerms =
                            await actions.getTermsByTypeAndSubtype(
                          FFAppState().contractTerms.toList(),
                          'supply',
                          null,
                        );
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: SupplyContractSignOrViewModalWidget(
                                  contract: widget.contract!,
                                  terms: _model.supplyContractTerms!,
                                ),
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      }

                      setState(() {});
                    },
                    text: widget.readOnly == true ? 'View' : 'Sign',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleSmallFamily),
                          ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
