import '/components/supply_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'supply_contract_sign_or_view_modal_model.dart';
export 'supply_contract_sign_or_view_modal_model.dart';

class SupplyContractSignOrViewModalWidget extends StatefulWidget {
  const SupplyContractSignOrViewModalWidget({
    Key? key,
    required this.contractJSON,
  }) : super(key: key);

  final dynamic contractJSON;

  @override
  _SupplyContractSignOrViewModalWidgetState createState() =>
      _SupplyContractSignOrViewModalWidgetState();
}

class _SupplyContractSignOrViewModalWidgetState
    extends State<SupplyContractSignOrViewModalWidget> {
  late SupplyContractSignOrViewModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupplyContractSignOrViewModalModel());

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

    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Color(0xFFE0E3E7),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Text(
                            'Supply Contract',
                            style: FlutterFlowTheme.of(context).headlineMedium,
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: 30.0,
                        borderWidth: 2.0,
                        buttonSize: 44.0,
                        icon: Icon(
                          Icons.close_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 24.0,
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  Stack(
                    children: [
                      if (_model.docusealEmbedHTML == null ||
                          _model.docusealEmbedHTML == '')
                        wrapWithModel(
                          model: _model.supplyContractCardModel,
                          updateCallback: () => setState(() {}),
                          child: SupplyContractCardWidget(
                            title: 'Supply Contract',
                            contractJSON: widget.contractJSON!,
                            setSignEmbedHTML: () async {
                              _model.signEmbedHTML =
                                  await action_blocks.contractSignEmbed(
                                context,
                                contractId: getJsonField(
                                  widget.contractJSON,
                                  r'''$.id''',
                                ).toString(),
                              );
                              setState(() {
                                _model.docusealEmbedHTML = _model.signEmbedHTML;
                              });

                              setState(() {});
                            },
                          ),
                        ),
                      if (_model.docusealEmbedHTML != null &&
                          _model.docusealEmbedHTML != '')
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: custom_widgets.ContractSigningWidget(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            html: _model.docusealEmbedHTML!,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
