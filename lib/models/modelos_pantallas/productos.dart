// To parse this JSON data, do
//
//     final productos = productosFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Productos {
  Productos({
    required this.productoId,
    required this.createdAt,
    required this.nombre,
    required this.descripcion,
    required this.costo,
    this.imagen,
  });

  int productoId;
  DateTime createdAt;
  String nombre;
  String descripcion;
  int costo;
  String? imagen;

  factory Productos.fromJson(String str) => Productos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Productos.fromMap(Map<String, dynamic> json) => Productos(
        productoId: json["producto_id"],
        createdAt: DateTime.parse(json["created_at"]),
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toMap() => {
        "producto_id": productoId,
        "created_at": createdAt.toIso8601String(),
        "nombre": nombre,
        "descripcion": descripcion,
        "costo": costo,
        "imagen": imagen,
      };
}
