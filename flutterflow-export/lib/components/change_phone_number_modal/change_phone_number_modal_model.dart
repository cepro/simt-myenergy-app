import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'change_phone_number_modal_widget.dart'
    show ChangePhoneNumberModalWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePhoneNumberModalModel
    extends FlutterFlowModel<ChangePhoneNumberModalWidget> {
  ///  Local state fields for this component.

  bool verifyCode = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for PhoneNumberField widget.
  FocusNode? phoneNumberFieldFocusNode;
  TextEditingController? phoneNumberFieldTextController;
  String? Function(BuildContext, String?)?
      phoneNumberFieldTextControllerValidator;
  // State field(s) for VerifyCodeField widget.
  FocusNode? verifyCodeFieldFocusNode;
  TextEditingController? verifyCodeFieldTextController;
  String? Function(BuildContext, String?)?
      verifyCodeFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFieldFocusNode?.dispose();
    phoneNumberFieldTextController?.dispose();

    verifyCodeFieldFocusNode?.dispose();
    verifyCodeFieldTextController?.dispose();
  }
}
