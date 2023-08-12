import 'package:dowload_page_apk/functions/money_format.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';

import 'package:dowload_page_apk/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../helpers/globals.dart';
import './widgets/grafica_pie.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(0);
    final HomeProvider providerHome = Provider.of<HomeProvider>(context);

    final bool isLight = AppTheme.themeMode == ThemeMode.light;

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
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
                            height: 0.02 * MediaQuery.of(context).size.height,
                          ),
                          SizedBox(
                            height: 0.03 * MediaQuery.of(context).size.height,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '¡Hola ${currentUser!.nombre + " " + currentUser!.apellidos}!',
                                /*  '¡Hola user!', */
                                style: TextStyle(
                                  fontFamily: 'Bicyclette-Light',
                                  fontSize:
                                      0.02 * MediaQuery.of(context).size.width,
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
                                'Resguardo de activos',
                                style: TextStyle(
                                  fontFamily: 'Bicyclette-Light',
                                  fontSize: 0.0155 *
                                      MediaQuery.of(context).size.width,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.045 * MediaQuery.of(context).size.height,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //3 containers

                              ContainerEmpleados(
                                titulo: "Empleados activos",
                                cantidad: providerHome.homeData == null
                                    ? 0.0
                                    : providerHome.homeData!.puntosAsignados
                                        .toDouble(),
                              ),
                              SizedBox(
                                width:
                                    0.038 * MediaQuery.of(context).size.width,
                              ),
                              ContainerEmpleados(
                                titulo: "Empleados\ndados de baja",
                                cantidad: providerHome.homeData == null
                                    ? 0.0
                                    : providerHome.homeData!.puntosGastados
                                        .toDouble(),
                              ),
                              SizedBox(
                                width:
                                    0.038 * MediaQuery.of(context).size.width,
                              ),
                              ContainerEmpleados(
                                titulo: "Empleados totales",
                                cantidad: providerHome.homeData == null
                                    ? 0.0
                                    : providerHome.homeData!.saldo.toDouble(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.025 * MediaQuery.of(context).size.height,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 0.4 * MediaQuery.of(context).size.width,
                                height:
                                    0.45 * MediaQuery.of(context).size.height,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 48),
                                  child: GraficaPie(
                                    width:
                                        0.5 * MediaQuery.of(context).size.width,
                                    height: 0.4 *
                                        MediaQuery.of(context).size.height,
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title1: "SALDO",
                                    title1Color:
                                        AppTheme.of(context).primaryColor,
                                    title2: "PUNTOS DEVENGADOS",
                                    title2Color:
                                        AppTheme.of(context).tertiaryColor,
                                    value1: providerHome.homeData == null
                                        ? 0.0
                                        : providerHome.homeData!.saldo
                                            .toDouble(),
                                    value2: providerHome.homeData == null
                                        ? 0.0
                                        : providerHome.homeData!.puntosGastados
                                            .toDouble(),
                                    valorTotal: providerHome
                                        .homeData!.puntosAsignados
                                        .toDouble(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //**************************************************************
                      //**************** EPARACION ENTRE COLUMNAS ********************
                      //**************************************************************
                      SizedBox(
                        // make a width separacion half of the screen
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                      //**************************************************************
                      //**************************************************************
                      //**************************************************************

                      //**************************************************************
                      //**************************************************************
                      //**************************************************************
                      //****************** COLUMNA DERECHA ***************************
                      //**************************************************************
                      //**************************************************************
                      //**************************************************************

                      Column(
                        children: [
                          SizedBox(
                            height: 0.06 * MediaQuery.of(context).size.height,
                          ),
                          Row(
                            children: [
                              Text(
                                'Ejercicio del mes: ${DateFormat.MMMM('es_ES').format(DateTime.now()).toUpperCase()[0] + DateFormat.MMMM('es_ES').format(DateTime.now()).substring(1)}',
                                style: TextStyle(
                                  fontFamily: 'Gotham-Light',
                                  fontSize: 0.0155 *
                                      MediaQuery.of(context).size.width,
                                  color: Colors.black,
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
                                      MediaQuery.of(context)
                                          .size
                                          .width), //espacio
                              const ProveedoresInscritosCard(),
                            ],
                          ),
                          SizedBox(
                            height: 0.074 * MediaQuery.of(context).size.height,
                          ),
                          Row(
                            children: [
                              GradientText(
                                'ESQUEMAS DEL MODELO',
                                style: TextStyle(
                                  fontFamily: 'Gotham-Bold',
                                  fontSize:
                                      0.015 * MediaQuery.of(context).size.width,
                                  color: AppTheme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                colors: const [
                                  Color.fromARGB(255, 248, 132, 74),
                                  Color(0XFFf26925),
                                  Color.fromARGB(255, 196, 65, 0),
                                  //add mroe colors here.
                                ],
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

                //two columns left and right, left column will contains a centered title and a subtitle below that, there will be a row with three containers, each container will have a title and a subtitle
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoEsquemaDelModelo extends StatelessWidget {
  const InfoEsquemaDelModelo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 0.015 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    Icon(Icons.stream_rounded,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 0.01 * MediaQuery.of(context).size.width),
                    SizedBox(
                      width: 0.007 * MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      width: 0.31 * MediaQuery.of(context).size.width,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          /*   text: 'Pull PNC',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ), */
                          children: [
                            TextSpan(
                              text: 'HERRAMIENTAS : ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                //text with shadows
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: Color.fromARGB(255, 171, 170, 170),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text: ' Se refiere a ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'cualquier objeto ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'que el empleado pide prestado y que dicho objeto no se encuentra en las otras categorías.',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    Icon(Icons.stream_rounded,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 0.01 * MediaQuery.of(context).size.width),
                    SizedBox(
                      width: 0.007 * MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      width: 0.31 * MediaQuery.of(context).size.width,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'COMPUTADORAS',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: Color.fromARGB(255, 171, 170, 170),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' Equipos de cómputo que el empleado pide prestado y tiene que estar resguardada por la seguridad patrimonial.',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    Icon(Icons.stream_rounded,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 0.01 * MediaQuery.of(context).size.width),
                    SizedBox(
                      width: 0.007 * MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      width: 0.31 * MediaQuery.of(context).size.width,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'TARJETAS DE CRÉDITO',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: Color.fromARGB(255, 171, 170, 170),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' Tarjetas de crédito que el empleado pide prestado y tiene que estar resguardada por la seguridad patrimonial.',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    Icon(Icons.stream_rounded,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        size: 0.01 * MediaQuery.of(context).size.width),
                    SizedBox(
                      width: 0.007 * MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      width: 0.31 * MediaQuery.of(context).size.width,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'CELULARES',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: Color.fromARGB(255, 171, 170, 170),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' Celulares que el empleado pide prestado y tiene que estar resguardada por la seguridad patrimonial.',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class ProveedoresInscritosCard extends StatelessWidget {
  const ProveedoresInscritosCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider providerHome = Provider.of<HomeProvider>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              SizedBox(
                width: 0.28 * MediaQuery.of(context).size.width,
                height: 0.25 * MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 0.15 * MediaQuery.of(context).size.width,
                          child: Text(
                            'Jefes de área',
                            style: TextStyle(
                              fontFamily: 'Bicyclette-Light',
                              fontSize:
                                  0.016 * MediaQuery.of(context).size.width,
                              /*  fontWeight: FontWeight.w600, */
                              shadows: const [
                                Shadow(
                                  color: Color(0xff000000),
                                  offset: Offset(-2, 0),
                                  blurRadius: 1,
                                ),
                                Shadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  offset: Offset(-2, 1),
                                  blurRadius: 3,
                                ),
                                Shadow(
                                  color: Color.fromARGB(255, 147, 143, 143),
                                  offset: Offset(-2, 0),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 0.1 * MediaQuery.of(context).size.width,
                          height: 0.1 * MediaQuery.of(context).size.width,
                          child: Center(
                            widthFactor: 2.0,
                            heightFactor: 3,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  providerHome.homeData == null
                                      ? '0'
                                      : providerHome.homeData!.saldo.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Bicyclette-Light',
                                    fontSize: 0.05 *
                                        MediaQuery.of(context).size.height,
                                    color: const Color(0xff17274c),
                                    fontWeight: FontWeight.w600,
                                    shadows: const [
                                      Shadow(
                                        color: Color(0xff000000),
                                        offset: Offset(-2, -1),
                                        blurRadius: 1,
                                      ),
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 147, 143, 143),
                                        offset: Offset(-1, -1),
                                        blurRadius: 5,
                                      ),
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        offset: Offset(-2, 1),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContainerEmpleados extends StatelessWidget {
  final String titulo;
  final num? cantidad;
  const ContainerEmpleados({
    Key? key,
    required this.titulo,
    required this.cantidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.1 * MediaQuery.of(context).size.width,
      height: 0.182 * MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientText(
                titulo,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Bicyclette-Light',
                  fontSize: 0.01 * MediaQuery.of(context).size.width,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Color.fromARGB(255, 7, 119, 211),
                  Color(0XFF04589c),
                  Color.fromARGB(255, 3, 57, 100),
                  //add mroe colors here.
                ],
              ),
              Row(
                children: [
                  Text(
                    cantidad!.toInt().round().toString(),
                    style: TextStyle(
                      fontFamily: 'Bicyclette-Light',
                      fontSize: 0.01 * MediaQuery.of(context).size.width,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
