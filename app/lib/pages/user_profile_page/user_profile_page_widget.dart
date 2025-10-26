import '/auth/supabase_auth/auth_util.dart';
import '/components/change_email_modal/change_email_modal_widget.dart';
import '/components/change_name_modal/change_name_modal_widget.dart';
import '/components/change_phone_number_modal/change_phone_number_modal_widget.dart';
import '/components/confirm_details_confirmation_modal/confirm_details_confirmation_modal_widget.dart';
import '/components/main_web_nav/main_web_nav_widget.dart';
import '/components/top_bar_logged_in/top_bar_logged_in_widget.dart';
import '/components/user_profile_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'user_profile_page_model.dart';
export 'user_profile_page_model.dart';

class UserProfilePageWidget extends StatefulWidget {
  const UserProfilePageWidget({super.key});

  static String routeName = 'UserProfilePage';
  static String routePath = '/profile';

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
        FFAppState().impersonationToken != ''
            ? FFAppState().impersonationToken
            : currentJwtToken,
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
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 0.0, 15.0, 100.0),
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 1024.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              wrapWithModel(
                                model: _model.topBarLoggedInModel,
                                updateCallback: () => safeSetState(() {}),
                                child: const TopBarLoggedInWidget(),
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
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 50.0,
                                              icon: Icon(
                                                Icons.arrow_back_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 30.0,
                                              ),
                                              onPressed: () async {
                                                context.safePop();
                                              },
                                            ),
                                          ),
                                          Text(
                                            'User Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMediumFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 0.0,
                                    ),
                                  ),
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const ChangeNameModalWidget(),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: wrapWithModel(
                                          model: _model.userProfileRowModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: UserProfileRowWidget(
                                            label: 'Name',
                                            value: FFAppState().customer.name,
                                            linkLabel: 'Change name',
                                            icon: const Icon(
                                              Icons.label,
                                            ),
                                            infoTooltipText:
                                                'For example \"Jack Smith\" or \"Jack and Jill Smith\". This name is used for contracting.',
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const ChangeEmailModalWidget(),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: wrapWithModel(
                                          model: _model.userProfileRowModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: UserProfileRowWidget(
                                            label: 'Email Address',
                                            value: FFAppState()
                                                            .impersonationEmail !=
                                                        ''
                                                ? FFAppState()
                                                    .impersonationEmail
                                                : currentUserEmail,
                                            linkLabel: 'Change email address',
                                            icon: const Icon(
                                              Icons.email,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const ChangePhoneNumberModalWidget(),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: wrapWithModel(
                                          model: _model.userProfileRowModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: UserProfileRowWidget(
                                            label: 'Mobile Number',
                                            value: () {
                                              if (FFAppState()
                                                          .impersonationPhone !=
                                                      '') {
                                                return '+${FFAppState().impersonationPhone}';
                                              } else if ((currentPhoneNumber !=
                                                          '') &&
                                                  (FFAppState()
                                                              .impersonationToken ==
                                                          '')) {
                                                return '+$currentPhoneNumber';
                                              } else {
                                                return '[not set]';
                                              }
                                            }(),
                                            linkLabel: 'Change mobile number',
                                            icon: const Icon(
                                              Icons.phone,
                                            ),
                                            infoTooltipText:
                                                'Adding your mobile phone number will allow you to receive notifications in the case of scheduled power outages.',
                                          ),
                                        ),
                                      ),
                                      if (_model.detailsJustConfirmed)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  70.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            'Details confirmed. Thank you!',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      if (_model.detailsConfirmedFailure)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  70.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            'Details confirmation failed. Please try again or contact support.',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumIsCustom,
                                                ),
                                          ),
                                        ),
                                      if (FFAppState()
                                              .customer
                                              .confirmedDetailsAt ==
                                          null)
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      70.0, 0.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  var shouldSetState = false;
                                                  _model.detailsConfirmedFailure =
                                                      false;
                                                  safeSetState(() {});
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              const ConfirmDetailsConfirmationModalWidget(),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() => _model
                                                              .confirmDetailsModalResponse =
                                                          value));

                                                  shouldSetState = true;
                                                  if (_model
                                                          .confirmDetailsModalResponse !=
                                                      null) {
                                                    if (_model
                                                        .confirmDetailsModalResponse!) {
                                                      _model.detailsJustConfirmed =
                                                          true;
                                                      safeSetState(() {});
                                                      if (shouldSetState) {
                                                        safeSetState(() {});
                                                      }
                                                      return;
                                                    } else {
                                                      _model.detailsConfirmedFailure =
                                                          true;
                                                      safeSetState(() {});
                                                      if (shouldSetState) {
                                                        safeSetState(() {});
                                                      }
                                                      return;
                                                    }
                                                  } else {
                                                    if (shouldSetState) {
                                                      safeSetState(() {});
                                                    }
                                                    return;
                                                  }

                                                  if (shouldSetState) {
                                                    safeSetState(() {});
                                                  }
                                                },
                                                text: 'Confirm Details',
                                                options: FFButtonOptions(
                                                  height: 40.0,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallIsCustom,
                                                          ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            AlignedTooltip(
                                              content: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'Confirm your contract details above are correct. This is a one time action to ensure your initial details are correct.',
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily,
                                                            letterSpacing: 0.0,
                                                            useGoogleFonts:
                                                                !FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeIsCustom,
                                                          ),
                                                ),
                                              ),
                                              offset: 4.0,
                                              preferredDirection:
                                                  AxisDirection.down,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 4.0,
                                              tailBaseWidth: 24.0,
                                              tailLength: 12.0,
                                              waitDuration:
                                                  const Duration(milliseconds: 100),
                                              showDuration:
                                                  const Duration(milliseconds: 1500),
                                              triggerMode:
                                                  TooltipTriggerMode.tap,
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 30.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ]
                                        .divide(const SizedBox(height: 35.0))
                                        .addToStart(const SizedBox(height: 25.0))
                                        .addToEnd(const SizedBox(height: 25.0)),
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
