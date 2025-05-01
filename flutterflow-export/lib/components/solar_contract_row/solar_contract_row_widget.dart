import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/solar_contract_choose_or_view_modal/solar_contract_choose_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
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
    required this.isSigned,
    required this.description,
  });

  final ContractStruct? contract;
  final bool? isSigned;
  final String? description;

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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                    widget!.description!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: FlutterFlowTheme.of(context).bodyMedium,
                          letterSpacing: 0.0,
                        ),
                  ),
                  if (widget!.isSigned == true)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        '',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: FlutterFlowTheme.of(context).bodySmall,
                              letterSpacing: 0.0,
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
                    if (widget!.isSigned!) {
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
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SolarContractChooseOrViewModalWidget(
                              readOnly: widget!.isSigned!,
                              contract: widget!.contract!,
                              termsSolarShortTerm: _model.termsSolarShortTerm!,
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    }

                    safeSetState(() {});
                  },
                  text: 'View',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: FlutterFlowTheme.of(context).titleSmall,
                          color: Colors.white,
                          letterSpacing: 0.0,
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
