// To parse this JSON data, do
//
//     final jefeArea = jefeAreaFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class JefeArea {
  JefeArea({
    required this.perfilUsuarioId,
    required this.email,
    required this.idSecuencial,
    required this.nombre,
    required this.apellidos,
    this.imagen,
    required this.rolFk,
    required this.idArea,
    required this.nombreArea,
  });

  String perfilUsuarioId;
  String email;
  int idSecuencial;
  String nombre;
  String apellidos;
  String? imagen;
  int rolFk;
  int idArea;
  String nombreArea;

  factory JefeArea.fromJson(String str) => JefeArea.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JefeArea.fromMap(Map<String, dynamic> json) => JefeArea(
        perfilUsuarioId: json["perfil_usuario_id"],
        email: json["email"],
        idSecuencial: json["id_secuencial"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        imagen: json["imagen"],
        rolFk: json["rol_fk"],
        idArea: json["id_area"],
        nombreArea: json["nombre_area"],
      );

  Map<String, dynamic> toMap() => {
        "perfil_usuario_id": perfilUsuarioId,
        "email": email,
        "id_secuencial": idSecuencial,
        "nombre": nombre,
        "apellidos": apellidos,
        "imagen": imagen,
        "rol_fk": rolFk,
        "id_area": idArea,
        "nombre_area": nombreArea,
      };
}
