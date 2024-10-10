import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/change_phone_number_modal/change_phone_number_modal_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_profile_page_model.dart';
export 'user_profile_page_model.dart';

class UserProfilePageWidget extends StatefulWidget {
  const UserProfilePageWidget({super.key});

  @override
  State<UserProfilePageWidget> createState() => _UserProfilePageWidgetState();
}

class _UserProfilePageWidgetState extends State<UserProfilePageWidget> {
  late UserProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfilePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.decodeTokenForProfileResponse = await actions.decodeSupabaseJwt(
        FFAppState().impersonationToken != null &&
                FFAppState().impersonationToken != ''
            ? FFAppState().impersonationToken
            : currentJwtToken!,
      );
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
      onTap: () => FocusScope.of(context).unfocus(),
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
                model: _model.mainWebNavModel,
                updateCallback: () => safeSetState(() {}),
                child: MainWebNavWidget(
                  navOne: FlutterFlowTheme.of(context).secondaryText,
                  navTwo: FlutterFlowTheme.of(context).alternate,
                  navThree: FlutterFlowTheme.of(context).secondaryText,
                  navFour: FlutterFlowTheme.of(context).secondaryText,
                  navFive: FlutterFlowTheme.of(context).secondaryText,
                  navSix: FlutterFlowTheme.of(context).secondaryText,
                ),
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
                              wrapWithModel(
                                model: _model.topBarLoggedInModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TopBarLoggedInWidget(),
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: Text(
                                        'User Profile',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(FlutterFlowTheme
                                                          .of(context)
                                                      .headlineMediumFamily),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .lineColor,
                                      width: 0.0,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 20.0, 0.0, 20.0),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.label,
                                                size: 30.0,
                                              ),
                                              title: Text(
                                                'Name',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily),
                                                        ),
                                              ),
                                              subtitle: Text(
                                                FFAppState().customer.name,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                        ),
                                              ),
                                              trailing: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              tileColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              dense: false,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 20.0),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.email,
                                                size: 30.0,
                                              ),
                                              title: Text(
                                                'Change Email Address',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily),
                                                        ),
                                              ),
                                              subtitle: Text(
                                                FFAppState().impersonationToken !=
                                                            null &&
                                                        FFAppState()
                                                                .impersonationToken !=
                                                            ''
                                                    ? FFAppState()
                                                        .impersonationEmail
                                                    : currentUserEmail,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                        ),
                                              ),
                                              trailing: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              tileColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              dense: false,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 20.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child:
                                                            ChangePhoneNumberModalWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));
                                              },
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.phone,
                                                  size: 30.0,
                                                ),
                                                title: Text(
                                                  'Change Phone Number',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMediumFamily),
                                                      ),
                                                ),
                                                subtitle: Text(
                                                  currentPhoneNumber,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMediumFamily),
                                                      ),
                                                ),
                                                trailing: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24.0,
                                                ),
                                                tileColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                dense: false,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(12.0, 0.0,
                                                            12.0, 0.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (FFAppState()
                                              .customer
                                              .confirmedDetailsAt ==
                                          null)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              var _shouldSetState = false;
                                              _model.customerDetailsConfirmedResponse =
                                                  await CustomerDetailsConfirmedCall
                                                      .call(
                                                bearerToken: currentJwtToken,
                                              );

                                              _shouldSetState = true;
                                              if ((_model
                                                      .customerDetailsConfirmedResponse
                                                      ?.succeeded ??
                                                  true)) {
                                                FFAppState()
                                                    .updateCustomerStruct(
                                                  (e) => e
                                                    ..confirmedDetailsAt =
                                                        functions.nowDateTime(),
                                                );
                                                safeSetState(() {});
                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Failed to confirm details.  Please try again or report to support.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }

                                              if (_shouldSetState)
                                                safeSetState(() {});
                                            },
                                            text: 'Confirm Details',
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                      ),
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
