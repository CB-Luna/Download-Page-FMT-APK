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
import '../../models/modelos_pantallas/empleados.dart';
import '../../models/modelos_pantallas/productos.dart';

import 'widgets/header_productos.dart';

class ProductosPageDesktop extends StatefulWidget {
  const ProductosPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final ProductosProvider provider;

  @override
  State<ProductosPageDesktop> createState() => _ProductosPageDesktopState();
}

class _ProductosPageDesktopState extends State<ProductosPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(7);

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
                title: "Productos",
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
                            ProductoPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 20,
                            ),
                            widget.provider.productos.isEmpty
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
                                          field: 'producto_id',
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
                                                Stack(
                                              children: [
                                                //white circle Container
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Color.fromARGB(
                                                            95, 255, 255, 255)
                                                        : Color.fromARGB(
                                                            73, 201, 201, 201),
                                                  ),
                                                ),
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
                                                            'assets/images/defaultproduct.png',
                                                            fit: BoxFit.contain,
                                                          )
                                                        : Image.network(
                                                            rendererContext
                                                                .cell.value,
                                                            fit: BoxFit.contain,
                                                          ))
                                              ],
                                            );
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
                                          title: 'Descripción',
                                          field: 'descripcion',
                                          width: 300,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Costo puntos',
                                          field: 'costo',
                                          width: 300,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.number(
                                            format: '#,###',
                                          ),
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
                                              Productos? producto;
                                              try {
                                                producto = widget
                                                    .provider.productos
                                                    .firstWhere((element) =>
                                                        element.productoId ==
                                                        id);
                                              } catch (e) {
                                                producto = null;
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
                                                          'Editar producto',
                                                      primaryColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      secondaryColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      onTap: () async {},
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
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
                                                field: 'producto_id',
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
