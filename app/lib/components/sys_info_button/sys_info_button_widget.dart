import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sys_info_button_model.dart';
export 'sys_info_button_model.dart';

class SysInfoButtonWidget extends StatefulWidget {
  const SysInfoButtonWidget({super.key});

  @override
  State<SysInfoButtonWidget> createState() => _SysInfoButtonWidgetState();
}

class _SysInfoButtonWidgetState extends State<SysInfoButtonWidget> {
  late SysInfoButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SysInfoButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
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
        fillColor: (String currentPagePath) {
          return currentPagePath.endsWith('/sysinfo');
        }('myenergy://myenergy.com${GoRouterState.of(context).uri.toString()}')
            ? FlutterFlowTheme.of(context).primaryBackground
            : FlutterFlowTheme.of(context).secondaryBackground,
        icon: Icon(
          Icons.computer,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 20.0,
        ),
        onPressed: () async {
          context.pushNamed(SysInfoPageWidget.routeName);
        },
      ),
    );
  }
}
