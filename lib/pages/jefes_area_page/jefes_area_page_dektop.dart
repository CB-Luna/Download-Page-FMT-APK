import 'package:dowload_page_apk/functions/phone_format.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import '../../helpers/globals.dart';

import 'widgets/popup_transferencia.dart';
import 'widgets/header_jefe_area.dart';

class GestionJefesAreaPageDesktop extends StatefulWidget {
  const GestionJefesAreaPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final JefesAreaProvider provider;

  @override
  State<GestionJefesAreaPageDesktop> createState() =>
      _GestionJefesAreaPageDesktopState();
}

class _GestionJefesAreaPageDesktopState
    extends State<GestionJefesAreaPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(2);

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
                title: "Jefes de área",
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
                                          textAlign: PlutoColumnTextAlign.left,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
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
                                          title: 'Área',
                                          field: 'nombre_area',
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AnimatedHoverButton(
                                                      icon: Icons.edit,
                                                      tooltip:
                                                          'Editar Jefe de área',
                                                      primaryColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      secondaryColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      onTap: () async {
                                                        /*   await provider
                                                            .getArea(); */
                                                        /*          widget.provider
                                                            .initEditarUsuario(
                                                          usuario!,
                                                        );
                                                        await Navigator.of(
                                                                context)
                                                            .pushNamed(
                                                          'editar-jefe-de-area',
                                                          arguments:
                                                              usuario,
                                                        ); */
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  AnimatedHoverButton(
                                                    icon: Icons.person_remove,
                                                    tooltip: 'Eliminar',
                                                    primaryColor: Colors.red,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    onTap: () async {
                                                      widget.provider
                                                              .botonTransferir =
                                                          false;
                                                      widget.provider
                                                          .selectedRadio = null;
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

                                                      if (isnotnull != null) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content:
                                                                  PopupTransferirEmpleadosWidget(
                                                                jefeAreaId:
                                                                    isnotnull,
                                                                nombreJefe:
                                                                    rendererContext
                                                                        .row
                                                                        .cells[
                                                                            'nombre']!
                                                                        .value,
                                                                avatarJefe:
                                                                    rendererContext
                                                                        .row
                                                                        .cells[
                                                                            'avatar']!
                                                                        .value,
                                                                emailJefe:
                                                                    rendererContext
                                                                        .row
                                                                        .cells[
                                                                            'email']!
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
                                        widget.provider.stateManager!
                                            .sortAscending(PlutoColumn(
                                                title: '#',
                                                field: 'id_secuencial',
                                                type:
                                                    PlutoColumnType.number()));
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
