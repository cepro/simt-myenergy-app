import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import 'change_name_modal_widget.dart' show ChangeNameModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeNameModalModel extends FlutterFlowModel<ChangeNameModalWidget> {
  ///  Local state fields for this component.

  bool showError = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Update Customer Fullname Copy)] action in Button widget.
  ApiCallResponse? updateCustomerFullnameResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();
  }
}
