import '/backend/schema/structs/index.dart';
import '/components/supply_contract_card/supply_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'supply_contract_sign_or_view_modal_model.dart';
export 'supply_contract_sign_or_view_modal_model.dart';

class SupplyContractSignOrViewModalWidget extends StatefulWidget {
  const SupplyContractSignOrViewModalWidget({
    super.key,
    required this.contract,
    required this.terms,
  });

  final ContractStruct? contract;
  final ContractTermsStruct? terms;

  @override
  State<SupplyContractSignOrViewModalWidget> createState() =>
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
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
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
            padding: EdgeInsets.all(24.0),
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
                            'Electricity Supply Contract',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineMediumFamily),
                                ),
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
                          context.safePop();
                          await actions.appStateNotifyListeners();
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
                            contract: widget!.contract!,
                            terms: widget!.terms!,
                            setSignEmbedHTML: () async {
                              _model.signEmbedHTML =
                                  await action_blocks.contractSignEmbed(
                                context,
                                contractId: widget!.contract?.id,
                              );
                              _model.docusealEmbedHTML = _model.signEmbedHTML;
                              setState(() {});

                              setState(() {});
                            },
                          ),
                        ),
                      if (_model.docusealEmbedHTML != null &&
                          _model.docusealEmbedHTML != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 108.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.85,
                            child: custom_widgets.ContractSigningWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.85,
                              html: _model.docusealEmbedHTML!,
                            ),
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
