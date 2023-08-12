import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';

import 'package:dowload_page_apk/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helpers/globals.dart';
import './widgets/grafica_pie.dart';
import 'widgets/container_titulo_valor.dart';
import 'widgets/esquema.dart';
import 'widgets/inscritos_card.dart';

//import neumorphism

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.providerHome})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final HomeProvider providerHome;

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(0);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Column(
        children: [
          const TopMenuWidget(title: 'Visión general', titleSize: 0.025),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SideMenuWidget(),

                //**************************************************************
                //**************************************************************
                //**************************************************************
                //****************** COLUMNA IZQUIERDA *************************
                //**************************************************************
                //**************************************************************
                //**************************************************************
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.05 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '¡Hola ${"${currentUser!.nombre} ${currentUser!.apellidos}"}!',
                          style: TextStyle(
                            fontFamily: 'Bicyclette-Light',
                            fontSize: 0.02 * MediaQuery.of(context).size.width,
                            color: AppTheme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.042 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sistema de puntaje',
                          style: TextStyle(
                            fontFamily: 'Bicyclette-Light',
                            fontSize:
                                0.0155 * MediaQuery.of(context).size.width,
                            color: AppTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.045 * MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      width: 0.4 * MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ContainerEmpleados(
                                titulo: "Puntos asignados",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget
                                        .providerHome.homeData!.puntosAsignados
                                        .toDouble(),
                              ),
                              SizedBox(
                                height:
                                    0.01 * MediaQuery.of(context).size.height,
                              ),
                              ContainerEmpleados(
                                titulo: "Eventos activos",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget
                                        .providerHome.homeData!.eventosActuales
                                        .toDouble(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ContainerEmpleados(
                                titulo: "Puntos devengados",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget
                                        .providerHome.homeData!.puntosGastados
                                        .toDouble(),
                              ),
                              SizedBox(
                                height:
                                    0.01 * MediaQuery.of(context).size.height,
                              ),
                              ContainerEmpleados(
                                titulo: "Eventos pasados",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget
                                        .providerHome.homeData!.eventosPasados
                                        .toDouble(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ContainerEmpleados(
                                titulo: "Saldo",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget.providerHome.homeData!.saldo
                                        .toDouble(),
                              ),
                              SizedBox(
                                height:
                                    0.01 * MediaQuery.of(context).size.height,
                              ),
                              ContainerEmpleados(
                                titulo: "Total eventos",
                                cantidad: widget.providerHome.homeData == null
                                    ? 0.0
                                    : widget
                                        .providerHome.homeData!.eventosTotales
                                        .toDouble(),
                              ),
                            ],
                          ),
                          /*               ContainerEmpleados(
                            titulo: "Saldo",
                            cantidad: widget.providerHome.homeData == null
                                ? 0.0
                                : widget.providerHome.homeData!.saldo
                                    .toDouble(),
                          ),
                          ContainerEmpleados(
                            titulo: "Saldo",
                            cantidad: widget.providerHome.homeData == null
                                ? 0.0
                                : widget.providerHome.homeData!.saldo
                                    .toDouble(),
                          ), */
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.015 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.4 * MediaQuery.of(context).size.width,
                          height: 0.4 * MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 48),
                            child: GraficaPie(
                              width: 0.5 * MediaQuery.of(context).size.width,
                              height: 0.4 * MediaQuery.of(context).size.height,
                              backgroundColor:
                                  AppTheme.of(context).primaryBackground,
                              title1: "SALDO",
                              title1Color: AppTheme.of(context).primaryColor,
                              title2: "PUNTOS DEVENGADOS",
                              title2Color: AppTheme.of(context).tertiaryColor,
                              value1: widget.providerHome.homeData == null
                                  ? 0.0
                                  : widget.providerHome.homeData!.saldo
                                      .toDouble(),
                              value2: widget.providerHome.homeData == null
                                  ? 0.0
                                  : widget.providerHome.homeData!.puntosGastados
                                      .toDouble(),
                              valorTotal: widget.providerHome.homeData == null
                                  ? 0.0
                                  : widget
                                      .providerHome.homeData!.puntosAsignados
                                      .toDouble(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  // make a width separacion half of the screen
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 0.06 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      children: [
                        Text(
                          'Ejercicio del mes: ${DateFormat.MMMM('es_ES').format(DateTime.now()).toUpperCase()[0] + DateFormat.MMMM('es_ES').format(DateTime.now()).substring(1)} ${DateTime.now().year}',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.0155 * MediaQuery.of(context).size.width,
                            color: AppTheme.of(context).primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.045 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 0.019 *
                                MediaQuery.of(context).size.width), //espacio
                        const ProveedoresInscritosCard(),
                      ],
                    ),
                    SizedBox(
                      height: 0.074 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      children: [
                        Text(
                          'ESQUEMAS DEL MODELO',
                          style: TextStyle(
                            fontFamily: 'Gotham-Bold',
                            fontSize: 0.015 * MediaQuery.of(context).size.width,
                            color: AppTheme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.03 * MediaQuery.of(context).size.height,
                    ),
                    //----------------------------------------------------
                    const InfoEsquemaDelModelo(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
