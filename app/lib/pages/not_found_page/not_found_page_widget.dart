import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'not_found_page_model.dart';
export 'not_found_page_model.dart';

class NotFoundPageWidget extends StatefulWidget {
  const NotFoundPageWidget({super.key});

  static String routeName = 'NotFoundPage';
  static String routePath = '/404';

  @override
  State<NotFoundPageWidget> createState() => _NotFoundPageWidgetState();
}

class _NotFoundPageWidgetState extends State<NotFoundPageWidget> {
  late NotFoundPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotFoundPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

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
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFFF6B35),
                size: 100.0,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: Text(
                  'Page Not Found',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context).headlineMediumIsCustom,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 0.0),
                child: Text(
                  'The page you are looking for doesn\'t exist or has been moved.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.goNamed(HomePageWidget.routeName);
                  },
                  text: 'Go Home',
                  options: FFButtonOptions(
                    height: 50.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                          color: Colors.white,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                        ),
                    elevation: 3.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}