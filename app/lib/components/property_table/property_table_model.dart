import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'property_table_widget.dart' show PropertyTableWidget;
import 'package:flutter/material.dart';

class PropertyTableModel extends FlutterFlowModel<PropertyTableWidget> {
  ///  Local state fields for this component.

  bool loadingImpersonation = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<PropertyStruct>();
  // Stores action output result for [Action Block - ImpersonateCustomer] action in Text widget.
  bool? impersonateResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    paginatedDataTableController.dispose();
  }
}
