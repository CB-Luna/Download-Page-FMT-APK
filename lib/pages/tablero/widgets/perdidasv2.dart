import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/functions/money_format.dart';
import 'package:dowload_page_apk/pages/tablero/samples/indicator.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/tablero_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class PerdidasABV2 extends StatefulWidget {
  const PerdidasABV2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PerdidasABV2State();
}

class PerdidasABV2State extends State<PerdidasABV2> {
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('$value',
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
    String text, desc;
    switch (value.toInt()) {
      case 0:
        text = 'Saldo Final';
        desc = 'Representa la diferencia entre los puntos ganados y gastados';
        break;
      case 1:
        text = 'Puntos Ganados';
        desc = 'Representa la suma de puntos que se fueron otorgados';
        break;
      case 2:
        text = 'Puntos Gastados';
        desc = 'Representa los puntos que fueron gastados por productos';
        break;
      case 3:
        text = 'Puntos Sin Validar';
        desc =
            'Representa la suma de puntos que se estan en proceso de ser asignados';
        break;
      case 4:
        text = 'Puntos Rechazados';
        desc = 'Representa los puntos que fueron rechazados';
        break;
      default:
        text = '';
        desc = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Tooltip(
        textAlign: TextAlign.center,
        message: desc,
        child: TextButton(
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
          onPressed: (() {
            switch (value.toInt()) {
              case 0:
                break;
              case 1:
                providertablero.condiciontabla = 0;
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
                break;
              case 2:
                providertablero.condiciontabla = 3;
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
                break;
              case 3:
                providertablero.condiciontabla = 1;
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
                break;
              case 4:
                providertablero.condiciontabla = 2;
                providertablero.tablaPuntosGanados();
                providertablero.tablaCompras();
                break;
            }
          }),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Gotham-Regular',
              fontWeight: FontWeight.normal,
              color: AppTheme.of(context).primaryText,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TableroStateProvider providertablero =
        Provider.of<TableroStateProvider>(context);
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
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                providertablero.mesFinPerdidas == ""
                    ? Text(
                        'Puntos Mensual: ${providertablero.mes} ',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).textoResaltado.override(
                              fontFamily: 'Gotham-Bold',
                              color: AppTheme.of(context).primaryColor,
                              fontSize: 25,
                              useGoogleFonts: false,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Text(
                        'Puntos Mensuales: ${providertablero.mes} - ${providertablero.mesFinPerdidas}',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).textoResaltado.override(
                              fontFamily: 'Gotham-Bold',
                              color: AppTheme.of(context).primaryColor,
                              fontSize: 25,
                              useGoogleFonts: false,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: AnimatedHoverButton(
                      tooltip: 'Descargar',
                      primaryColor: AppTheme.of(context).primaryColor,
                      secondaryColor: AppTheme.of(context).primaryBackground,
                      icon: Icons.download_outlined,
                      onTap: () {
                        providertablero.excelPuntosMensuales();
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
                    //color: providertablero.facturacionNormalPerdidas,
                    text: 'Saldo Final',
                    //isSquare: false,
                    // size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Falta de Fondos',
                    primaryColor: providertablero.facturacionNormalPerdidas,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() => providertablero.pickFaltaFondos(context)),
                    colorGrafica: providertablero.facturacionNormalPerdidas,
                  ),
                  const SizedBox(
                    width: 50,
                    height: 30,
                  ),
                  Indicator(
                    //color: providertablero.cAhorroPerdidas,
                    text: 'Puntos Ganados',
                    //isSquare: false,
                    // size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Puntos Ganados',
                    primaryColor: providertablero.cAhorroPerdidas,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() => providertablero.pickNcNoRecibidas(context)),
                    colorGrafica: providertablero.cAhorroPerdidas,
                  ),
                  const SizedBox(width: 50, height: 30),
                  Indicator(
                    //color: providertablero.ahorroPullNpPerdidas,
                    text: 'Puntos Gastados',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Puntos Gastados',
                    primaryColor: providertablero.ahorroPullNpPerdidas,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() => providertablero.pickAdeudosNC(context)),
                    colorGrafica: providertablero.ahorroPullNpPerdidas,
                  ),
                  Indicator(
                    //color: providertablero.ahorroPullPnPerdidas,
                    text: 'Puntos sin Validar',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Puntos sin Validar',
                    primaryColor: providertablero.ahorroPullPnPerdidas,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() =>
                        providertablero.pickPropuestasRechazadas(context)),
                    colorGrafica: providertablero.ahorroPullPnPerdidas,
                  ),
                  const SizedBox(width: 50, height: 30),
                  Indicator(
                    //color: providertablero.ahorroPushNPPerdidas,
                    text: 'Puntos Rechazados',
                    //isSquare: false,
                    //size: 15,
                    textColor: AppTheme.of(context).primaryText,
                    tooltip: 'Seleccionar Color Puntos Rechazados',
                    primaryColor: providertablero.ahorroPushNPPerdidas,
                    secondaryColor: AppTheme.of(context).primaryBackground,
                    icon: Icons.palette_outlined,
                    onTap: (() =>
                        providertablero.pickPropuestasSinRespuesta(context)),
                    colorGrafica: providertablero.ahorroPushNPPerdidas,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
            child: SizedBox(
              width: .85 * MediaQuery.of(context).size.width,
              height: 200,
              child: providertablero.pmes.isEmpty
                  ? SpinKitFadingCircle(
                      color: AppTheme.of(context).primaryColor,
                      size: 80,
                    )
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                String ace;
                                String rec;
                                switch (group.x.toInt()) {
                                  case 0:
                                    ace = moneyFormat(
                                        providertablero.pmes.first.saldoFinal);
                                    providertablero.pmes.first.saldoFinal == 0
                                        ? rec = '${moneyFormat(0)} %'
                                        : rec = moneyFormat((providertablero
                                                .pmes.first.saldoFinal) /
                                            ((providertablero
                                                    .pmes.first.saldoFinal) +
                                                providertablero
                                                    .pmes.first.puntosGanados +
                                                providertablero
                                                    .pmes.first.puntosGastado +
                                                providertablero.pmes.first
                                                    .puntosRechazados +
                                                providertablero.pmes.first
                                                    .puntosSinValidar) *
                                            100);
                                    break;
                                  case 1:
                                    ace = moneyFormat(providertablero
                                        .pmes.first.puntosGanados);
                                    providertablero
                                                .pmes.first.puntosGanados ==
                                            0
                                        ? rec = '${moneyFormat(0)} %'
                                        : rec = moneyFormat((providertablero
                                                .pmes.first.puntosGanados) /
                                            ((providertablero
                                                    .pmes.first.saldoFinal) +
                                                providertablero
                                                    .pmes.first.puntosGanados +
                                                providertablero
                                                    .pmes.first.puntosGastado +
                                                providertablero.pmes.first
                                                    .puntosRechazados +
                                                providertablero.pmes.first
                                                    .puntosSinValidar) *
                                            100);
                                    break;
                                  case 2:
                                    ace = moneyFormat(providertablero
                                        .pmes.first.puntosGastado);
                                    providertablero
                                                .pmes.first.puntosGastado ==
                                            0
                                        ? rec = '${moneyFormat(0)} %'
                                        : rec = moneyFormat((providertablero
                                                .pmes.first.puntosGastado) /
                                            ((providertablero
                                                    .pmes.first.saldoFinal) +
                                                providertablero
                                                    .pmes.first.puntosGanados +
                                                providertablero
                                                    .pmes.first.puntosGastado +
                                                providertablero.pmes.first
                                                    .puntosRechazados +
                                                providertablero.pmes.first
                                                    .puntosSinValidar) *
                                            100);
                                    break;
                                  case 3:
                                    ace = moneyFormat(providertablero
                                        .pmes.first.puntosSinValidar);
                                    providertablero
                                                .pmes.first.puntosSinValidar ==
                                            0
                                        ? rec = '${moneyFormat(0)} %'
                                        : rec = moneyFormat((providertablero.pmes
                                                .first.puntosSinValidar) /
                                            ((providertablero
                                                    .pmes.first.saldoFinal) +
                                                providertablero
                                                    .pmes.first.puntosGanados +
                                                providertablero
                                                    .pmes.first.puntosGastado +
                                                providertablero.pmes.first
                                                    .puntosRechazados +
                                                providertablero.pmes.first
                                                    .puntosSinValidar) *
                                            100);
                                    break;
                                  case 4:
                                    ace = moneyFormat(providertablero
                                        .pmes.first.puntosRechazados);
                                    providertablero
                                                .pmes.first.puntosRechazados ==
                                            0
                                        ? rec = '${moneyFormat(0)} %'
                                        : rec = moneyFormat((providertablero.pmes
                                                .first.puntosRechazados) /
                                            ((providertablero
                                                    .pmes.first.saldoFinal) +
                                                providertablero
                                                    .pmes.first.puntosGanados +
                                                providertablero
                                                    .pmes.first.puntosGastado +
                                                providertablero.pmes.first
                                                    .puntosRechazados +
                                                providertablero.pmes.first
                                                    .puntosSinValidar) *
                                            100);
                                    break;
                                  default:
                                    throw Error();
                                }
                                return BarTooltipItem(
                                  '\$ $ace \n $rec%',
                                  TextStyle(
                                    color: AppTheme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                );
                              }),
                          touchCallback:
                              (FlTouchEvent event, barTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  barTouchResponse == null ||
                                  barTouchResponse.spot == null) {
                                providertablero.touchedIndex = -1;
                                return;
                              }
                              providertablero.touchedIndex =
                                  barTouchResponse.spot!.touchedBarGroupIndex;
                            });
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: bottomTitleWidget),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 140,
                              getTitlesWidget: leftTitleWidgets,
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
                          checkToShowHorizontalLine: (value) => value % 10 == 0,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: const Color(0xffe7e8ec),
                            strokeWidth: 1,
                          ),
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        groupsSpace: 50,
                        barGroups: [
                          providertablero.faltaFondos(
                              0, (providertablero.pmes.first.saldoFinal)),
                          providertablero.ncNoRecididas(
                              1, providertablero.pmes.first.puntosGanados),
                          providertablero.adeudosNC(
                              2, providertablero.pmes.first.puntosGastado),
                          providertablero.puntosPendientes(
                              3, providertablero.pmes.first.puntosSinValidar),
                          providertablero.puntosRechazados(
                              4, providertablero.pmes.first.puntosRechazados),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
