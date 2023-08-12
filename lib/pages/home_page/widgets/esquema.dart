import 'package:flutter/material.dart';
import 'package:dowload_page_apk/theme/theme.dart';

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
                        color: AppTheme.of(context).tertiaryColor,
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
                              text: 'PUNTOS ASIGNADOS : ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).tertiaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' Se refiere a la cantidad de puntos que los empleados han ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'obtenido ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
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
                                color: AppTheme.of(context).primaryText,
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
                        color: AppTheme.of(context).tertiaryColor,
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
                              text: 'PUNTOS DEVENGADOS : ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).tertiaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' Se refiere a la cantidad de puntos que los empleados han ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'gastado ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
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
                                color: AppTheme.of(context).primaryText,
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
                        color: AppTheme.of(context).tertiaryColor,
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
                              text: 'SALDO : ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).tertiaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Es la  ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'diferencia ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' entre los ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'puntos ganados y los puntos gastados ',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'por los empleados.',
                              style: TextStyle(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.017 * MediaQuery.of(context).size.height,
                                color: AppTheme.of(context).primaryText,
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
