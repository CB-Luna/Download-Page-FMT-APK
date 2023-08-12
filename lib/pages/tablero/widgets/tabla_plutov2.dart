import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/providers/tablero_provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class TablaPlutoV2 extends StatefulWidget {
  const TablaPlutoV2({Key? key}) : super(key: key);

  @override
  State<TablaPlutoV2> createState() => _TablaPlutoV2State();
}

class _TablaPlutoV2State extends State<TablaPlutoV2> {
  @override
  Widget build(BuildContext context) {
    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);
    return Material(
      color: AppTheme.of(context).primaryBackground,
      child: providertablero.listcompras.isEmpty
          ? SpinKitFadingCircle(
              color: AppTheme.of(context).primaryColor,
              size: 80,
            )
          : SizedBox(
              child: PlutoGrid(
                key: UniqueKey(),
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.spanish(),
                  style: plutoGridStyleConfig(context),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
                columns: [
                  PlutoColumn(
                    title: 'Id Ticket',
                    field: 'idTicket',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.count,
                        alignment: Alignment.center,
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                                text: 'Total:',
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                        fontFamily: 'Gotham-Light',
                                        useGoogleFonts: false,
                                        color:
                                            AppTheme.of(context).primaryColor)),
                          ];
                        },
                      );
                    },
                  ),
                  PlutoColumn(
                    title: 'Id Producto',
                    field: 'idProducto',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.count,
                        alignment: Alignment.center,
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                              text: text,
                              style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                      fontFamily: 'Gotham-Light',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryColor),
                            ),
                          ];
                        },
                      );
                    },
                  ),
                  PlutoColumn(
                    title: 'Descripción',
                    field: 'descripcion',
                    width: 540,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: 'Costo',
                    field: 'costo',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                    renderer: (rendererContext) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.of(context).tertiaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            '${(rendererContext.cell.value)} ',
                            style: AppTheme.of(context)
                                .contenidoTablas
                                .override(
                                    useGoogleFonts: false,
                                    fontFamily: 'Gotham-Light',
                                    color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.sum,
                        alignment: Alignment.center,
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                              text: text,
                              style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                      fontFamily: 'Gotham-Light',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryColor),
                            ),
                          ];
                        },
                      );
                    },
                  ),
                  PlutoColumn(
                    title: 'Fecha',
                    field: 'fecha',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.count,
                        alignment: Alignment.center,
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                                text: dateFormat(providertablero
                                    .listcompras[
                                        providertablero.listcompras.length - 1]
                                    .fecha),
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                        fontFamily: 'Gotham-Light',
                                        useGoogleFonts: false,
                                        color:
                                            AppTheme.of(context).primaryColor)),
                          ];
                        },
                      );
                    },
                  ),
                ],
                rows: providertablero.rowsv2,
                /* createFooter: (stateManager) {
                  stateManager.setPageSize(
                    10,
                    notify: false,
                  ); // default 40
                  for (var i = 0; i < stateManager.totalPage; i++) {
                    providertablero.pageChecked.add(false);
                  }
                  return PlutoPagination(stateManager);
                },
               */
                onLoaded: (event) {
                  providertablero.stateManager = event.stateManager;
                  providertablero.stateManager!.setSelectingMode(
                    PlutoGridSelectingMode.row,
                  );
                },
                onRowChecked: (event) {},
              ),
            ),
    );
  }
}
