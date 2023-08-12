// To parse this JSON data, do
//
//     final graficaPuntosMes = graficaPuntosMesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class GraficaPuntosMes {
    GraficaPuntosMes({
        required this.saldoFinal,
        required this.puntosGanados,
        required this.puntosGastado,
        required this.puntosRechazados,
        required this.puntosSinValidar,
    });

    final double saldoFinal;
    final double puntosGanados;
    final double puntosGastado;
    final double puntosRechazados;
    final double puntosSinValidar;

    factory GraficaPuntosMes.fromJson(String str) => GraficaPuntosMes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GraficaPuntosMes.fromMap(Map<String, dynamic> json) => GraficaPuntosMes(
        saldoFinal: json["Saldo Final"],
        puntosGanados: json["Puntos Ganados"],
        puntosGastado: json["Puntos Gastado"],
        puntosRechazados: json["Puntos Rechazados"],
        puntosSinValidar: json["Puntos sin Validar"],
    );

    Map<String, dynamic> toMap() => {
        "Saldo Final": saldoFinal,
        "Puntos Ganados": puntosGanados,
        "Puntos Gastado": puntosGastado,
        "Puntos Rechazados": puntosRechazados,
        "Puntos sin Validar": puntosSinValidar,
    };
}
