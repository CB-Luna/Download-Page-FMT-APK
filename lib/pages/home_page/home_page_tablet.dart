import 'package:dowload_page_apk/pages/widgets/custom_appbar/custom_appbar.dart';
import 'package:dowload_page_apk/pages/widgets/drawer/drawer.dart';

import 'package:dowload_page_apk/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../helpers/globals.dart';
import '../../helpers/responsive.dart';
import './widgets/grafica_pie.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.providerHome})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final HomeProvider providerHome;

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(0);
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return MiAdvancedDrawer(
      scaffoldKey: widget.scaffoldKey,
      drawerController: widget.drawerController,
      appBar: CustomAppBar(
          key: UniqueKey(),
          titleSize: 0.03,
          title: 'Inicio',
          drawerController: widget.drawerController),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobile(context) ? 20 : 30),
                      child: Text(
                        '¡Hola ${"${currentUser!.nombre} ${currentUser!.apellidos}"}!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: deviceType == DeviceScreenType.desktop
                              ? 0.030 * MediaQuery.of(context).size.width
                              : 0.045 * MediaQuery.of(context).size.width,
                          color: AppTheme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Sistema de puntaje',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Bicyclette-Light',
                        fontSize: deviceType == DeviceScreenType.desktop
                            ? 0.025 * MediaQuery.of(context).size.width
                            : 0.035 * MediaQuery.of(context).size.width,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 0.045 * MediaQuery.of(context).size.height,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //3 containers

                        ContainerEmpleados(
                          titulo: "Puntos asignados",
                          cantidad: widget.providerHome.homeData == null
                              ? 0.0
                              : widget.providerHome.homeData!.puntosAsignados
                                  .toDouble(),
                        ),

                        ContainerEmpleados(
                          titulo: "Puntos gastados",
                          cantidad: widget.providerHome.homeData == null
                              ? 0.0
                              : widget.providerHome.homeData!.puntosGastados
                                  .toDouble(),
                        ),

                        ContainerEmpleados(
                          titulo: "Saldo",
                          cantidad: widget.providerHome.homeData == null
                              ? 0.0
                              : widget.providerHome.homeData!.saldo.toDouble(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.025 * MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 0.45 * MediaQuery.of(context).size.height,
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
                              : widget.providerHome.homeData!.saldo.toDouble(),
                          value2: widget.providerHome.homeData == null
                              ? 0.0
                              : widget.providerHome.homeData!.puntosGastados
                                  .toDouble(),
                          valorTotal: widget
                              .providerHome.homeData!.puntosAsignados
                              .toDouble(),
                        ),
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Ejercicio del mes: ${DateFormat.MMMM('es_ES').format(DateTime.now()).toUpperCase()[0] + DateFormat.MMMM('es_ES').format(DateTime.now()).substring(1)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Gotham-Light',
                                      fontSize: deviceType ==
                                              DeviceScreenType.desktop
                                          ? 0.025 *
                                              MediaQuery.of(context).size.width
                                          : 0.035 *
                                              MediaQuery.of(context).size.width,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const ProveedoresInscritosCard(),
                              ],
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Column(
                            children: [
                              GradientText(
                                'ESQUEMAS DEL MODELO',
                                style: TextStyle(
                                  fontFamily: 'Gotham-Bold',
                                  fontSize:
                                      deviceType == DeviceScreenType.desktop
                                          ? 0.025 *
                                              MediaQuery.of(context).size.width
                                          : 0.035 *
                                              MediaQuery.of(context).size.width,
                                  color: AppTheme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                colors: [
                                  AppTheme.of(context).primaryColor,
                                  HSLColor.fromColor(
                                          AppTheme.of(context).primaryColor)
                                      .withSaturation(
                                          1.0) // aumenta la saturación al máximo (1.0)
                                      .toColor(),
                                  HSLColor.fromColor(
                                          AppTheme.of(context).primaryColor)
                                      .withLightness(
                                          0.3) // disminuye el brillo en un 30%
                                      .toColor(),
                                ],
                              ),
                              const InfoEsquemaDelModelo(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.015 * MediaQuery.of(context).size.height,
            ),
            Row(
              children: [
                Icon(Icons.stream_rounded,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: 0.02 * MediaQuery.of(context).size.width),
                SizedBox(
                  width: 0.007 * MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'PUNTOS GANADOS : ',
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
                          text:
                              ' Se refiere a la cantidad de puntos que un empleado ha ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'obtenido ',
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
                              'por asistir a eventos organizados por la empresa. Estos puntos son otorgados por la empresa como una forma de reconocer la participación y el compromiso del empleado con la organización.',
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
                    size: 0.02 * MediaQuery.of(context).size.width),
                SizedBox(
                  width: 0.007 * MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'PUNTOS GASTADOS : ',
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
                              ' Se refiere a la cantidad de puntos que un empleado ha ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'gastado ',
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
                              ' para adquirir productos disponibles en la empresa.',
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
                    size: 0.02 * MediaQuery.of(context).size.width),
                SizedBox(
                  width: 0.007 * MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'SALDO : ',
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
                          text: ' Es la  ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'diferencia ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' entre los ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'ganados y los puntos gastados ',
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            fontSize:
                                0.017 * MediaQuery.of(context).size.height,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'por un empleado.',
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
        ));
  }
}

class ProveedoresInscritosCard extends StatelessWidget {
  const ProveedoresInscritosCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider providerHome = Provider.of<HomeProvider>(context);

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Jefes de área',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Bicyclette-Light',
                  fontSize: deviceType == DeviceScreenType.desktop
                      ? 0.025 * MediaQuery.of(context).size.width
                      : 0.035 * MediaQuery.of(context).size.width,
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
            Container(
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                //box decoration inner shadow withe
                width: deviceType == DeviceScreenType.desktop
                    ? 0.1 * MediaQuery.of(context).size.width
                    : 0.2 * MediaQuery.of(context).size.width,
                height: deviceType == DeviceScreenType.desktop
                    ? 0.1 * MediaQuery.of(context).size.width
                    : 0.2 * MediaQuery.of(context).size.width,

                child: Center(
                  widthFactor: 2.0,
                  heightFactor: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        providerHome.homeData == null
                            ? '0'
                            : providerHome.homeData!.cantJefesArea.toString(),
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: deviceType == DeviceScreenType.desktop
                              ? 0.05 * MediaQuery.of(context).size.height
                              : 0.08 * MediaQuery.of(context).size.height,
                          color: const Color(0xff17274c),
                          fontWeight: FontWeight.w600,
                          shadows: const [
                            Shadow(
                              color: Color(0xff000000),
                              offset: Offset(-2, -1),
                              blurRadius: 1,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 147, 143, 143),
                              offset: Offset(-1, -1),
                              blurRadius: 5,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 255, 255, 255),
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
            ),
          ],
        ),
      ),
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
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 0.182 * MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              titulo,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bicyclette-Light',
                fontSize: deviceType == DeviceScreenType.desktop
                    ? 0.025 * MediaQuery.of(context).size.width
                    : 0.035 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.bold,
              ),
              colors: const [
                Color.fromARGB(255, 7, 119, 211),
                Color(0XFF04589c),
                Color.fromARGB(255, 3, 57, 100),
                //add mroe colors here.
              ],
            ),
            Text(
              cantidad!.toInt().round().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Bicyclette-Light',
                fontSize: deviceType == DeviceScreenType.desktop
                    ? 0.025 * MediaQuery.of(context).size.width
                    : 0.035 * MediaQuery.of(context).size.width,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
