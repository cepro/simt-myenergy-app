import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'solar_contract_row_widget.dart' show SolarContractRowWidget;
import 'package:flutter/material.dart';

class SolarContractRowModel extends FlutterFlowModel<SolarContractRowWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Contract Terms latest)] action in Button widget.
  ApiCallResponse? contractTermsLatest;
  // Stores action output result for [Custom Action - getTermsByTypeAndSubtype] action in Button widget.
  ContractTermsStruct? termsSolarShortTerm;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
