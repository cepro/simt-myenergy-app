import '/components/supply_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'supply_contract_sign_or_view_modal_widget.dart'
    show SupplyContractSignOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SupplyContractSignOrViewModalModel
    extends FlutterFlowModel<SupplyContractSignOrViewModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SupplyContractCard component.
  late SupplyContractCardModel supplyContractCardModel;

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
