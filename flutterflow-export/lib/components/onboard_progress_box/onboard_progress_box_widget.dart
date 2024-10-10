import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'onboard_progress_box_model.dart';
export 'onboard_progress_box_model.dart';

class OnboardProgressBoxWidget extends StatefulWidget {
  const OnboardProgressBoxWidget({super.key});

  @override
  State<OnboardProgressBoxWidget> createState() =>
      _OnboardProgressBoxWidgetState();
}

class _OnboardProgressBoxWidgetState extends State<OnboardProgressBoxWidget> {
  late OnboardProgressBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardProgressBoxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Onboarding Progress',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .headlineMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .headlineMediumFamily),
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          child: Checkbox(
                            value: _model.inviteAcceptedCheckboxValue ??= true,
                            onChanged: (newValue) async {
                              safeSetState(() => _model
                                  .inviteAcceptedCheckboxValue = newValue!);

                              if (!newValue!) {
                                safeSetState(() {
                                  _model.inviteAcceptedCheckboxValue = true;
                                });
                              }
                            },
                            side: BorderSide(
                              width: 2,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor:
                                FlutterFlowTheme.of(context).primaryBtnText,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Invite Accepted',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          child: Checkbox(
                            value: _model.supplyContractSignedCheckboxValue ??=
                                FFAppState().supplyContractSigned,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.supplyContractSignedCheckboxValue =
                                      newValue!);
                              if (newValue!) {
                                // ReadonlySupplyContractCheckNeutraliseToggleOn
                                safeSetState(() {
                                  _model.supplyContractSignedCheckboxValue =
                                      !_model
                                          .supplyContractSignedCheckboxValue!;
                                });
                              } else {
                                // ReadonlySupplyContractCheckNeutraliseToggleOff
                                safeSetState(() {
                                  _model.supplyContractSignedCheckboxValue =
                                      !_model
                                          .supplyContractSignedCheckboxValue!;
                                });
                              }
                            },
                            side: BorderSide(
                              width: 2,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor:
                                FlutterFlowTheme.of(context).primaryBtnText,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Supply Contract Signed',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                              ),
                              Text(
                                'Go to contract',
                                textAlign: TextAlign.start,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          child: Checkbox(
                            value:
                                _model.profileDetailsConfirmedCheckboxValue ??=
                                    FFAppState().customer.confirmedDetailsAt !=
                                        null,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.profileDetailsConfirmedCheckboxValue =
                                      newValue!);
                              if (newValue!) {
                                // ReadonlyProfileConfirmedCheckNeutraliseToggleOn
                                safeSetState(() {
                                  _model.profileDetailsConfirmedCheckboxValue =
                                      !_model
                                          .profileDetailsConfirmedCheckboxValue!;
                                });
                              } else {
                                // ReadonlyProfileConfirmedCheckNeutraliseToggleOff
                                safeSetState(() {
                                  _model.profileDetailsConfirmedCheckboxValue =
                                      !_model
                                          .profileDetailsConfirmedCheckboxValue!;
                                });
                              }
                            },
                            side: BorderSide(
                              width: 2,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor:
                                FlutterFlowTheme.of(context).primaryBtnText,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile Details Confirmed',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('UserProfilePage');
                                },
                                child: Text(
                                  'Go to profile',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        decoration: TextDecoration.underline,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
