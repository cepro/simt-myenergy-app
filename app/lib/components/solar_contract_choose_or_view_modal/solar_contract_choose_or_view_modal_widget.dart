import '/backend/schema/structs/index.dart';
import 'dart:async';

import '/backend/schema/contract_signers.dart';
import '/components/contract_signing_progress/contract_signing_progress_widget.dart';
import '/components/solar_contract_card/solar_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/contract_sign_embed_error.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/actions/contract_signed_refresh.dart'
    show findContractById, hasSignedContractPdf;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
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

    // Multi-party contracts: load signing progress now, and keep it fresh
    // while the modal is open so "waiting for you" changes once the customer
    // (or the co-signer) signs. Stops once the contract is fully signed.
    if ((widget.contract?.signaturesRequired ?? 1) > 1 &&
        !hasSignedContractPdf(widget.contract)) {
      _loadSigners();
      _signersTimer =
          Timer.periodic(const Duration(seconds: 15), (_) => _loadSigners());
    }
  }

  ContractSigners? _signers;
  Timer? _signersTimer;

  Future<void> _loadSigners() async {
    final signers =
        await action_blocks.contractSigners(contractId: widget.contract?.id);
    if (!mounted) return;
    if (signers != null) {
      _signers = signers;
      if (signers.signed) _signersTimer?.cancel();
      safeSetState(() {});
    }
  }

  @override
  void dispose() {
    _signersTimer?.cancel();
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> _loadSignEmbed() async {
    _model.embedError = null;
    _model.embedLoading = true;
    safeSetState(() {});
    _model.signEmbedHTMLShortTerm = await action_blocks.contractSignEmbed(
      context,
      contractId: widget.contract?.id,
      termsSubtype: 'short_term',
      onError: (error) => _model.embedError = error,
    );
    _model.docusealEmbedHTML = _model.signEmbedHTMLShortTerm;
    _model.embedLoading = false;
    safeSetState(() {});
    // Opening the embed creates the DocuSeal submission on first open, which
    // is when `/signers` starts listing the proprietors.
    if (_signersTimer != null) unawaited(_loadSigners());
  }

  TextStyle _bodyStyle(BuildContext context) =>
      FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            letterSpacing: 0.0,
            useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
          );

  Widget _embedErrorPanel(BuildContext context, ContractSignEmbedError error) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      key: const ValueKey('contract-sign-embed-error'),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: theme.error),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            error.title,
            style: theme.titleSmall.override(
              fontFamily: theme.titleSmallFamily,
              letterSpacing: 0.0,
              useGoogleFonts: !theme.titleSmallIsCustom,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(error.message, style: _bodyStyle(context)),
          if (error.retryable) ...[
            const SizedBox(height: 12.0),
            FFButtonWidget(
              onPressed: _model.embedLoading ? null : _loadSignEmbed,
              text: _model.embedLoading ? 'Trying again…' : 'Try again',
              options: FFButtonOptions(
                height: 40.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                color: theme.primary,
                textStyle: theme.titleSmall.override(
                  fontFamily: theme.titleSmallFamily,
                  color: Colors.white,
                  letterSpacing: 0.0,
                  useGoogleFonts: !theme.titleSmallIsCustom,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _signedPanel(BuildContext context, ContractStruct contract) {
    final theme = FlutterFlowTheme.of(context);
    return Column(
      key: const ValueKey('contract-signed-panel'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contract.signaturesRequired > 1
              ? 'The contract has been signed by both proprietors.'
              : 'The contract has been signed.',
          style: _bodyStyle(context),
        ),
        const SizedBox(height: 12.0),
        FFButtonWidget(
          onPressed: () async {
            await actions.openPDF(contract.signedContractURL);
          },
          text: 'View signed contract',
          options: FFButtonOptions(
            height: 40.0,
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            color: theme.primary,
            textStyle: theme.titleSmall.override(
              fontFamily: theme.titleSmallFamily,
              color: Colors.white,
              letterSpacing: 0.0,
              useGoogleFonts: !theme.titleSmallIsCustom,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        if (contract.auditLogURL.isNotEmpty)
          TextButton(
            key: const ValueKey('contract-audit-log-link'),
            onPressed: () async {
              await actions.openPDF(contract.auditLogURL);
            },
            child: const Text('View signing audit log'),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch app state so a `contract_signed` SSE event (and the follow-up
    // refresh that fetches the signed PDF URL) updates an open modal: once
    // the contract has its signed PDF, replace the embed with a link to it.
    final liveContract = findContractById(
            context.watch<FFAppState>().accountsAll,
            widget.contract?.id ?? '') ??
        widget.contract;
    final signedPdfReady = hasSignedContractPdf(liveContract);

    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color(0xFFE0E3E7),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Text(
                            widget.readOnly!
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
                  if (!signedPdfReady &&
                      (liveContract?.signaturesRequired ?? 1) > 1 &&
                      (liveContract?.id ?? '') != '')
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 16.0),
                      child: ContractSigningProgressWidget(
                        signaturesRequired: liveContract!.signaturesRequired,
                        signers: _signers,
                        textStyle: _bodyStyle(context),
                      ),
                    ),
                  if (signedPdfReady)
                    _signedPanel(context, liveContract!)
                  else
                    Stack(
                      children: [
                        if (_model.embedError != null &&
                            (_model.docusealEmbedHTML == null ||
                                _model.docusealEmbedHTML == ''))
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child:
                                _embedErrorPanel(context, _model.embedError!),
                          ),
                        if (_model.embedError == null &&
                            (widget.contract?.id != null &&
                                widget.contract?.id != '') &&
                            (_model.docusealEmbedHTML == null ||
                                _model.docusealEmbedHTML == ''))
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (widget.contract?.termsId != null &&
                                  widget.contract?.termsId != '')
                                wrapWithModel(
                                  model: _model.solarShortTermContractCardModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SolarContractCardWidget(
                                    title: 'Short Term',
                                    contract: widget.contract!,
                                    terms: widget.termsSolarShortTerm!,
                                    setSignEmbedHTML: _loadSignEmbed,
                                  ),
                                ),
                            ].divide(const SizedBox(height: 30.0)),
                          ),
                        if (_model.docusealEmbedHTML != null &&
                            _model.docusealEmbedHTML != '')
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.85,
                            child: custom_widgets.ContractSigningWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.85,
                              html: _model.docusealEmbedHTML!,
                            ),
                          ),
                        if ((widget.contract?.id == null ||
                                widget.contract?.id == '') ||
                            (widget.contract?.termsId == null ||
                                widget.contract?.termsId == ''))
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
