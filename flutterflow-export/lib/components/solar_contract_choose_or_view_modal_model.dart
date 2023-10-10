import '/components/contract_choice_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'solar_contract_choose_or_view_modal_widget.dart'
    show SolarContractChooseOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SolarContractChooseOrViewModalModel
    extends FlutterFlowModel<SolarContractChooseOrViewModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ContractChoiceCard component.
  late ContractChoiceCardModel contractChoiceCardModel1;
  // Model for ContractChoiceCard component.
  late ContractChoiceCardModel contractChoiceCardModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    contractChoiceCardModel1 =
        createModel(context, () => ContractChoiceCardModel());
    contractChoiceCardModel2 =
        createModel(context, () => ContractChoiceCardModel());
  }

  void dispose() {
    contractChoiceCardModel1.dispose();
    contractChoiceCardModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
