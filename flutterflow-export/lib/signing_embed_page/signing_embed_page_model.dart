import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'signing_embed_page_widget.dart' show SigningEmbedPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SigningEmbedPageModel extends FlutterFlowModel<SigningEmbedPageWidget> {
  ///  Local state fields for this page.

  String? contractSigningEmbedHTML =
      '<html><head></head><body><div>Loading ...</div></body></html>';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Contract Signing Embed)] action in SigningEmbedPage widget.
  ApiCallResponse? contractSigningEmbedResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
