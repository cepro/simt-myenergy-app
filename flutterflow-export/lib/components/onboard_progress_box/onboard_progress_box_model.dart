import '/components/onboard_progress_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'onboard_progress_box_widget.dart' show OnboardProgressBoxWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class OnboardProgressBoxModel
    extends FlutterFlowModel<OnboardProgressBoxWidget> {
  ///  Local state fields for this component.

  double actionsDonePercent = 0.0;

  ///  State fields for stateful widgets in this component.

  // Model for OnboardProgressRow component.
  late OnboardProgressRowModel onboardProgressRowModel1;
  // Model for OnboardProgressRow component.
  late OnboardProgressRowModel onboardProgressRowModel2;
  // Model for OnboardProgressRow component.
  late OnboardProgressRowModel onboardProgressRowModel3;
  // Model for OnboardProgressRow component.
  late OnboardProgressRowModel onboardProgressRowModel4;
  // Model for OnboardProgressRow component.
  late OnboardProgressRowModel onboardProgressRowModel5;

  @override
  void initState(BuildContext context) {
    onboardProgressRowModel1 =
        createModel(context, () => OnboardProgressRowModel());
    onboardProgressRowModel2 =
        createModel(context, () => OnboardProgressRowModel());
    onboardProgressRowModel3 =
        createModel(context, () => OnboardProgressRowModel());
    onboardProgressRowModel4 =
        createModel(context, () => OnboardProgressRowModel());
    onboardProgressRowModel5 =
        createModel(context, () => OnboardProgressRowModel());
  }

  @override
  void dispose() {
    onboardProgressRowModel1.dispose();
    onboardProgressRowModel2.dispose();
    onboardProgressRowModel3.dispose();
    onboardProgressRowModel4.dispose();
    onboardProgressRowModel5.dispose();
  }
}
