// To parse this JSON data, do
//
//     final empleados = empleadosFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Empleados {
  Empleados({
    required this.perfilUsuarioId,
    required this.createdAt,
    required this.idSecuencial,
    required this.nombre,
    required this.apellidos,
    required this.email,
    this.imagen,
    required this.rolFk,
    this.jefeAreaFk,
    this.nombreJefeAsignado,
    required this.nombreArea,
  });

  String perfilUsuarioId;
  DateTime createdAt;
  int idSecuencial;
  String nombre;
  String apellidos;
  String email;
  String? imagen;
  int rolFk;
  String? jefeAreaFk;
  String? nombreJefeAsignado;
  String nombreArea;

  factory Empleados.fromJson(String str) => Empleados.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empleados.fromMap(Map<String, dynamic> json) => Empleados(
        perfilUsuarioId: json["perfil_usuario_id"],
        createdAt: DateTime.parse(json["created_at"]),
        idSecuencial: json["id_secuencial"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        email: json["email"],
        imagen: json["imagen"],
        rolFk: json["rol_fk"],
        jefeAreaFk: json["jefe_area_fk"],
        nombreJefeAsignado: json["nombre_jefe_asignado"],
        nombreArea: json["nombre_area"],
      );

  Map<String, dynamic> toMap() => {
        "perfil_usuario_id": perfilUsuarioId,
        "created_at": createdAt.toIso8601String(),
        "id_secuencial": idSecuencial,
        "nombre": nombre,
        "apellidos": apellidos,
        "email": email,
        "imagen": imagen,
        "rol_fk": rolFk,
        "jefe_area_fk": jefeAreaFk,
        "nombre_jefe_asignado": nombreJefeAsignado,
        "nombre_area": nombreArea,
      };
}
