import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import '../../helpers/globals.dart';
import '../../models/modelos_pantallas/eventos_tabla.dart';
import 'widgets/header_eventos.dart';

class EventosPageDesktop extends StatefulWidget {
  const EventosPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final EventosProvider provider;

  @override
  State<EventosPageDesktop> createState() => _EventosPageDesktopState();
}

class _EventosPageDesktopState extends State<EventosPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(9);

    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const TopMenuWidget(
                title: 'Eventos',
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideMenuWidget(),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            //HEADER
                            const SizedBox(
                              height: 20,
                            ),
                            EventosPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 20,
                            ),
                            widget.provider.evento.isEmpty
                                ? const CircularProgressIndicator()
                                : Flexible(
                                    child: PlutoGrid(
                                      key: UniqueKey(),
                                      configuration: PlutoGridConfiguration(
                                        localeText:
                                            const PlutoGridLocaleText.spanish(),
                                        scrollbar:
                                            plutoGridScrollbarConfig(context),
                                        style: AppTheme.themeMode ==
                                                ThemeMode.light
                                            ? PlutoGridStyleConfig(
                                                rowHeight: 120,
                                                cellTextStyle:
                                                    AppTheme.of(context)
                                                        .contenidoTablas,
                                                columnTextStyle:
                                                    AppTheme.of(context)
                                                        .contenidoTablas,
                                                enableCellBorderVertical: false,
                                                borderColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                checkedColor: AppTheme
                                                            .themeMode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFFC7EDDD)
                                                    : const Color(0XFF4B4B4B),
                                                enableRowColorAnimation: true,
                                                iconColor: AppTheme.of(context)
                                                    .primaryColor,
                                                gridBackgroundColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                rowColor: AppTheme.of(context)
                                                    .primaryBackground,
                                                menuBackgroundColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                activatedColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                              )
                                            : PlutoGridStyleConfig.dark(
                                                rowHeight: 120,
                                                cellTextStyle:
                                                    AppTheme.of(context)
                                                        .contenidoTablas,
                                                columnTextStyle:
                                                    AppTheme.of(context)
                                                        .contenidoTablas,
                                                enableCellBorderVertical: false,
                                                borderColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                checkedColor: AppTheme
                                                            .themeMode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFFC7EDDD)
                                                    : const Color(0XFF4B4B4B),
                                                enableRowColorAnimation: true,
                                                iconColor: AppTheme.of(context)
                                                    .primaryColor,
                                                gridBackgroundColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                rowColor: AppTheme.of(context)
                                                    .primaryBackground,
                                                menuBackgroundColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                                activatedColor:
                                                    AppTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                        columnFilter:
                                            PlutoGridColumnFilterConfig(
                                          filters: const [
                                            ...FilterHelper.defaultFilters,
                                          ],
                                          resolveDefaultColumnFilter:
                                              (column, resolver) {
                                            return resolver<
                                                    PlutoFilterTypeContains>()
                                                as PlutoFilterType;
                                          },
                                        ),
                                      ),
                                      columns: [
                                        PlutoColumn(
                                          title: '#',
                                          field: 'evento_id',
                                          width: 100,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.number(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Imagen',
                                          field: 'imagen',
                                          width: 150,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                          renderer: (rendererContext) {
                                            return // ver imagen
                                                Container(
                                              width: 100,
                                              height: 100,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.network(
                                                rendererContext.cell.value,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Nombre',
                                          field: 'nombre',
                                          width: 300,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Descripción',
                                          field: 'descripcion',
                                          width: 500,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.right,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                          renderer: (rendererContext) {
                                            return Text(
                                              rendererContext.cell.value,
                                              style: TextStyle(
                                                color: AppTheme.of(context)
                                                    .primaryText,
                                                fontSize: 16,
                                              ),
                                              maxLines:
                                                  3, // Añadir aquí el número máximo de líneas deseadas
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Puntos',
                                          field: 'puntaje_asistencia',
                                          width: 200,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.number(),
                                          enableEditingMode: false,
                                          renderer: (rendererContext) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppTheme.of(context)
                                                      .primaryColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                child: Text(
                                                  '${(rendererContext.cell.value)} ',
                                                  style: AppTheme.of(context)
                                                      .contenidoTablas
                                                      .override(
                                                          useGoogleFonts: false,
                                                          fontFamily:
                                                              'Gotham-Light',
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Fecha',
                                          field: 'fecha',
                                          width: 250,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                          renderer: (rendererContext) => Text(
                                            rendererContext.cell.value,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            width: 200,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              final int id =
                                                  rendererContext.cell.value;
                                              EventoTabla? usuario;
                                              try {
                                                usuario = widget.provider.evento
                                                    .firstWhere((element) =>
                                                        element.id == id);
                                              } catch (e) {
                                                usuario = null;
                                              }

                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AnimatedHoverButton(
                                                      icon: Icons.edit,
                                                      tooltip:
                                                          'Editar perfil empleado',
                                                      primaryColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      secondaryColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      onTap: () async {},
                                                    ),
                                                  ),
                                                  AnimatedHoverButton(
                                                    icon: Icons.delete,
                                                    tooltip: 'Eliminar',
                                                    primaryColor: Colors.red,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    onTap: () async {},
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                      rows: widget.provider.rows,
                                      createFooter: (stateManager) {
                                        stateManager.setPageSize(
                                          5,
                                          notify: false,
                                        );

                                        return PlutoPagination(stateManager);
                                      },
                                      onLoaded: (event) {
                                        widget.provider.stateManager =
                                            event.stateManager;

                                        stateManager = event.stateManager;

                                        stateManager.setShowColumnFilter(true);
                                        stateManager.setSelectingMode(
                                          PlutoGridSelectingMode.row,
                                        );
                                      },
                                      onRowChecked: (event) {},
                                    ),
                                  ),
                            const SizedBox(height: 20),
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
      ),
    );
  }
}
