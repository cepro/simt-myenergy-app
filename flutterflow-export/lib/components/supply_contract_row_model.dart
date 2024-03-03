import '/backend/schema/structs/index.dart';
import '/components/supply_contract_sign_or_view_modal_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'supply_contract_row_widget.dart' show SupplyContractRowWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SupplyContractRowModel extends FlutterFlowModel<SupplyContractRowWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getTermsByTypeAndSubtype] action in Button widget.
  ContractTermsStruct? supplyContractTerms;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
