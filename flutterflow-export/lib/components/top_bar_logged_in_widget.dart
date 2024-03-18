import '/backend/schema/enums/enums.dart';
import '/components/logout_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
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

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
            if ((FFAppState().site == SiteCodeEnum.wlce) &&
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
            if ((FFAppState().site == SiteCodeEnum.hmce) &&
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
            Spacer(),
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
                      uri: 'tel:+44-117-205-4840',
                      tooltipText: '+44 117 205 4840',
                      icon: Icon(
                        Icons.phone,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    child: custom_widgets.URIIconButtonWithTooltip(
                      width: 35.0,
                      height: 35.0,
                      uri: 'mailto:hello@waterlilies.energy',
                      tooltipText: 'hello@waterlilies.energy',
                      icon: Icon(
                        Icons.mail,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: wrapWithModel(
                      model: _model.logoutButtonModel,
                      updateCallback: () => setState(() {}),
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
