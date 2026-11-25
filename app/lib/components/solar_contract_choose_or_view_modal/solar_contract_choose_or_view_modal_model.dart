import '/components/solar_contract_card/solar_contract_card_widget.dart';
import '/actions/contract_sign_embed_error.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'solar_contract_choose_or_view_modal_widget.dart'
    show SolarContractChooseOrViewModalWidget;
import 'package:flutter/material.dart';

class SolarContractChooseOrViewModalModel
    extends FlutterFlowModel<SolarContractChooseOrViewModalWidget> {
  ///  Local state fields for this component.

  String? docusealEmbedHTML = '';

  // Set when the signing embed call fails; shown inline with a retry when
  // the error is retryable (see contract_sign_embed_error.dart).
  ContractSignEmbedError? embedError;

  // True while the signing embed is being fetched (used by the retry button).
  bool embedLoading = false;

  ///  State fields for stateful widgets in this component.

  // Model for SolarShortTermContractCard.
  late SolarContractCardModel solarShortTermContractCardModel;
  // Stores action output result for [Action Block - ContractSignEmbed] action in SolarShortTermContractCard widget.
  String? signEmbedHTMLShortTerm;

  @override
  void initState(BuildContext context) {
    solarShortTermContractCardModel =
        createModel(context, () => SolarContractCardModel());
  }

  @override
  void dispose() {
    solarShortTermContractCardModel.dispose();
  }
}
