import '/components/logout_button/logout_button_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'display_remote_image_widget.dart' show DisplayRemoteImageWidget;
import 'package:flutter/material.dart';

class DisplayRemoteImageModel
    extends FlutterFlowModel<DisplayRemoteImageWidget> {
  ///  Local state fields for this page.

  String? currentImageUrl;

  ///  State fields for stateful widgets in this page.

  // Model for mainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Model for logoutButton component.
  late LogoutButtonModel logoutButtonModel;

  @override
  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    logoutButtonModel = createModel(context, () => LogoutButtonModel());
  }

  @override
  void dispose() {
    mainWebNavModel.dispose();
    logoutButtonModel.dispose();
  }
}
