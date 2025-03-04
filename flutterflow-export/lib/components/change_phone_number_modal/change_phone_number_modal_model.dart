import '';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'change_phone_number_modal_widget.dart'
    show ChangePhoneNumberModalWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ChangePhoneNumberModalModel
    extends FlutterFlowModel<ChangePhoneNumberModalWidget> {
  ///  Local state fields for this component.

  bool verifyCode = false;

  bool showUpdateError = false;

  bool showVerifyError = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for PhoneNumberField widget.
  FocusNode? phoneNumberFieldFocusNode;
  TextEditingController? phoneNumberFieldTextController;
  final phoneNumberFieldMask = MaskTextInputFormatter(mask: '####-######');
  String? Function(BuildContext, String?)?
      phoneNumberFieldTextControllerValidator;
  // State field(s) for VerifyCodeField widget.
  FocusNode? verifyCodeFieldFocusNode;
  TextEditingController? verifyCodeFieldTextController;
  String? Function(BuildContext, String?)?
      verifyCodeFieldTextControllerValidator;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 59000;
  int timerMilliseconds = 59000;
  String timerValue = StopWatchTimer.getDisplayTime(
    59000,
    hours: false,
    minute: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Custom Action - verifyUserPhone] action in Button widget.
  CustomActionResultStruct? verifyUserPhoneResult;
  // Stores action output result for [Custom Action - updateUserPhone] action in Button widget.
  CustomActionResultStruct? updatePhoneNumberResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFieldFocusNode?.dispose();
    phoneNumberFieldTextController?.dispose();

    verifyCodeFieldFocusNode?.dispose();
    verifyCodeFieldTextController?.dispose();

    timerController.dispose();
  }
}
