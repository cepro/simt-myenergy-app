import '/backend/api_requests/api_calls.dart';
import '/components/logo_container_row/logo_container_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'invite_landing_page_model.dart';
export 'invite_landing_page_model.dart';

class InviteLandingPageWidget extends StatefulWidget {
  const InviteLandingPageWidget({
    super.key,
    required this.inviteToken,
  });

  final String? inviteToken;

  static String routeName = 'InviteLandingPage';
  static String routePath = '/invite/:inviteToken';

  @override
  State<InviteLandingPageWidget> createState() =>
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

      if ((_model.inviteLookupResult?.succeeded != false)) {
        context.pushNamed(
          LoginPageWidget.routeName,
          queryParameters: {
            'emailPrefill': serializeParam(
              getJsonField(
                (_model.inviteLookupResult?.jsonBody ?? ''),
                r'''$.email''',
              ).toString(),
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SizedBox(
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
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                      child: wrapWithModel(
                        model: _model.logoContainerRowModel,
                        updateCallback: () => safeSetState(() {}),
                        child: const LogoContainerRowWidget(),
                      ),
                    ),
                    if ((_model.inviteLookupResult?.statusCode ?? 200) != 200)
                      Text(
                        'Oops seems that invite is no longer valid. Contact us to receive a fresh invite.',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyLargeIsCustom,
                            ),
                      ),
                    if (_model.inviteLookupResult == null)
                      Text(
                        'checking invite ...',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyLargeIsCustom,
                            ),
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
