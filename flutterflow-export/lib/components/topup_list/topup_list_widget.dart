import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'topup_list_model.dart';
export 'topup_list_model.dart';

class TopupListWidget extends StatefulWidget {
  const TopupListWidget({
    super.key,
    required this.topups,
  });

  final List<TopupStruct>? topups;

  @override
  State<TopupListWidget> createState() => _TopupListWidgetState();
}

class _TopupListWidgetState extends State<TopupListWidget> {
  late TopupListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopupListModel());

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
      height: widget!.topups!.length <= 5 ? 400.0 : 600.0,
      constraints: BoxConstraints(
        minHeight: 300.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                final topups = widget!.topups!.toList().take(24).toList();

                return FlutterFlowDataTable<TopupStruct>(
                  controller: _model.paginatedDataTableController,
                  data: topups,
                  columnsBuilder: (onSortChanged) => [
                    DataColumn2(
                      label: DefaultTextStyle.merge(
                        softWrap: true,
                        child: Text(
                          'Date',
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
                          'Source',
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
                          'Amount',
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
                          'Status',
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
                  dataRowBuilder:
                      (topupsItem, topupsIndex, selected, onSelectChanged) =>
                          DataRow(
                    color: MaterialStateProperty.all(
                      topupsIndex % 2 == 0
                          ? FlutterFlowTheme.of(context).secondaryBackground
                          : FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    cells: [
                      Text(
                        dateTimeFormat(
                            "dd/MM/yyyy HH:mm:ss", topupsItem.createdAt!),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: FlutterFlowTheme.of(context).bodyMedium,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        topupsItem.source,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: FlutterFlowTheme.of(context).bodyMedium,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        functions.formatGBPAmount(
                            topupsItem.amountPence.toDouble() / 100),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: FlutterFlowTheme.of(context).bodyMedium,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        topupsItem.status,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: FlutterFlowTheme.of(context).bodyMedium,
                              letterSpacing: 0.0,
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
                  addVerticalDivider: true,
                  verticalDividerColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  verticalDividerThickness: 1.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
