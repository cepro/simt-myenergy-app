import '/backend/schema/structs/index.dart';
import '/components/solar_contract_card/solar_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'solar_contract_choose_or_view_modal_widget.dart'
    show SolarContractChooseOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SolarContractChooseOrViewModalModel
    extends FlutterFlowModel<SolarContractChooseOrViewModalWidget> {
  ///  Local state fields for this component.

  String? docusealEmbedHTML = '';

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
