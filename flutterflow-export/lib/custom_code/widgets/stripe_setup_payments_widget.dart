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

import 'dart:html';

import '/auth/supabase_auth/auth_util.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

// TODO: this will be different in dev and deployed envs
const String paymentElementURIBase =
    'https://es2mhcpqgv.eu-west-1.awsapprunner.com/payment-setup.html';

class StripeSetupPaymentsWidget extends StatefulWidget {
  const StripeSetupPaymentsWidget(
      {Key? key, this.width, this.height, this.jwtToken})
      : super(key: key);

  final double? width;
  final double? height;
  final String? jwtToken;

  @override
  StripeSetupPaymentsWidgetState createState() =>
      StripeSetupPaymentsWidgetState(jwtToken);
}

class StripeSetupPaymentsWidgetState extends State<StripeSetupPaymentsWidget> {
  late final PlatformWebViewController _controller;

  StripeSetupPaymentsWidgetState(String? jwtToken) {
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadRequest(LoadRequestParams(
        uri: Uri.parse(
            paymentElementURIBase + "?access_token=" + (jwtToken ?? ""))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}
