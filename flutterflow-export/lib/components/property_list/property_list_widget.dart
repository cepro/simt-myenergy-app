import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'property_list_model.dart';
export 'property_list_model.dart';

class PropertyListWidget extends StatefulWidget {
  const PropertyListWidget({
    super.key,
    required this.properties,
  });

  final List<PropertyStruct>? properties;

  @override
  State<PropertyListWidget> createState() => _PropertyListWidgetState();
}

class _PropertyListWidgetState extends State<PropertyListWidget> {
  late PropertyListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyListModel());

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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(
            builder: (context) {
              final properties = widget!.properties!.toList();

              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: properties.length,
                itemBuilder: (context, propertiesIndex) {
                  final propertiesItem = properties[propertiesIndex];
                  return Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (FFAppState().isCeproUser)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 10.0, 0.0, 0.0),
                            child: Text(
                              '${propertiesItem.plot} (${propertiesItem.description})',
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
                          ),
                        if (!FFAppState().isCeproUser)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 10.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await action_blocks.changeProperty(
                                  context,
                                  propertyId: propertiesItem.id,
                                );
                              },
                              child: Text(
                                propertiesItem.description,
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleMediumFamily,
                                      letterSpacing: 0.0,
                                      decoration: TextDecoration.underline,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                              ),
                            ),
                          ),
                        if ((propertiesItem.customerRoles.length > 0) &&
                            FFAppState().isCeproUser)
                          AlignedTooltip(
                            content: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                propertiesItem.customerRoles.firstOrNull!.email,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyLargeFamily),
                                    ),
                              ),
                            ),
                            offset: 4.0,
                            preferredDirection: AxisDirection.down,
                            borderRadius: BorderRadius.circular(8.0),
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 4.0,
                            tailBaseWidth: 24.0,
                            tailLength: 12.0,
                            waitDuration: Duration(milliseconds: 100),
                            showDuration: Duration(milliseconds: 1500),
                            triggerMode: TooltipTriggerMode.tap,
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await action_blocks.impersonateCustomer(
                                      context,
                                      email: propertiesItem
                                          .customerRoles.firstOrNull?.email,
                                    );
                                  },
                                  child: Text(
                                    propertiesItem
                                        .customerRoles.firstOrNull!.role,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                              ),
                            ),
                          ),
                        if ((propertiesItem.customerRoles.length > 1) &&
                            FFAppState().isCeproUser &&
                            (propertiesItem.customerRoles.firstOrNull?.email !=
                                propertiesItem.customerRoles
                                    .elementAtOrNull(1)
                                    ?.email))
                          AlignedTooltip(
                            content: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                propertiesItem.customerRoles
                                    .elementAtOrNull(1)!
                                    .email,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyLargeFamily),
                                    ),
                              ),
                            ),
                            offset: 4.0,
                            preferredDirection: AxisDirection.down,
                            borderRadius: BorderRadius.circular(8.0),
                            backgroundColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 4.0,
                            tailBaseWidth: 24.0,
                            tailLength: 12.0,
                            waitDuration: Duration(milliseconds: 100),
                            showDuration: Duration(milliseconds: 1500),
                            triggerMode: TooltipTriggerMode.tap,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await action_blocks.impersonateCustomer(
                                    context,
                                    email: propertiesItem.customerRoles
                                        .elementAtOrNull(1)
                                        ?.email,
                                  );
                                },
                                child: Text(
                                  propertiesItem.customerRoles
                                      .elementAtOrNull(1)!
                                      .role,
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
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
