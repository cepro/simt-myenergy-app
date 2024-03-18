import '/backend/schema/enums/enums.dart';
import '/components/logout_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'top_bar_logged_in_widget.dart' show TopBarLoggedInWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopBarLoggedInModel extends FlutterFlowModel<TopBarLoggedInWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for LogoutButton component.
  late LogoutButtonModel logoutButtonModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
  }

  @override
  void dispose() {
    logoutButtonModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
