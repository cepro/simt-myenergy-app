import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'user_profile_button_model.dart';
export 'user_profile_button_model.dart';

class UserProfileButtonWidget extends StatefulWidget {
  const UserProfileButtonWidget({super.key});

  @override
  State<UserProfileButtonWidget> createState() =>
      _UserProfileButtonWidgetState();
}

class _UserProfileButtonWidgetState extends State<UserProfileButtonWidget> {
  late UserProfileButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfileButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentPagePath;
    try {
      currentPagePath = 'myenergy://myenergy.com${GoRouterState.of(context).uri.toString()}';
    } catch (e) {
      currentPagePath = '';  // Fallback: assume not on profile page
    }

    return Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: FlutterFlowIconButton(
        borderColor: FlutterFlowTheme.of(context).lineColor,
        borderRadius: 12.0,
        borderWidth: 1.0,
        fillColor: (String path) {
          return path.endsWith('/profile');
        }(currentPagePath)
            ? FlutterFlowTheme.of(context).primaryBackground
            : FlutterFlowTheme.of(context).secondaryBackground,
        icon: Icon(
          Icons.account_circle,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 20.0,
        ),
        onPressed: () async {
          context.pushNamed(UserProfilePageWidget.routeName);
        },
      ),
    );
  }
}
