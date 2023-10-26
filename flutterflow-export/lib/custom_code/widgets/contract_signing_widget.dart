// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class ContractSigningWidget extends StatefulWidget {
  const ContractSigningWidget(
      {Key? key, this.width, this.height, required this.html})
      : super(key: key);

  final double? height;
  final double? width;
  final String html;

  @override
  _ContractSigningWebViewWidgetState createState() =>
      _ContractSigningWebViewWidgetState();
}

class _ContractSigningWebViewWidgetState extends State<ContractSigningWidget> {
  late final PlatformWebViewController _controller;

  _ContractSigningWebViewWidgetState() {
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.loadHtmlString(widget.html);
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context);
  }
}
