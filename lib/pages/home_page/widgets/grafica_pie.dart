import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class GraficaPie extends StatefulWidget {
  const GraficaPie(
      {Key? key,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.title1,
      required this.title1Color,
      required this.title2,
      required this.title2Color,
      required this.value1,
      required this.value2,
      required this.valorTotal})
      : super(key: key);

  final double width;
  final double height;
  final Color backgroundColor;
  final String title1;
  final Color title1Color;
  final String title2;
  final Color title2Color;
/*   final String title3;
  final Color title3Color;
  final String title4;
  final Color title4Color; */
  //final String title4;
  //final Color title4Color;
  final double value1;
  final double value2;
/*   final double value3;
  final double value4; */
  final double valorTotal;

  @override
  _GraficaPieState createState() => _GraficaPieState();
}

class _GraficaPieState extends State<GraficaPie> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return AspectRatio(
      aspectRatio: deviceType == DeviceScreenType.desktop ? 1.3 : 1.5,
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 0.5 * MediaQuery.of(context).size.height,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: deviceType == DeviceScreenType.desktop
                          ? 0.23 * MediaQuery.of(context).size.height
                          : 0.4 * MediaQuery.of(context).size.height,
                      width: deviceType == DeviceScreenType.desktop
                          ? 0.18 * MediaQuery.of(context).size.width
                          : 0.4 * MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.valorTotal.toString(),
                          style: TextStyle(
                            fontFamily: 'Bicyclette-Light',
                            fontSize: deviceType == DeviceScreenType.desktop
                                ? 0.016 * MediaQuery.of(context).size.width
                                : 0.1 * MediaQuery.of(context).size.width,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.of(context).tertiaryColor,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Puntos',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Bicyclette-Light',
                                fontSize: deviceType == DeviceScreenType.desktop
                                    ? 0.012 * MediaQuery.of(context).size.width
                                    : 0.05 * MediaQuery.of(context).size.width,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Asignados',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Bicyclette-Light',
                                fontSize: deviceType == DeviceScreenType.desktop
                                    ? 0.012 * MediaQuery.of(context).size.width
                                    : 0.05 * MediaQuery.of(context).size.width,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        startDegreeOffset:
                            deviceType == DeviceScreenType.desktop ? 160 : 250,
                        sectionsSpace: 0,
                        centerSpaceRadius: double.infinity,
                        sections: showingSections()),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 0.03 * MediaQuery.of(context).size.width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*             Text(
                'ACTIVOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Bicyclette-Light',
                  fontSize: deviceType == DeviceScreenType.desktop
                      ? 0.014 * MediaQuery.of(context).size.width
                      : 0.03 * MediaQuery.of(context).size.width,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              Divider(), */
              Indicator(
                color: widget.title1Color,
                text: widget.title1,
                isSquare: false,
              ),
              SizedBox(
                height: 0.015 * MediaQuery.of(context).size.height,
              ),
              Indicator(
                color: widget.title2Color,
                text: widget.title2,
                isSquare: false,
              ),
              SizedBox(
                height: 0.015 * MediaQuery.of(context).size.height,
              ),
              /*          Indicator(
                color: widget.title3Color,
                text: widget.title3,
                isSquare: false,
              ),
              SizedBox(
                height: 0.015 * MediaQuery.of(context).size.height,
              ),
              Indicator(
                color: widget.title4Color,
                text: widget.title4,
                isSquare: false,
              ), */
              const SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: widget.title1Color,
            value: widget.value1,
            title: widget.value1.toString() + '',
            radius: radius,
            borderSide: BorderSide(
              width: deviceType == DeviceScreenType.desktop ? 2.0 : 3.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: widget.title2Color,
            value: widget.value2,
            title: widget.value2.toString() + '',
            radius: radius,
            borderSide: BorderSide(
              width: deviceType == DeviceScreenType.desktop ? 2.0 : 3.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        /*      case 2:
          return PieChartSectionData(
            color: widget.title3Color,
            value: widget.value3,
            title: widget.value3.toString() + '',
            radius: radius,
            borderSide: BorderSide(
              width: deviceType == DeviceScreenType.desktop ? 2.0 : 3.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: widget.title4Color,
            value: widget.value4,
            title: widget.value4.toString() + '',
            radius: radius,
            borderSide: BorderSide(
              width: deviceType == DeviceScreenType.desktop ? 2.0 : 3.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          ); */

        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Row(
      children: <Widget>[
        Container(
          width: deviceType == DeviceScreenType.desktop
              ? 0.03 * MediaQuery.of(context).size.width
              : 0.06 * MediaQuery.of(context).size.width,
          height: 0.03 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 0.01 * MediaQuery.of(context).size.width,
        ),
        Text(text,
            style: TextStyle(
                fontSize: deviceType == DeviceScreenType.desktop
                    ? 0.01 * MediaQuery.of(context).size.width
                    : 0.03 * MediaQuery.of(context).size.width,
                fontWeight: FontWeight.bold,
                color: AppTheme.of(context).primaryText))
      ],
    );
  }
}
