import '/components/supply_contract_card/supply_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'supply_contract_sign_or_view_modal_widget.dart'
    show SupplyContractSignOrViewModalWidget;
import 'package:flutter/material.dart';

class SupplyContractSignOrViewModalModel
    extends FlutterFlowModel<SupplyContractSignOrViewModalWidget> {
  ///  Local state fields for this component.

  String? docusealEmbedHTML = '';

  ///  State fields for stateful widgets in this component.

  // Model for SupplyContractCard component.
  late SupplyContractCardModel supplyContractCardModel;
  // Stores action output result for [Action Block - ContractSignEmbed] action in SupplyContractCard widget.
  String? signEmbedHTML;

  @override
  void initState(BuildContext context) {
    supplyContractCardModel =
        createModel(context, () => SupplyContractCardModel());
  }

  @override
  void dispose() {
    supplyContractCardModel.dispose();
  }
}
