import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/functions/money_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/providers/tablero_provider.dart';
import 'package:dowload_page_apk/providers/visual_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class TablaPluto extends StatefulWidget {
  const TablaPluto({Key? key}) : super(key: key);

  @override
  State<TablaPluto> createState() => _TablaPlutoState();
}

class _TablaPlutoState extends State<TablaPluto> {
  @override
  Widget build(BuildContext context) {
    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);
    return Material(
      color: AppTheme.of(context).primaryBackground,
      child: providertablero.listapevento.isEmpty
          ? SpinKitFadingCircle(
              color: AppTheme.of(context).primaryColor,
              size: 80,
            )
          : SizedBox(
              child: PlutoGrid(
                key: UniqueKey(),
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.spanish(),
                  scrollbar: plutoGridScrollbarConfig(context),
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
                    title: 'Evento',
                    field: 'nombre',
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
                                text: providertablero
                                    .listapevento[
                                        providertablero.listapevento.length - 1]
                                    .nombre
                                    .toString(),
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
                    title: 'ID Evento',
                    field: 'evento',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.count,
                        alignment: Alignment.center,
                        titleSpanBuilder: (text) {
                          return [
                            TextSpan(
                                text: providertablero
                                    .listapevento[
                                        providertablero.listapevento.length - 1]
                                    .idEvento
                                    .toString(),
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
                    enableEditingMode: false,
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
                    title: 'Puntos',
                    field: 'puntos',
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.currency(),
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
                    enableEditingMode: false,
                    footerRenderer: (rendererContext) {
                      return PlutoAggregateColumnFooter(
                        rendererContext: rendererContext,
                        type: PlutoAggregateColumnType.sum,
                        format: '#,###.##',
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
                                        color:
                                            AppTheme.of(context).primaryColor)),
                          ];
                        },
                      );
                    },
                  ),
                  PlutoColumn(
                    title: 'Fecha Evento',
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
                                    .listapevento[
                                        providertablero.listapevento.length - 1]
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
                rows: providertablero.rows,
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
