// To parse this JSON data, do
//
//     final tablaCompras = tablaComprasFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TablaCompras {
    TablaCompras({
        required this.idTicket,
        required this.idProducto,
        required this.descripcion,
        required this.costo,
        required this.fecha,
    });

    final int idTicket;
    final int idProducto;
    final String descripcion;
    final int costo;
    final DateTime fecha;

    factory TablaCompras.fromJson(String str) => TablaCompras.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TablaCompras.fromMap(Map<String, dynamic> json) => TablaCompras(
        idTicket: json["id_ticket"],
        idProducto: json["id_producto"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toMap() => {
        "id_ticket": idTicket,
        "id_producto": idProducto,
        "descripcion": descripcion,
        "costo": costo,
        "fecha": fecha.toIso8601String(),
    };
}
