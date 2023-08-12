// To parse this JSON data, do
//
//     final tablaPuntosGanados = tablaPuntosGanadosFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TablaPuntosGanados {
    TablaPuntosGanados({
        required this.nombre,
        required this.apellido,
        required this.idUsuario,
        required this.montoGanado,
        required this.fechaRegistro,
    });

    final String nombre;
    final String apellido;
    final int idUsuario;
    final int montoGanado;
    final DateTime fechaRegistro;

    factory TablaPuntosGanados.fromJson(String str) => TablaPuntosGanados.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TablaPuntosGanados.fromMap(Map<String, dynamic> json) => TablaPuntosGanados(
        nombre: json["nombre"],
        apellido: json["apellido"],
        idUsuario: json["id_usuario"],
        montoGanado: json["monto_ganado"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "apellido": apellido,
        "id_usuario": idUsuario,
        "monto_ganado": montoGanado,
        "fechaRegistro": fechaRegistro.toIso8601String(),
    };
}
