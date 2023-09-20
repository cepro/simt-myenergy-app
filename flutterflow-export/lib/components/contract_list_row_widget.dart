import '/components/contract_acceptance_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contract_list_row_model.dart';
export 'contract_list_row_model.dart';

class ContractListRowWidget extends StatefulWidget {
  const ContractListRowWidget({
    Key? key,
    required this.contractJSON,
    required this.readOnly,
  }) : super(key: key);

  final dynamic contractJSON;
  final bool? readOnly;

  @override
  _ContractListRowWidgetState createState() => _ContractListRowWidgetState();
}

class _ContractListRowWidgetState extends State<ContractListRowWidget> {
  late ContractListRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContractListRowModel());

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
                  Text(
                    getJsonField(
                      widget.contractJSON,
                      r'''$.terms.type''',
                    ).toString(),
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
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
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: ContractAcceptanceModalWidget(
                            contractJSON: widget.contractJSON!,
                            readOnly: widget.readOnly!,
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  text: widget.readOnly == true ? 'View' : 'Sign',
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
