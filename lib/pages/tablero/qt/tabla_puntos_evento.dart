// To parse this JSON data, do
//
//     final tablaPuntosEvento = tablaPuntosEventoFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TablaPuntosEvento {
    TablaPuntosEvento({
        required this.nombre,
        required this.idEvento,
        required this.descripcion,
        required this.puntos,
        required this.fecha,
    });

    final String nombre;
    final int idEvento;
    final String descripcion;
    final int puntos;
    final DateTime fecha;

    factory TablaPuntosEvento.fromJson(String str) => TablaPuntosEvento.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TablaPuntosEvento.fromMap(Map<String, dynamic> json) => TablaPuntosEvento(
        nombre: json["nombre"],
        idEvento: json["id_evento"],
        descripcion: json["descripcion"],
        puntos: json["puntos"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "id_evento": idEvento,
        "descripcion": descripcion,
        "puntos": puntos,
        "fecha": fecha.toIso8601String(),
    };
}
