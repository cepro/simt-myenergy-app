import '/backend/schema/structs/index.dart';
import '/components/solar_contract_card/solar_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'solar_contract_choose_or_view_modal_model.dart';
export 'solar_contract_choose_or_view_modal_model.dart';

class SolarContractChooseOrViewModalWidget extends StatefulWidget {
  const SolarContractChooseOrViewModalWidget({
    super.key,
    required this.contract,
    required this.readOnly,
    required this.termsSolarShortTerm,
  });

  final ContractStruct? contract;
  final bool? readOnly;
  final ContractTermsStruct? termsSolarShortTerm;

  @override
  State<SolarContractChooseOrViewModalWidget> createState() =>
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                            widget!.readOnly!
                                ? 'Solar Contract'
                                : 'Choose Solar Contract',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineMediumFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineMediumIsCustom,
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
                      if ((widget!.contract?.id != null &&
                              widget!.contract?.id != '') &&
                          (_model.docusealEmbedHTML == null ||
                              _model.docusealEmbedHTML == ''))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (widget!.contract?.termsId != null &&
                                widget!.contract?.termsId != '')
                              wrapWithModel(
                                model: _model.solarShortTermContractCardModel,
                                updateCallback: () => safeSetState(() {}),
                                child: SolarContractCardWidget(
                                  title: 'Short Term',
                                  contract: widget!.contract!,
                                  terms: widget!.termsSolarShortTerm!,
                                  setSignEmbedHTML: () async {
                                    _model.signEmbedHTMLShortTerm =
                                        await action_blocks.contractSignEmbed(
                                      context,
                                      contractId: widget!.contract?.id,
                                      termsSubtype: 'short_term',
                                    );
                                    _model.docusealEmbedHTML =
                                        _model.signEmbedHTMLShortTerm;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                ),
                              ),
                          ].divide(SizedBox(height: 30.0)),
                        ),
                      if (_model.docusealEmbedHTML != null &&
                          _model.docusealEmbedHTML != '')
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.85,
                          child: custom_widgets.ContractSigningWidget(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.85,
                            html: _model.docusealEmbedHTML!,
                          ),
                        ),
                      if ((widget!.contract?.id == null ||
                              widget!.contract?.id == '') ||
                          (widget!.contract?.termsId == null ||
                              widget!.contract?.termsId == ''))
                        Text(
                          'Contract has not yet been created. Please contact support to find out why.',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
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
