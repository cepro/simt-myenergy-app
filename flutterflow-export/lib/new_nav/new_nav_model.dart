import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'new_nav_widget.dart' show NewNavWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewNavModel extends FlutterFlowModel<NewNavWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
