import 'dart:developer';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dowload_page_apk/pages/tablero/samples/dateranges.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:dowload_page_apk/functions/money_format.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/tablero/samples/indicator.dart';
import 'package:dowload_page_apk/providers/tablero_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class AhorroBeneficio extends StatefulWidget {
  const AhorroBeneficio({Key? key}) : super(key: key);

  @override
  State<AhorroBeneficio> createState() => _AhorroBeneficioState();
}

class _AhorroBeneficioState extends State<AhorroBeneficio> {
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${(value)}',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Gotham-Regular',
            fontWeight: FontWeight.normal,
            color: AppTheme.of(context).primaryText,
          )),
    );
  }

  Widget bottomTitleWidget(double value, TitleMeta meta) {
    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);
    final isTouched = value == providertablero.touchedValue;
    final style = TextStyle(
      fontSize: 15,
      fontFamily: 'Gotham-Regular',
      fontWeight: isTouched ? FontWeight.w600 : FontWeight.normal,
      color: isTouched
          ? AppTheme.of(context).primaryColor
          : AppTheme.of(context).primaryText,
    );

    String text;
    switch (providertablero.getTotales[value.toInt()].numeroMes) {
      case 1:
        text = "Ene";

        break;
      case 2:
        text = "Feb";

        break;
      case 3:
        text = "Mar";

        break;
      case 4:
        text = "Abr";

        break;
      case 5:
        text = "May";

        break;
      case 6:
        text = "Jun";

        break;
      case 7:
        text = "Jul";

        break;
      case 8:
        text = "Ago";

        break;
      case 9:
        text = "Sep";

        break;
      case 10:
        text = "Oct";

        break;
      case 11:
        text = "Nov";

        break;
      case 12:
        text = "Dic";

        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      space: 4,
      axisSide: meta.axisSide,
      child: providertablero.getTotales[value.toInt()].numeroMes ==
              providertablero.dateRange.start.month
          ? TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                elevation: 8,
                shadowColor: AppTheme.of(context).primaryColor.withOpacity(0.5),
                foregroundColor: AppTheme.of(context).primaryColor,
                backgroundColor:
                    AppTheme.of(context).primaryColor.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: AppTheme.of(context).primaryColor),
                ),
              ),
              onPressed: () {
                log(value.toString());
                providertablero.fechainiTabla = findFirstDateOfTheMonth(
                    (DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)));
                providertablero.fechafinTabla = findLastDateOfTheMonth(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.mes = DateFormat.yMMM('es_MX').format(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.mes = DateFormat.yMMM('es_MX').format(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.dateRange = DateTimeRange(
                    start: findFirstDateOfTheMonth(DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)),
                    end: findLastDateOfTheMonth(DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)));
                providertablero.graficaPuntosMes();
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
              },
              child: Text(
                text,
                style: style,
              ),
            )
          : TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                elevation: 8,
                shadowColor: AppTheme.of(context).primaryColor.withOpacity(0.5),
                foregroundColor: AppTheme.of(context).primaryColor,
                backgroundColor: AppTheme.of(context).primaryBackground,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: AppTheme.of(context).primaryColor),
                ),
              ),
              onPressed: () {
                log(value.toString());
                providertablero.fechainiTabla = findFirstDateOfTheMonth(
                    (DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)));
                providertablero.fechafinTabla = findLastDateOfTheMonth(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.mes = DateFormat.yMMM('es_MX').format(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.mes = DateFormat.yMMM('es_MX').format(DateTime(
                    providertablero.x,
                    providertablero.getTotales[value.toInt()].numeroMes));
                providertablero.dateRange = DateTimeRange(
                    start: findFirstDateOfTheMonth(DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)),
                    end: findLastDateOfTheMonth(DateTime(providertablero.x,
                        providertablero.getTotales[value.toInt()].numeroMes)));
                providertablero.graficaPuntosMes();
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
              },
              child: Text(
                text,
                style: style,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);
    //final bool permisoDescarga = currentUser!.currentRol.permisos.reportes == 'C' || currentUser!.currentRol.permisos.reportes == 'D';

    return Container(
      width: .9 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primaryBackground,
        border: Border.all(color: AppTheme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Puntos Anuales',
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).textoResaltado.override(
                        fontFamily: 'Gotham-Bold',
                        color: AppTheme.of(context).primaryColor,
                        fontSize: 25,
                        useGoogleFonts: false,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                // if (permisoDescarga)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: AnimatedHoverButton(
                      tooltip: 'Descargar',
                      primaryColor: AppTheme.of(context).primaryColor,
                      secondaryColor: AppTheme.of(context).primaryBackground,
                      icon: Icons.download_outlined,
                      onTap: () {
                        providertablero
                            .excelPuntosAnuales();
                      }),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Indicator(
                    //color: providertablero.facturacionNormal,
                    text: 'Saldo Final',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Facturacion Normal',
                    primaryColor: providertablero.facturacionNormal,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() =>
                        providertablero.pickFacturacionNormal(context)),
                    colorGrafica: providertablero.facturacionNormal,
                  ),
                  const SizedBox(
                    width: 50,
                    height: 30,
                  ),
                  Indicator(
                    //color: providertablero.cAhorro,
                    text: 'Puntos Ganados',
                    //isSquare: false,
                    // size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Ganados',
                    primaryColor: providertablero.cAhorro,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: () {
                      providertablero.pickAhorro(context);
                    },
                    colorGrafica: providertablero.facturacionNormal,
                  ),
                  const SizedBox(width: 50, height: 30),
                  Indicator(
                    //color: providertablero.ahorroPullNp,
                    text: 'Puntos Gastados',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Gastados',
                    primaryColor: providertablero.ahorroPullNp,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() => providertablero.pickAhorroPullNp(context)),
                    colorGrafica: providertablero.facturacionNormal,
                  ),
                  const SizedBox(width: 50, height: 30),
                  Indicator(
                    //color: providertablero.cAhorro,
                    text: 'Puntos sin Validar',
                    //isSquare: false,
                    // size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Ganados',
                    primaryColor: providertablero.ahorroPullPn,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: () {
                      providertablero.pickAhorroPullPN(context);
                    },
                    colorGrafica: providertablero.ahorroPullPn,
                  ),
                  const SizedBox(width: 50, height: 30),
                  Indicator(
                    //color: providertablero.ahorroPullNp,
                    text: 'Puntos Rechazados',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Gastados',
                    primaryColor: providertablero.ahorroPushNP,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() => providertablero.pickAhorroPushNP(context)),
                    colorGrafica: providertablero.ahorroPushNP,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: .85 * MediaQuery.of(context).size.width,
                  height: 200,
                  child: providertablero.getTotales.isEmpty
                      ? SpinKitFadingCircle(
                          color: AppTheme.of(context).primaryColor,
                          size: 80,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                      top: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      bottom: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      left: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      right: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid))),

                              lineTouchData: LineTouchData(
                                  enabled: true,
                                  touchTooltipData: LineTouchTooltipData(
                                      maxContentWidth: 300,
                                      tooltipBgColor: const Color.fromARGB(
                                          255, 226, 225, 225),
                                      getTooltipItems:
                                          (List<LineBarSpot> touchedBarSpots) {
                                        return touchedBarSpots.map((barSpot) {
                                          final flSpot = barSpot;
                                          //log(flSpot.y.toString());
                                          //log(flSpot.barIndex.toString());

                                          return LineTooltipItem(
                                            flSpot.barIndex == 0
                                                ? 'Saldo Final: ${flSpot.y}'
                                                : flSpot.barIndex == 1
                                                    ? 'Puntos Ganados: ${flSpot.y}'
                                                    : flSpot.barIndex == 2
                                                        ? 'Puntos Gastados: ${flSpot.y} '
                                                        : flSpot.barIndex == 3
                                                            ? 'Puntos sin Validar: ${flSpot.y}'
                                                            : 'Puntos Rechazados: ${flSpot.y}',
                                            TextStyle(
                                              color: flSpot.barIndex == 0
                                                  ? providertablero
                                                      .facturacionNormal
                                                  : flSpot.barIndex == 1
                                                      ? providertablero.cAhorro
                                                      : flSpot.barIndex == 2
                                                          ? providertablero
                                                              .ahorroPullNp
                                                          : flSpot.barIndex == 3
                                                              ? providertablero
                                                                  .ahorroPullPn
                                                              : providertablero
                                                                  .ahorroPushNP,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }).toList();
                                      }),
                                  touchCallback:
                                      (FlTouchEvent event, lineTouch) {
                                    if (!event.isInterestedForInteractions ||
                                        lineTouch == null ||
                                        lineTouch.lineBarSpots == null) {
                                      setState(() {
                                        providertablero.touchedValue = -1;
                                      });
                                      return;
                                    }
                                    final value = lineTouch.lineBarSpots![0].x;
                                    setState(() {
                                      providertablero.touchedValue = value;
                                    });
                                  }),
                              lineBarsData: [
                                providertablero.totalPuntos(),
                                providertablero.puntosGanados(),
                                providertablero.puntosGastados(),
                                providertablero.puntosSinValidar(),
                                providertablero.puntosRechazadosL(),
                              ],
                              minY: 0,
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: bottomTitleWidget,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: leftTitleWidgets,
                                    //interval: providertablero.puntos.first.septiembre.ahorro / 4,
                                    reservedSize: 138,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: const Color(0xffe7e8ec),
                                  strokeWidth: 1,
                                ),
                              ),
                              //maxY: providertablero.puntos.first.septiembre.ahorro,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
