import '/components/coming_soon_for_preonboarding_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'supply_contract_card_widget.dart' show SupplyContractCardWidget;
import 'package:flutter/material.dart';

class SupplyContractCardModel
    extends FlutterFlowModel<SupplyContractCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ComingSoonForPreonboarding component.
  late ComingSoonForPreonboardingModel comingSoonForPreonboardingModel;

  @override
  void initState(BuildContext context) {
    comingSoonForPreonboardingModel =
        createModel(context, () => ComingSoonForPreonboardingModel());
  }

  @override
  void dispose() {
    comingSoonForPreonboardingModel.dispose();
  }
}
