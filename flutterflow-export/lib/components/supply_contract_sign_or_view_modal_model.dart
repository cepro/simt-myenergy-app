import '/components/supply_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'supply_contract_sign_or_view_modal_widget.dart'
    show SupplyContractSignOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SupplyContractSignOrViewModalModel
    extends FlutterFlowModel<SupplyContractSignOrViewModalWidget> {
  ///  Local state fields for this component.

  String? docusealEmbedHTML = '';

  ///  State fields for stateful widgets in this component.

  // Model for SupplyContractCard component.
  late SupplyContractCardModel supplyContractCardModel;
  // Stores action output result for [Action Block - ContractSignEmbed] action in SupplyContractCard widget.
  String? signEmbedHTML;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    supplyContractCardModel =
        createModel(context, () => SupplyContractCardModel());
  }

  void dispose() {
    supplyContractCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
