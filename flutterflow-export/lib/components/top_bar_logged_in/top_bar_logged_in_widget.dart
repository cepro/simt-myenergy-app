import '/backend/schema/enums/enums.dart';
import '/components/logout_button/logout_button_widget.dart';
import '/components/stop_impersonating_link_widget.dart';
import '/components/sys_info_button/sys_info_button_widget.dart';
import '/components/user_profile_button/user_profile_button_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'top_bar_logged_in_model.dart';
export 'top_bar_logged_in_model.dart';

class TopBarLoggedInWidget extends StatefulWidget {
  const TopBarLoggedInWidget({super.key});

  @override
  State<TopBarLoggedInWidget> createState() => _TopBarLoggedInWidgetState();
}

class _TopBarLoggedInWidgetState extends State<TopBarLoggedInWidget> {
  late TopBarLoggedInModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopBarLoggedInModel());

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

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ((FFAppState().esco == EscoCodeEnum.wlce) &&
                responsiveVisibility(
                  context: context,
                  tabletLandscape: false,
                  desktop: false,
                ))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/banner-wlce.png',
                    width: 174.0,
                    height: 37.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if ((FFAppState().esco == EscoCodeEnum.hmce) &&
                responsiveVisibility(
                  context: context,
                  tabletLandscape: false,
                  desktop: false,
                ))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/banner-hmce.png',
                    width: 174.0,
                    height: 37.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (((FFAppState().properties.length > 1) &&
                    !FFAppState().isCeproUser) &&
                responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ))
              Text(
                'Property: ',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
              ),
            if (((FFAppState().properties.length > 1) &&
                    !FFAppState().isCeproUser) &&
                responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ))
              FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController ??=
                    FormFieldController<String>(
                  _model.dropDownValue ??= FFAppState().property.id,
                ),
                options: List<String>.from(
                    FFAppState().properties.map((e) => e.id).toList()),
                optionLabels:
                    FFAppState().properties.map((e) => e.description).toList(),
                onChanged: (val) async {
                  safeSetState(() => _model.dropDownValue = val);
                  await action_blocks.changeProperty(
                    context,
                    propertyId: _model.dropDownValue,
                  );
                },
                width: 200.0,
                height: 40.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                    ),
                hintText: 'Select Property...',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 2.0,
                borderColor: Colors.transparent,
                borderWidth: 0.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                hidesUnderline: true,
                isOverButton: false,
                isSearchable: false,
                isMultiSelect: false,
              ),
            Spacer(),
            wrapWithModel(
              model: _model.stopImpersonatingLinkModel,
              updateCallback: () => safeSetState(() {}),
              child: StopImpersonatingLinkWidget(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    child: custom_widgets.URIIconButtonWithTooltip(
                      width: 35.0,
                      height: 35.0,
                      uri: 'tel:+44-330-828-3096',
                      tooltipText: '+44 330 828 3096',
                      icon: Icon(
                        Icons.phone,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 0.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    child: custom_widgets.URIIconButtonWithTooltip(
                      width: 35.0,
                      height: 35.0,
                      uri:
                          'mailto:${functions.supportEmail(FFAppState().esco!)}',
                      tooltipText: functions.supportEmail(FFAppState().esco!),
                      icon: Icon(
                        Icons.mail,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                if (FFAppState().isCeproUser)
                  wrapWithModel(
                    model: _model.sysInfoButtonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SysInfoButtonWidget(),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.userProfileButtonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: UserProfileButtonWidget(),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: wrapWithModel(
                      model: _model.logoutButtonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LogoutButtonWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
