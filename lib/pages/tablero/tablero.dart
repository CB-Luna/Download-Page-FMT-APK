import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/tablero/samples/dateranges.dart';
import 'package:dowload_page_apk/pages/tablero/widgets/perdidasv2.dart';
import 'package:dowload_page_apk/pages/tablero/widgets/tabla_pluto.dart';
import 'package:dowload_page_apk/pages/tablero/widgets/tabla_plutov2.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/providers/tablero_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/pages/tablero/widgets/ahorro_beneficio.dart';

class Tablero extends StatefulWidget {
  const Tablero({Key? key}) : super(key: key);

  @override
  State<Tablero> createState() => _TableroState();
}

class _TableroState extends State<Tablero> {
  @override
  void initState() {
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      TableroStateProvider provider = Provider.of<TableroStateProvider>(
        context,
        listen: false,
      );
      await provider.tablaPuntosGanados();
      await provider.graficaPuntosTotales(DateTime.now());
      await provider.graficaPuntosMes();
      await provider.tablaCompras();
    }); */
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);

    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);

    visualState.setTapedOption(3);

    switch (providertablero.condiciontabla) {
      case 1:
        providertablero.name = ': Puntos Sin Validar';
        break;
      case 2:
        providertablero.name = ': Puntos Rechazados';
        break;

      default:
        providertablero.name = '';
        break;
    }

    return Scaffold(
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const TopMenuWidget(
              title: 'Historial',
            ),
            Expanded(
              child: Row(
                children: [
                  const SideMenuWidget(),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //padding titulo y barra
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //row de boton regresar
                                  AnimatedHoverButton(
                                    primaryColor:
                                        AppTheme.of(context).primaryColor,
                                    secondaryColor:
                                        AppTheme.of(context).primaryBackground,
                                    icon: Icons.arrow_back,
                                    tooltip: 'Regresar',
                                    onTap: () {
                                      context.go('/saldo');
                                    },
                                  ),
                                  Text(
                                    providertablero.mesFinPerdidas == ""
                                        ? 'Mes: ${providertablero.mes} '
                                        : 'Mes: ${providertablero.mes} - ${providertablero.mesFinPerdidas}',
                                    style: AppTheme.of(context)
                                        .textoResaltado
                                        .override(
                                          fontFamily: 'Gotham-Bold',
                                          color:
                                              AppTheme.of(context).primaryColor,
                                          fontSize: 25,
                                          useGoogleFonts: false,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: ElevatedButton.icon(
                                          icon:
                                              const Icon(Icons.calendar_month),
                                          onPressed: () {
                                            providertablero
                                                .pickDateRange(context);
                                          },
                                          label: Text(
                                              'Del: ${providertablero.dateRange.start.day}/${providertablero.dateRange.start.month}/${providertablero.dateRange.start.year} Hasta: ${providertablero.dateRange.end.day}/${providertablero.dateRange.end.month}/${providertablero.dateRange.end.year}',
                                              style: AppTheme.of(context)
                                                  .textoResaltado),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 8,
                                            shadowColor: AppTheme.of(context)
                                                .primaryBackground
                                                .withOpacity(0.8),
                                            backgroundColor:
                                                AppTheme.of(context)
                                                    .primaryBackground,
                                            foregroundColor:
                                                AppTheme.of(context)
                                                    .primaryColor,
                                            side: BorderSide(
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: AnimatedHoverButton(
                                            tooltip: 'Reiniciar Graficas',
                                            primaryColor: AppTheme.of(context)
                                                .primaryColor,
                                            secondaryColor: AppTheme.of(context)
                                                .primaryBackground,
                                            icon: Icons.refresh,
                                            onTap: () async {
                                              providertablero.fechainiTabla =
                                                  findFirstDateOfTheMonth(
                                                      DateTime.now());
                                              providertablero.fechafinTabla =
                                                  findLastDateOfTheMonth(
                                                      DateTime.now());
                                              providertablero.mes =
                                                  DateFormat.yMMM('es_MX')
                                                      .format(DateTime.now());
                                              providertablero.mesFinPerdidas =
                                                  "";
                                              providertablero.dateRange =
                                                  DateTimeRange(
                                                      start:
                                                          findFirstDateOfTheMonth(
                                                              DateTime.now()),
                                                      end:
                                                          findLastDateOfTheMonth(
                                                              DateTime.now()));
                                              providertablero.condiciontabla =
                                                  0;
                                              await providertablero
                                                  .tablaPuntosGanados();
                                              await providertablero
                                                  .tablaCompras();
                                              await providertablero
                                                  .graficaPuntosMes();
                                              await providertablero
                                                  .graficaPuntosTotales(
                                                      DateTime.now());
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            //Expanded graficas
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              child: Row(
                                children: const [
                                  AhorroBeneficio(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              child: Row(
                                children: const [
                                  PerdidasABV2(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width:
                                        .9 * MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .primaryBackground,
                                      border: Border.all(
                                          color: AppTheme.of(context)
                                              .primaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: FlipCard(
                                        key: cardKey,
                                        fill: Fill.fillBack,
                                        flipOnTouch: false,
                                        direction: FlipDirection.HORIZONTAL,
                                        front: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 250),
                                                  child: Text(
                                                      'Historial Ingreso de Puntos ${providertablero.name}',
                                                      style:
                                                          AppTheme.of(context)
                                                              .textoResaltado
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Bold',
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 25,
                                                                useGoogleFonts:
                                                                    false,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 20),
                                                  child: AnimatedHoverButton(
                                                      tooltip:
                                                          'Reiniciar Tabla',
                                                      primaryColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      secondaryColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      icon: Icons.refresh,
                                                      onTap: () async {
                                                        providertablero
                                                            .condiciontabla = 0;
                                                        await providertablero
                                                            .tablaPuntosGanados();
                                                        await providertablero
                                                            .tablaCompras();
                                                      }),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 10),
                                                  child: AnimatedHoverButton(
                                                    tooltip: 'Descargar Tabla',
                                                    primaryColor:
                                                        AppTheme.of(context)
                                                            .primaryColor,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    icon:
                                                        Icons.download_outlined,
                                                    onTap: () async {
                                                      await providertablero
                                                          .excelTablaPuntos();
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: ElevatedButton.icon(
                                                    icon: const Icon(Icons
                                                        .table_rows_outlined),
                                                    onPressed: () => cardKey
                                                        .currentState
                                                        ?.toggleCard(),
                                                    label: Text(
                                                        'Ver Historial de Compras',
                                                        style: AppTheme.of(
                                                                context)
                                                            .textoResaltado),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 8,
                                                      shadowColor:
                                                          AppTheme.of(context)
                                                              .primaryBackground
                                                              .withOpacity(0.8),
                                                      backgroundColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      foregroundColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      side: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width: .9 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                height: 400,
                                                child: const TablaPluto()),
                                          ],
                                        ),
                                        back: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 250),
                                                  child: Text(
                                                      'Historial de Compras${providertablero.name}',
                                                      style:
                                                          AppTheme.of(context)
                                                              .textoResaltado
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Bold',
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 25,
                                                                useGoogleFonts:
                                                                    false,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 20),
                                                  child: AnimatedHoverButton(
                                                      tooltip:
                                                          'Reiniciar Tabla',
                                                      primaryColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      secondaryColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      icon: Icons.refresh,
                                                      onTap: () async {
                                                        providertablero
                                                            .condiciontabla = 0;
                                                        providertablero
                                                            .condicionInicialTabla = 5;
                                                        await providertablero
                                                            .tablaPuntosGanados();
                                                        await providertablero
                                                            .tablaCompras();
                                                      }),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 10),
                                                  child: AnimatedHoverButton(
                                                    tooltip: 'Descargar Tabla',
                                                    primaryColor:
                                                        AppTheme.of(context)
                                                            .primaryColor,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    icon:
                                                        Icons.download_outlined,
                                                    onTap: () async {
                                                      await providertablero
                                                          .excelTablaCompras();
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: ElevatedButton.icon(
                                                    icon: const Icon(Icons
                                                        .table_rows_outlined),
                                                    onPressed: () => cardKey
                                                        .currentState
                                                        ?.toggleCard(),
                                                    label: Text(
                                                        'Ver Historial Ingreso de Puntos',
                                                        style: AppTheme.of(
                                                                context)
                                                            .textoResaltado),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 8,
                                                      shadowColor:
                                                          AppTheme.of(context)
                                                              .primaryBackground
                                                              .withOpacity(0.8),
                                                      backgroundColor: AppTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      foregroundColor:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      side: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width: .9 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                height: 400,
                                                child: const TablaPlutoV2()),
                                          ],
                                        ),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
