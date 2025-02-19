import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/property_list/property_list_widget.dart';
import '/components/sidebar_no_menu/sidebar_no_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'property_selection_page_model.dart';
export 'property_selection_page_model.dart';

class PropertySelectionPageWidget extends StatefulWidget {
  const PropertySelectionPageWidget({super.key});

  @override
  State<PropertySelectionPageWidget> createState() =>
      _PropertySelectionPageWidgetState();
}

class _PropertySelectionPageWidgetState
    extends State<PropertySelectionPageWidget> {
  late PropertySelectionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertySelectionPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loadHistoryFailure = false;
      _model.loadingHistory = true;
      safeSetState(() {});
      _model.userToken = await actions.activeUserToken();
      _model.getTopupsOutput = await GetTopupsCall.call(
        bearerToken: _model.userToken,
      );

      _model.loadingHistory = false;
      safeSetState(() {});
      if ((_model.getTopupsOutput?.succeeded ?? true)) {
        _model.topupsTyped = await actions.topupsJSONToTopupsDataType(
          (_model.getTopupsOutput?.jsonBody ?? ''),
        );
        _model.topups = _model.topupsTyped!.toList().cast<TopupStruct>();
        safeSetState(() {});
        return;
      } else {
        await action_blocks.handleMyEnergyApiCallFailure(
          context,
          wwwAuthenticateHeader:
              (_model.getTopupsOutput?.getHeader('www-authenticate') ?? ''),
          httpStatusCode: (_model.getTopupsOutput?.statusCode ?? 200),
        );
        _model.loadHistoryFailure = true;
        safeSetState(() {});
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.sidebarNoMenuModel,
                updateCallback: () => safeSetState(() {}),
                child: SidebarNoMenuWidget(),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 0.0, 15.0, 100.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 1024.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 24.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Properties',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmallFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmallFamily),
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          wrapWithModel(
                                            model: _model.logoutButtonModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: LogoutButtonWidget(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                              ))
                                Divider(
                                  height: 44.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                              if (responsiveVisibility(
                                context: context,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Divider(
                                  height: 24.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).lineColor,
                                ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'Choose a property to view:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.propertyListModel,
                                updateCallback: () => safeSetState(() {}),
                                child: PropertyListWidget(
                                  properties: FFAppState().properties,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
