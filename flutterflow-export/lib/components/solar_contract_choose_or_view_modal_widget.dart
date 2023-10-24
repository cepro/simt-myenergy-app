import '/components/solar_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'solar_contract_choose_or_view_modal_model.dart';
export 'solar_contract_choose_or_view_modal_model.dart';

class SolarContractChooseOrViewModalWidget extends StatefulWidget {
  const SolarContractChooseOrViewModalWidget({
    Key? key,
    required this.contractJSON,
    required this.readOnly,
    required this.termsSolar30Year,
    required this.termsSolarShortTerm,
  }) : super(key: key);

  final dynamic contractJSON;
  final bool? readOnly;
  final dynamic termsSolar30Year;
  final dynamic termsSolarShortTerm;

  @override
  _SolarContractChooseOrViewModalWidgetState createState() =>
      _SolarContractChooseOrViewModalWidgetState();
}

class _SolarContractChooseOrViewModalWidgetState
    extends State<SolarContractChooseOrViewModalWidget> {
  late SolarContractChooseOrViewModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SolarContractChooseOrViewModalModel());

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
                            widget.readOnly!
                                ? 'Solar Contract'
                                : 'Choose Solar Contract',
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
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            wrapWithModel(
                              model: _model.solar30YearContractCardModel,
                              updateCallback: () => setState(() {}),
                              child: SolarContractCardWidget(
                                title: '30 Years',
                                contractJSON: widget.contractJSON!,
                                termsJSON: widget.termsSolar30Year!,
                                setSignEmbedHTML: () async {
                                  _model.signEmbedHTMLThirtyYear =
                                      await action_blocks.contractSignEmbed(
                                    context,
                                    contractId: getJsonField(
                                      widget.contractJSON,
                                      r'''$.id''',
                                    ).toString(),
                                    termsSubtype: 'thirty_year',
                                  );
                                  setState(() {
                                    _model.docusealEmbedHTML =
                                        _model.signEmbedHTMLThirtyYear;
                                  });

                                  setState(() {});
                                },
                              ),
                            ),
                            wrapWithModel(
                              model: _model.solarShortTermContractCardModel,
                              updateCallback: () => setState(() {}),
                              child: SolarContractCardWidget(
                                title: 'Short Term',
                                contractJSON: widget.contractJSON!,
                                termsJSON: widget.termsSolarShortTerm!,
                                setSignEmbedHTML: () async {
                                  _model.signEmbedHTMLShortTerm =
                                      await action_blocks.contractSignEmbed(
                                    context,
                                    contractId: getJsonField(
                                      widget.contractJSON,
                                      r'''$.id''',
                                    ).toString(),
                                    termsSubtype: 'short_term',
                                  );
                                  setState(() {
                                    _model.docusealEmbedHTML =
                                        _model.signEmbedHTMLShortTerm;
                                  });

                                  setState(() {});
                                },
                              ),
                            ),
                          ],
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
