import 'package:dowload_page_apk/functions/phone_format.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';

import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import '../widgets/custom_appbar/custom_appbar.dart';
import '../widgets/drawer/drawer.dart';
import 'widgets/popup_transferencia.dart';
import 'widgets/header_jefe_area.dart';
import 'widgets/tarjeta_jefe_area.dart';

class GestionJefesAreaPageTablet extends StatefulWidget {
  const GestionJefesAreaPageTablet(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final JefesAreaProvider provider;

  @override
  State<GestionJefesAreaPageTablet> createState() =>
      _GestionJefesAreaPageTabletState();
}

class _GestionJefesAreaPageTabletState
    extends State<GestionJefesAreaPageTablet> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(2);

    return MiAdvancedDrawer(
      scaffoldKey: widget.scaffoldKey,
      drawerController: widget.drawerController,
      appBar: CustomAppBar(
          key: UniqueKey(),
          titleSize: 0.03,
          title: 'Jefes de área',
          drawerController: widget.drawerController),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            JefeAreaPageHeader(),
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
                                        style: PlutoGridStyleConfig(
                                          rowHeight: 170,
                                          enableCellBorderVertical: true,
                                          enableGridBorderShadow: true,
                                          cellTextStyle: AppTheme.of(context)
                                              .contenidoTablas,
                                          columnTextStyle: AppTheme.of(context)
                                              .contenidoTablas,
                                          gridBorderRadius:
                                              BorderRadius.circular(10),
                                          gridPopupBorderRadius:
                                              BorderRadius.circular(10),
                                          evenRowColor: const Color.fromARGB(
                                              255, 239, 239, 239),
                                          oddRowColor: const Color.fromARGB(
                                              255, 223, 223, 223),
                                          gridBorderColor:
                                              const Color(0xffd1d0d0),
                                          borderColor: const Color(0xffd1d0d0),
                                          activatedColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          enableRowColorAnimation: true,
                                          iconColor:
                                              AppTheme.of(context).primaryColor,
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
                                          title: 'Información del Jefe de área',
                                          field: 'nombre',
                                          width: 550,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          readOnly: true,
                                          enableEditingMode: false,
                                          backgroundColor: const Color.fromARGB(
                                              255, 238, 238, 238),
                                          renderer: (rendererContext) {
                                            //change text color to red
                                            return TarjetaJefeArea(
                                              perfilUsuarioId: rendererContext
                                                  .cell
                                                  .row
                                                  .cells['perfil_usuario_id']!
                                                  .value
                                                  .toString(),
                                              idUsuario: rendererContext
                                                  .cell
                                                  .row
                                                  .cells[
                                                      'id_usuario_secuencial']!
                                                  .value
                                                  .toString(),
                                              avatarUrl: rendererContext.cell
                                                  .row.cells['avatar']!.value,
                                              nombre: rendererContext.cell.row
                                                  .cells['nombre']!.value,
                                              email: rendererContext.cell.row
                                                  .cells['email']!.value,
                                              telefono: formatPhone(
                                                  rendererContext
                                                      .cell
                                                      .row
                                                      .cells['telefono']!
                                                      .value),
                                              nombreArea: rendererContext
                                                  .cell
                                                  .row
                                                  .cells['nombre_area']!
                                                  .value,
                                              cantidadEmpleados: rendererContext
                                                  .cell
                                                  .row
                                                  .cells['cant_empleados']!
                                                  .value,
                                              laborando: rendererContext
                                                  .cell
                                                  .row
                                                  .cells['laborando']!
                                                  .value,
                                              provider: widget.provider,
                                              habilitado: rendererContext
                                                  .cell
                                                  .row
                                                  .cells['app_habilitada']!
                                                  .value,
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            width: 230,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 238, 238, 238),
                                            renderer: (rendererContext) {
                                              final int id =
                                                  rendererContext.cell.value;
                                              JefeArea? usuario;
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
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 45,
                                                        height: 45,
                                                        child: FittedBox(
                                                          child:
                                                              AnimatedHoverButton(
                                                            icon: Icons.edit,
                                                            tooltip:
                                                                'Editar Jefe de área',
                                                            primaryColor:
                                                                Colors.white,
                                                            secondaryColor:
                                                                const Color(
                                                                    0XFFf26925),
                                                            onTap: () async {
                                                              widget.provider
                                                                  .initEditarUsuario(
                                                                      usuario!);
                                                              await Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                'editar-jefe-de-area',
                                                                arguments:
                                                                    usuario,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              5), // Espacio para el texto
                                                      const Text('EDITAR',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  12)), // Texto debajo del botón
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 45,
                                                        height: 45,
                                                        child: FittedBox(
                                                          child:
                                                              AnimatedHoverButton(
                                                            icon: Icons
                                                                .person_remove,
                                                            tooltip: 'Eliminar',
                                                            primaryColor:
                                                                Colors.white,
                                                            secondaryColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    205,
                                                                    13,
                                                                    13),
                                                            onTap: () async {
                                                              widget.provider
                                                                      .botonTransferir =
                                                                  false;
                                                              widget.provider
                                                                      .selectedRadio =
                                                                  null;
                                                              var isnotnull = await widget
                                                                  .provider
                                                                  .getEmpleadosDelJefe(
                                                                      rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'perfil_usuario_id']!
                                                                          .value);

                                                              var jefeisnotnull = await widget
                                                                  .provider
                                                                  .getColumnaDerecha(
                                                                      rendererContext
                                                                          .row
                                                                          .cells[
                                                                              'perfil_usuario_id']!
                                                                          .value);

                                                              if (isnotnull !=
                                                                  null) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      content:
                                                                          PopupTransferirEmpleadosWidget(
                                                                        jefeAreaId:
                                                                            isnotnull,
                                                                        nombreJefe: rendererContext
                                                                            .row
                                                                            .cells['nombre']!
                                                                            .value,
                                                                        avatarJefe: rendererContext
                                                                            .row
                                                                            .cells['avatar']!
                                                                            .value,
                                                                        emailJefe: rendererContext
                                                                            .row
                                                                            .cells['email']!
                                                                            .value,
                                                                        listajefe:
                                                                            jefeisnotnull,
                                                                      ), // Widget personalizado
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                print(
                                                                    "no hay empleados");
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              5), // Espacio para el texto
                                                      const Text('ELIMINAR',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  12)), // Texto debajo del botón
                                                    ],
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
