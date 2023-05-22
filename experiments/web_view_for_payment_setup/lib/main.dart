// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

const String paymentSetupUrl =
    'http://127.0.0.1:8080/payment-setup.html?ceproUserId=32d6b76f-822f-48a9-ac98-4a7abddbe464';

void main() {
  WebViewPlatform.instance = WebWebViewPlatform();
  runApp(MaterialApp(
    title: 'Payments Test App',
    initialRoute: '/',
    routes: {
      '/': (context) => const _WebViewExample(),
      '/callback': (context) => const CallbackScreen(),
    },
  ));
}

class CallbackScreen extends StatelessWidget {
  const CallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Callback Screen'),
      ),
      body: Center(
        child: Text("Callback handling can be here"),
      ),
    );
  }
}

class _WebViewExample extends StatefulWidget {
  const _WebViewExample();

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<_WebViewExample> {
  final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
      LoadRequestParams(
        uri: Uri.parse(paymentSetupUrl),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        actions: <Widget>[
          _SampleMenu(_controller),
        ],
      ),
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}

enum _MenuOptions {
  doPostRequest,
}

class _SampleMenu extends StatelessWidget {
  const _SampleMenu(this.controller);

  final PlatformWebViewController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (_MenuOptions value) {
        switch (value) {
          case _MenuOptions.doPostRequest:
            _onDoPostRequest(controller);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<_MenuOptions>>[
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.doPostRequest,
          child: Text('Post Request'),
        ),
      ],
    );
  }

  Future<void> _onDoPostRequest(PlatformWebViewController controller) async {
    final LoadRequestParams params = LoadRequestParams(
      uri: Uri.parse('https://httpbin.org/post'),
      method: LoadRequestMethod.post,
      headers: const <String, String>{
        'foo': 'bar',
        'Content-Type': 'text/plain'
      },
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
    await controller.loadRequest(params);
  }
}
