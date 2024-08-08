import '/backend/schema/structs/index.dart';
import '/components/supply_contract_sign_or_view_modal/supply_contract_sign_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'supply_contract_row_model.dart';
export 'supply_contract_row_model.dart';

class SupplyContractRowWidget extends StatefulWidget {
  const SupplyContractRowWidget({
    super.key,
    required this.contract,
    required this.readOnly,
    required this.contractTerms,
  });

  final ContractStruct? contract;
  final bool? readOnly;
  final ContractTermsStruct? contractTerms;

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
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: FaIcon(
              FontAwesomeIcons.fileContract,
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
                  if (widget!.readOnly ?? true)
                    Text(
                      widget!.contractTerms!.shortDescription,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleMediumFamily),
                          ),
                    ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      '',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodySmallFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodySmallFamily),
                          ),
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
                      if (widget!.readOnly!) {
                        await actions.openPDF(
                          widget!.contract!.signedContractURL,
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
                                  contract: widget!.contract!,
                                  terms: _model.supplyContractTerms!,
                                ),
                              ),
                            );
                          },
                        );
                      }

                      setState(() {});
                    },
                    text: widget!.readOnly == true ? 'View' : 'Choose Contract',
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
                            letterSpacing: 0.0,
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
