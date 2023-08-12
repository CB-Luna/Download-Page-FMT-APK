// To parse this JSON data, do
//
//     final graficaPuntosTotales = graficaPuntosTotalesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class GraficaPuntosTotales {
    GraficaPuntosTotales({
        required this.totalPuntos,
        required this.puntosGanados,
        required this.puntosGastados,
        required this.puntosSinValidar,
        required this.puntosRechazados,
        required this.mes,
        required this.numeroMes,
    });

    final double totalPuntos;
    final double puntosGanados;
    final double puntosGastados;
    final double puntosSinValidar;
    final double puntosRechazados;
    final String mes;
    final int numeroMes;

    factory GraficaPuntosTotales.fromJson(String str) => GraficaPuntosTotales.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GraficaPuntosTotales.fromMap(Map<String, dynamic> json) => GraficaPuntosTotales(
        totalPuntos: json["Total Puntos"],
        puntosGanados: json["Puntos Ganados"],
        puntosGastados: json["Puntos Gastados"],
        puntosSinValidar: json["Puntos sin Validar"],
        puntosRechazados: json["Puntos Rechazados"],
        mes: json["Mes"],
        numeroMes: json["Numero_Mes"],
    );

    Map<String, dynamic> toMap() => {
        "Total Puntos": totalPuntos,
        "Puntos Ganados": puntosGanados,
        "Puntos Gastados": puntosGastados,
        "Puntos sin Validar": puntosSinValidar,
        "Puntos Rechazados": puntosRechazados,
        "Mes": mes,
        "Numero_Mes": numeroMes,
    };
}
