import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (_model.inviteLookupResult?.jsonBody ?? '').toString(),
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 1000));

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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if ((_model.inviteLookupResult?.statusCode ?? 200) != 200)
                Text(
                  'invite invalid',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              if (_model.inviteLookupResult == null)
                Text(
                  'checking invite ...',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
