import '';
import '/components/logo_container_row/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'forgot_password_page_widget.dart' show ForgotPasswordPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPageModel
    extends FlutterFlowModel<ForgotPasswordPageWidget> {
  ///  Local state fields for this page.

  bool resetError = false;

  bool resetSent = false;

  ///  State fields for stateful widgets in this page.

  // Model for LogoContainerRow component.
  late LogoContainerRowModel logoContainerRowModel;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // Stores action output result for [Custom Action - supabasePasswordReset] action in Button-Send-Reset-Link widget.
  bool? sendResetSuccess;

  @override
  void initState(BuildContext context) {
    logoContainerRowModel = createModel(context, () => LogoContainerRowModel());
  }

  @override
  void dispose() {
    logoContainerRowModel.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();
  }
}
