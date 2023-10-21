import '/components/solar_contract_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'solar_contract_choose_or_view_modal_widget.dart'
    show SolarContractChooseOrViewModalWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SolarContractChooseOrViewModalModel
    extends FlutterFlowModel<SolarContractChooseOrViewModalWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SolarContractCard component.
  late SolarContractCardModel solarContractCardModel1;
  // Model for SolarContractCard component.
  late SolarContractCardModel solarContractCardModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    solarContractCardModel1 =
        createModel(context, () => SolarContractCardModel());
    solarContractCardModel2 =
        createModel(context, () => SolarContractCardModel());
  }

  void dispose() {
    solarContractCardModel1.dispose();
    solarContractCardModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
