import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'signing_embed_page_model.dart';
export 'signing_embed_page_model.dart';

class SigningEmbedPageWidget extends StatefulWidget {
  const SigningEmbedPageWidget({
    Key? key,
    required this.contractId,
    this.termsSubtype,
  }) : super(key: key);

  final String? contractId;
  final String? termsSubtype;

  @override
  _SigningEmbedPageWidgetState createState() => _SigningEmbedPageWidgetState();
}

class _SigningEmbedPageWidgetState extends State<SigningEmbedPageWidget> {
  late SigningEmbedPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SigningEmbedPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.contractSigningEmbedResponse = await ContractSigningEmbedCall.call(
        bearerToken: currentJwtToken,
        id: widget.contractId,
        termsSubtype: widget.termsSubtype,
      );
      if ((_model.contractSigningEmbedResponse?.succeeded ?? true)) {
        setState(() {
          _model.contractSigningEmbedHTML =
              (_model.contractSigningEmbedResponse?.bodyText ?? '');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed:${(_model.contractSigningEmbedResponse?.bodyText ?? '')}',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: custom_widgets.ContractSigningWidget(
              width: double.infinity,
              height: double.infinity,
              html: _model.contractSigningEmbedHTML!,
            ),
          ),
        ),
      ),
    );
  }
}
