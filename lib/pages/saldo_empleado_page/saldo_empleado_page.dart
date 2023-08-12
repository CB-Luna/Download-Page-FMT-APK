import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/functions/money_format.dart';
import 'package:dowload_page_apk/pages/saldo_empleado_page/widgets/detalle_registro_ganado_popup.dart';
import 'package:dowload_page_apk/pages/saldo_empleado_page/widgets/detalle_registro_gastado_popup.dart';
import 'package:dowload_page_apk/pages/saldo_empleado_page/widgets/estatus_consulta_saldo.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/providers/saldo_controller.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import '../../helpers/globals.dart';

class SaldoEmpleadoPage extends StatefulWidget {
  const SaldoEmpleadoPage({Key? key}) : super(key: key);

  @override
  State<SaldoEmpleadoPage> createState() => _SaldoEmpleadoPageState();
}

class _SaldoEmpleadoPageState extends State<SaldoEmpleadoPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOpen = false;

 @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SaldoController provider = Provider.of<SaldoController>(
        context,
        listen: false,
      );
      await provider.updateState(currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    final SaldoController provider =
        Provider.of<SaldoController>(context);
    visualState.setTapedOption(5);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const TopMenuWidget(title: 'Saldo Empleado', titleSize: 0.025),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                            children: [
                              // //HEADER
                              // const SeguimientoFacturasHeader(),
                              // //ESTATUS STEPPER
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 0),
                                child: EstatusConsultaSaldoWidget(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // provider.seguimientoFacturas.isEmpty
                              //     ? const CircularProgressIndicator()
                              //     : 
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
                                            resolveDefaultColumnFilter: (column, resolver) {
                                              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                            },
                                          ),
                                        ),
                                        columns: [
                                          PlutoColumn(
                                            title: 'ID',
                                            field: 'id',
                                            width: 120,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              return Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas.override(
                                                      fontFamily: 'Gotham-Regular',
                                                      useGoogleFonts: false,
                                                      color: AppTheme.of(context).primaryColor,
                                                    ),
                                                textAlign: TextAlign.center,
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'Concepto',
                                            field: 'concepto',
                                            width: 200,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Puntos',
                                            field: 'puntos',
                                            width: 150,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            renderer: (rendererContext) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppTheme.of(context).primaryColor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                      child: Text(
                                                        '${rendererContext.cell.value}',
                                                        textAlign: TextAlign.center,
                                                        style: AppTheme.of(context).contenidoTablas,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      'assets/images/LogoBD.png',
                                                      height: 25,
                                                      fit: BoxFit.cover,
                                                    ) 
                                                  ],
                                                ),
                                              );
                                            },
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Fecha Registro',
                                            field: 'fecha_registro',
                                            width: 180,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Fecha Entrega',
                                            field: 'fecha_entrega',
                                            width: 180,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Semáforo',
                                            field: 'semaforo',
                                            width: 150,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            renderer: (rendererContext) {
                                              return Icon(
                                                Icons.circle,
                                                color:  rendererContext.cell.value == "GANADO"
                                                ? Colors.green
                                                : rendererContext.cell.value == "GASTADO"
                                                    ? Colors.red
                                                    : Colors.yellow,
                                              );
                                            },
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              // final int facturaId = rendererContext.cell.value;
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(width: 10),
                                                  AnimatedHoverButton(
                                                    icon: Icons.visibility,
                                                    tooltip: 'Detalles',
                                                    primaryColor: AppTheme.of(context).primaryColor,
                                                    secondaryColor: AppTheme.of(context).primaryBackground,
                                                    onTap: () async {
                                                      List listaAcciones = rendererContext.cell.value;
                                                      if (listaAcciones[0] == "GANADO") {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              backgroundColor: const Color(0xffd1d0d0),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                              content: DetalleRegistroGanadoPopup(
                                                                topMenuTittle: "Detalle Evento Ganado", 
                                                                registroGanado: listaAcciones[1],
                                                              ), // Widget personalizado
                                                            );
                                                          },
                                                        );
                                                      }
                                                      if (listaAcciones[0] == "GASTADO") {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              backgroundColor: const Color(0xffd1d0d0),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                              content: DetalleRegistroGastadoPopup(
                                                                topMenuTittle: "Detalle Orden Gastada", 
                                                                registroGastado: listaAcciones[1],
                                                              ), // Widget personalizado
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox.shrink(),
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
                                          for (var i = 0; i < stateManager.totalPage; i++) {
                                            // provider.pageChecked.add(false);
                                          }
                                          return PlutoPagination(stateManager);
                                        },
                                        onLoaded: (event) {
                                          // provider.stateManager = event.stateManager;
                                          // provider.stateManager!.setShowColumnFilter(true);
                                          // provider.stateManager!.setSelectingMode(
                                          //   PlutoGridSelectingMode.row,
                                          // );
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
      ),
    );
  }
}
