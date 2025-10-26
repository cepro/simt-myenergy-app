// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class ContractSigningWidget extends StatefulWidget {
  const ContractSigningWidget(
      {super.key, this.width, this.height, required this.html});

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
