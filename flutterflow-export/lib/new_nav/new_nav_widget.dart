import '/components/main_web_nav/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_nav_model.dart';
export 'new_nav_model.dart';

class NewNavWidget extends StatefulWidget {
  const NewNavWidget({super.key});

  @override
  State<NewNavWidget> createState() => _NewNavWidgetState();
}

class _NewNavWidgetState extends State<NewNavWidget> {
  late NewNavModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewNavModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
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
                  updateCallback: () => setState(() {}),
                  child: MainWebNavWidget(),
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 500.0,
                        constraints: BoxConstraints(
                          maxWidth: 500.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'START START START',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,, LoremIpsum ,,,  \n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,\n\nLoremIpsum ,,,',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'END END END',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
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
    );
  }
}
