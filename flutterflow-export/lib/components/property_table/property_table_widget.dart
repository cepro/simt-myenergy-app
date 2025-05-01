import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'property_table_model.dart';
export 'property_table_model.dart';

class PropertyTableWidget extends StatefulWidget {
  const PropertyTableWidget({
    super.key,
    required this.properties,
  });

  final List<PropertyStruct>? properties;

  @override
  State<PropertyTableWidget> createState() => _PropertyTableWidgetState();
}

class _PropertyTableWidgetState extends State<PropertyTableWidget> {
  late PropertyTableModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PropertyTableModel());

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
      height: 650.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_model.loadingImpersonation)
            Expanded(
              child: Builder(
                builder: (context) {
                  final properties = widget!.properties!.toList();

                  return FlutterFlowDataTable<PropertyStruct>(
                    controller: _model.paginatedDataTableController,
                    data: properties,
                    columnsBuilder: (onSortChanged) => [
                      DataColumn2(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: Text(
                            'Plot',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: FlutterFlowTheme.of(context).labelLarge,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        fixedWidth: 100.0,
                      ),
                      DataColumn2(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: Text(
                            'Address',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: FlutterFlowTheme.of(context).labelLarge,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: Text(
                            'Owner',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: FlutterFlowTheme.of(context).labelLarge,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      DataColumn2(
                        label: DefaultTextStyle.merge(
                          softWrap: true,
                          child: Text(
                            'Occupier',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: FlutterFlowTheme.of(context).labelLarge,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ],
                    dataRowBuilder: (propertiesItem, propertiesIndex, selected,
                            onSelectChanged) =>
                        DataRow(
                      color: MaterialStateProperty.all(
                        propertiesIndex % 2 == 0
                            ? FlutterFlowTheme.of(context).secondaryBackground
                            : FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      cells: [
                        Text(
                          propertiesItem.plot,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: FlutterFlowTheme.of(context).bodyMedium,
                                letterSpacing: 0.0,
                              ),
                        ),
                        Text(
                          propertiesItem.description,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: FlutterFlowTheme.of(context).bodyMedium,
                                letterSpacing: 0.0,
                              ),
                        ),
                        Visibility(
                          visible: propertiesItem.ownerEmail != null &&
                              propertiesItem.ownerEmail != '',
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var _shouldSetState = false;
                              _model.impersonateResult =
                                  await action_blocks.impersonateCustomer(
                                context,
                                email: propertiesItem.ownerEmail,
                              );
                              _shouldSetState = true;
                              if (FFAppState().properties.length > 1) {
                                context.pushNamed(
                                    PropertySelectionPageWidget.routeName);

                                if (_shouldSetState) safeSetState(() {});
                                return;
                              } else {
                                await action_blocks.changeProperty(
                                  context,
                                  propertyId:
                                      FFAppState().properties.firstOrNull?.id,
                                );
                                if (_shouldSetState) safeSetState(() {});
                                return;
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                            child: Text(
                              propertiesItem.ownerEmail,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    letterSpacing: 0.0,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (propertiesItem.customerRoles.length > 1) &&
                              (propertiesItem.customerRoles
                                      .elementAtOrNull(1)
                                      ?.role ==
                                  'occupier') &&
                              (propertiesItem
                                      .customerRoles.firstOrNull?.email !=
                                  propertiesItem.customerRoles
                                      .elementAtOrNull(1)
                                      ?.email),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await action_blocks.impersonateCustomer(
                                context,
                                email: valueOrDefault<String>(
                                  propertiesItem.customerRoles
                                      .elementAtOrNull(1)
                                      ?.email,
                                  'unknown',
                                ),
                              );
                              if (FFAppState().properties.length > 1) {
                                context.pushNamed(
                                    PropertySelectionPageWidget.routeName);

                                return;
                              } else {
                                await action_blocks.changeProperty(
                                  context,
                                  propertyId:
                                      FFAppState().properties.firstOrNull?.id,
                                );
                                return;
                              }
                            },
                            child: Text(
                              valueOrDefault<String>(
                                propertiesItem.customerRoles
                                    .elementAtOrNull(1)
                                    ?.email,
                                'unknown',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    letterSpacing: 0.0,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                      ].map((c) => DataCell(c)).toList(),
                    ),
                    paginated: true,
                    selectable: false,
                    hidePaginator: false,
                    showFirstLastButtons: false,
                    headingRowHeight: 56.0,
                    dataRowHeight: 48.0,
                    columnSpacing: 20.0,
                    headingRowColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(8.0),
                    addHorizontalDivider: true,
                    addTopAndBottomDivider: false,
                    hideDefaultHorizontalDivider: true,
                    horizontalDividerColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    horizontalDividerThickness: 1.0,
                    addVerticalDivider: false,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
