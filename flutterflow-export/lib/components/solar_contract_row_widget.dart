import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/solar_contract_choose_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'solar_contract_row_model.dart';
export 'solar_contract_row_model.dart';

class SolarContractRowWidget extends StatefulWidget {
  const SolarContractRowWidget({
    Key? key,
    required this.contractJSON,
    required this.readOnly,
  }) : super(key: key);

  final dynamic contractJSON;
  final bool? readOnly;

  @override
  _SolarContractRowWidgetState createState() => _SolarContractRowWidgetState();
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
            alignment: AlignmentDirectional(0.00, 0.00),
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
                  if (widget.readOnly == true)
                    Text(
                      getJsonField(
                        widget.contractJSON,
                        r'''$.type''',
                      ).toString(),
                      style: FlutterFlowTheme.of(context).titleMedium,
                    ),
                  if (widget.readOnly == true)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        getJsonField(
                          widget.contractJSON,
                          r'''$.description''',
                        ).toString(),
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
                FFButtonWidget(
                  onPressed: () async {
                    if (widget.readOnly!) {
                      await actions.openPDF(
                        getJsonField(
                          widget.contractJSON,
                          r'''$.signedContractURL''',
                        ).toString(),
                      );
                    } else {
                      _model.contractTermsLatest =
                          await ContractTermsLatestCall.call(
                        bearerToken: currentJwtToken,
                      );
                      _model.termsSolarShortTerm =
                          await actions.getTermsFromLatestTermsJSON(
                        (_model.contractTermsLatest?.jsonBody ?? ''),
                        'solar',
                        'short_term',
                      );
                      _model.termsSolar30Year =
                          await actions.getTermsFromLatestTermsJSON(
                        (_model.contractTermsLatest?.jsonBody ?? ''),
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
                              contractJSON: widget.contractJSON!,
                              readOnly: widget.readOnly!,
                              termsSolar30Year: _model.termsSolar30Year!,
                              termsSolarShortTerm: _model.termsSolarShortTerm!,
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    }

                    setState(() {});
                  },
                  text: widget.readOnly == true ? 'View' : 'Choose Contract',
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
