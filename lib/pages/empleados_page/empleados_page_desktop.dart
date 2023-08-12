import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import '../../models/modelos_pantallas/empleados.dart';

import 'widgets/carga_de_ticket_popup.dart';
import 'widgets/header_empleado.dart';

class EmpleadosPageDesktop extends StatefulWidget {
  const EmpleadosPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final EmpleadosProvider provider;

  @override
  State<EmpleadosPageDesktop> createState() => _EmpleadosPageDesktopState();
}

class _EmpleadosPageDesktopState extends State<EmpleadosPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(6);

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
              TopMenuWidget(
                title: currentUser!.rol.rolId == 3
                    ? 'Empleados del jefe de área'
                    : 'Empleados',
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
                            EmpleadoPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 20,
                            ),
                            widget.provider.usuarios.isEmpty
                                ? const CircularProgressIndicator()
                                : Flexible(
                                    child: PlutoGrid(
                                      key: UniqueKey(),
                                      configuration: PlutoGridConfiguration(
                                        localeText:
                                            const PlutoGridLocaleText.spanish(),
                                        scrollbar:
                                            plutoGridScrollbarConfig(context),
                                        style: plutoGridStyleConfig(context),
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
                                          field: 'id_secuencial',
                                          width: 100,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.number(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Avatar',
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
                                                    width: 50,
                                                    height: 50,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: rendererContext
                                                                .cell.value ==
                                                            null
                                                        ? Image.asset(
                                                            'assets/images/default-user-profile-picture.png',
                                                            fit: BoxFit.contain,
                                                          )
                                                        : Image.network(
                                                            rendererContext
                                                                .cell.value,
                                                            fit: BoxFit.contain,
                                                          ));
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Nombre',
                                          field: 'nombre',
                                          width: 400,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Área',
                                          field: 'nombre_area',
                                          width: 400,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Jefe Asignado',
                                          field: 'nombre_jefe_asignado',
                                          width: 400,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                          hide: currentUser!.rol.rolId != 1,
                                        ),
                                        PlutoColumn(
                                          title: 'Email',
                                          field: 'email',
                                          width: 300,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            width: 300,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              final int id =
                                                  rendererContext.cell.value;
                                              Empleados? usuario;
                                              try {
                                                usuario = widget
                                                    .provider.usuarios
                                                    .firstWhere((element) =>
                                                        element.idSecuencial ==
                                                        id);
                                              } catch (e) {
                                                usuario = null;
                                              }

                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Visibility(
                                                      visible: currentUser!
                                                                  .rol.rolId ==
                                                              3
                                                          ? true
                                                          : false,
                                                      child:
                                                          AnimatedHoverButton(
                                                        icon: Icons.money,
                                                        tooltip:
                                                            'Cargar ticket de puntos',
                                                        primaryColor:
                                                            AppTheme.of(context)
                                                                .primaryColor,
                                                        secondaryColor: AppTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        onTap: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xffd1d0d0),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                content:
                                                                    CargarTicketPopup(
                                                                  key:
                                                                      UniqueKey(),
                                                                  drawerController:
                                                                      widget
                                                                          .drawerController,
                                                                  scaffoldKey:
                                                                      widget
                                                                          .scaffoldKey,
                                                                  idRegistro: 5,
                                                                  topMenuTittle:
                                                                      "Editar encargado de Área",
                                                                  usuarioId:
                                                                      rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'perfil_usuario_id']!
                                                                          .value,
                                                                  usuarioNombre:
                                                                      rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'nombre']!
                                                                          .value,
                                                                ), // Widget personalizado
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
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
                                                    icon: Icons.person_remove,
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
                                          10,
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
                                        stateManager.sortAscending(PlutoColumn(
                                            title: '#',
                                            field: 'id_secuencial',
                                            type: PlutoColumnType.number()));
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
