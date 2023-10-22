import '/backend/api_requests/api_calls.dart';
import '/components/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'invite_landing_page_model.dart';
export 'invite_landing_page_model.dart';

class InviteLandingPageWidget extends StatefulWidget {
  const InviteLandingPageWidget({
    Key? key,
    required this.inviteToken,
  }) : super(key: key);

  final String? inviteToken;

  @override
  _InviteLandingPageWidgetState createState() =>
      _InviteLandingPageWidgetState();
}

class _InviteLandingPageWidgetState extends State<InviteLandingPageWidget> {
  late InviteLandingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InviteLandingPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.inviteLookupResult = await CustomerInviteLookupCall.call(
        inviteToken: widget.inviteToken,
      );
      if ((_model.inviteLookupResult?.succeeded ?? true)) {
        context.pushNamed(
          'loginPage',
          queryParameters: {
            'emailPrefill': serializeParam(
              getJsonField(
                (_model.inviteLookupResult?.jsonBody ?? ''),
                r'''$.email''',
              ).toString().toString(),
              ParamType.String,
            ),
            'fromInvite': serializeParam(
              true,
              ParamType.bool,
            ),
          }.withoutNulls,
        );
      } else {
        return;
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
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

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
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                      child: wrapWithModel(
                        model: _model.logoContainerRowModel,
                        updateCallback: () => setState(() {}),
                        child: LogoContainerRowWidget(),
                      ),
                    ),
                    if ((_model.inviteLookupResult?.statusCode ?? 200) != 200)
                      Text(
                        'Oops seems that invite is no longer valid. Contact us to receive a fresh invite.',
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                    if (_model.inviteLookupResult == null)
                      Text(
                        'checking invite ...',
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
