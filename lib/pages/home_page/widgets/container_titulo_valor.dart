import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';

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
    return Container(
      width: 0.12 * MediaQuery.of(context).size.width,
      height: 0.12 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: AppTheme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontFamily: 'Bicyclette-Light',
                  fontSize: 0.011 * MediaQuery.of(context).size.width,
                  color: AppTheme.of(context).tertiaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    cantidad!.toInt().round().toString(),
                    style: TextStyle(
                      fontFamily: 'Bicyclette-Light',
                      fontSize: 0.012 * MediaQuery.of(context).size.width,
                      color: AppTheme.of(context).primaryText,
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
