import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/validacion_puntaje_page/widgets/hover_widgets.dart';
import 'package:dowload_page_apk/pages/validacion_puntaje_page/widgets/popup_rechazo_puntaje.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/validacion_puntaje_page/widgets/header.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';

class ValidacionPuntajePage extends StatefulWidget {
  const ValidacionPuntajePage({Key? key}) : super(key: key);

  @override
  State<ValidacionPuntajePage> createState() => _ValidacionPuntajePageState();
}

class _ValidacionPuntajePageState extends State<ValidacionPuntajePage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ValidacionPuntajeProvider provider =
          Provider.of<ValidacionPuntajeProvider>(
        context,
        listen: false,
      );
      await provider.getValidacionPuntaje();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ValidacionPuntajeProvider provider =
        Provider.of<ValidacionPuntajeProvider>(context);
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(8);

    return Scaffold(
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const TopMenuWidget(
              title: 'Validación de Puntaje',
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenuWidget(),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                      child: Column(
                        children: [
                          //HEADER
                          const PuntajeSolicitadoHeader(),
                          const SizedBox(height: 10),
                          Flexible(
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
                                  resolveDefaultColumnFilter:
                                      (column, resolver) {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  },
                                ),
                              ),
                              columns: [
                                PlutoColumn(
                                  title: 'ID',
                                  field: 'id',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.number(),
                                  renderer: (rendererContext) {
                                    return Text(
                                      rendererContext.cell.value.toString(),
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                            fontFamily: 'Gotham-Regular',
                                            useGoogleFonts: false,
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                          ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                  enableEditingMode: false,
                                  width: 90,
                                ),
                                PlutoColumn(
                                  title: 'Empleado',
                                  field: 'usuario',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  width: 250,
                                ),
                                PlutoColumn(
                                  title: 'Área',
                                  field: 'area',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  width: 150,
                                ),
                                PlutoColumn(
                                  title: 'Jefe de Área',
                                  field: 'jefe_de_area',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  width: 200,
                                ),
                                PlutoColumn(
                                  title: 'Evento',
                                  field: 'evento',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  width: 350,
                                ),
                                PlutoColumn(
                                  title: 'Fecha',
                                  field: 'fecha',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  width: 200,
                                ),
                                PlutoColumn(
                                  title: 'Puntaje',
                                  field: 'puntaje',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.number(),
                                  renderer: (rendererContext) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            AppTheme.of(context).primaryColor,
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            '${rendererContext.cell.value}',
                                            textAlign: TextAlign.center,
                                            style: AppTheme.of(context)
                                                .contenidoTablas,
                                          )),
                                    );
                                  },
                                  enableEditingMode: false,
                                  width: 150,
                                ),
                                PlutoColumn(
                                  title: 'Acciones',
                                  field: 'acciones',
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    final int ncId = rendererContext.cell.value;

                                    PuntajeSolicitado? puntajeSolicitado;

                                    try {
                                      puntajeSolicitado = provider
                                          .puntajesSolicitados
                                          .singleWhere((elem) =>
                                              elem.puntajeSolicitadoId == ncId);
                                    } catch (e) {
                                      puntajeSolicitado = null;
                                    }

                                    if (puntajeSolicitado == null) {
                                      return const SizedBox.shrink();
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        //ACEPTAR
                                        AnimatedHoverButton(
                                          icon: Icons.check,
                                          tooltip: 'Aceptar',
                                          primaryColor:
                                              AppTheme.of(context).primaryColor,
                                          secondaryColor: AppTheme.of(context)
                                              .primaryBackground,
                                          showLoading: true,
                                          onTap: () async {
                                            final res =
                                                await provider.aceptarPuntaje(
                                              puntajeSolicitado!,
                                            );
                                            if (!res) {
                                              ApiErrorHandler.callToast(
                                                'Error al aceptar puntaje',
                                              );
                                            }
                                            await provider
                                                .getValidacionPuntaje();
                                          },
                                        ),

                                        //RECHAZAR
                                        AnimatedHoverButton(
                                          icon: Icons.close,
                                          tooltip: 'Rechazar',
                                          primaryColor:
                                              AppTheme.of(context).primaryColor,
                                          secondaryColor: AppTheme.of(context)
                                              .primaryBackground,
                                          showLoading: true,
                                          onTap: () async {
                                            provider.motivosRechazo.clear();
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return PopupRechazoPuntaje(
                                                  puntajeSolicitado:
                                                      puntajeSolicitado!,
                                                );
                                              },
                                            );
                                            await provider
                                                .getValidacionPuntaje();
                                          },
                                        ),

                                        //VER
                                        HoverWidget(
                                          puntajeSolicitado: puntajeSolicitado,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                              rows: provider.rows,
                              createFooter: (stateManager) {
                                stateManager.setPageSize(
                                  10,
                                  notify: false,
                                );
                                return PlutoPagination(stateManager);
                              },
                              onLoaded: (event) {
                                provider.stateManager = event.stateManager;
                                provider.stateManager!
                                    .setShowColumnFilter(true);
                                provider.stateManager!.setSelectingMode(
                                  PlutoGridSelectingMode.row,
                                );
                              },
                              onRowChecked: (event) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
