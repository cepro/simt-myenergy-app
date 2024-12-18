import '/backend/schema/structs/index.dart';
import '/components/coming_soon_for_preonboarding_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'solar_contract_card_widget.dart' show SolarContractCardWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SolarContractCardModel extends FlutterFlowModel<SolarContractCardWidget> {
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
