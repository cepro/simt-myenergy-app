import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/solar_contract_choose_or_view_modal/solar_contract_choose_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'solar_contract_row_model.dart';
export 'solar_contract_row_model.dart';

class SolarContractRowWidget extends StatefulWidget {
  const SolarContractRowWidget({
    super.key,
    required this.contract,
    required this.readOnly,
  });

  final ContractStruct? contract;
  final bool? readOnly;

  @override
  State<SolarContractRowWidget> createState() => _SolarContractRowWidgetState();
}

class _SolarContractRowWidgetState extends State<SolarContractRowWidget> {
  late SolarContractRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SolarContractRowModel());

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
                  if (widget!.readOnly == true)
                    Text(
                      valueOrDefault<String>(
                        widget!.contract?.description,
                        '<description not set>',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleMediumFamily),
                          ),
                    ),
                  if (widget!.readOnly == true)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
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
                FFButtonWidget(
                  onPressed: () async {
                    if (widget!.readOnly!) {
                      await actions.openPDF(
                        widget!.contract!.signedContractURL,
                      );
                    } else {
                      _model.contractTermsLatest =
                          await ContractTermsLatestCall.call(
                        bearerToken: currentJwtToken,
                      );

                      _model.termsSolarShortTerm =
                          await actions.getTermsByTypeAndSubtype(
                        FFAppState().contractTerms.toList(),
                        'solar',
                        'short_term',
                      );
                      _model.termsSolar30Year =
                          await actions.getTermsByTypeAndSubtype(
                        FFAppState().contractTerms.toList(),
                        'solar',
                        'thirty_year',
                      );
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SolarContractChooseOrViewModalWidget(
                              readOnly: widget!.readOnly!,
                              termsSolar30Year: _model.termsSolar30Year!,
                              contract: widget!.contract!,
                              termsSolarShortTerm: _model.termsSolarShortTerm!,
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
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
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
