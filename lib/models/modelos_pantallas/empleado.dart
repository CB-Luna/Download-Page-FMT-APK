// To parse this JSON data, do
//
//     final empleado = empleadoFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Empleado {
  Empleado({
    required this.perfilUsuarioId,
    required this.nombre,
    required this.apellidos,
    required this.email,
    this.avatar,
    required this.telefono,
    required this.rol,
    /*    required this.cantidadRegistros, */
    required this.cantidadEmpleados,
    required this.usuarioIdSecuencial,
    required this.appHabilitada,
    required this.laborando,
    required this.area,
  });

  String perfilUsuarioId;
  String nombre;
  String apellidos;
  String email;
  String? avatar;
  String telefono;
  int rol;
  /*  int cantidadRegistros; */
  int cantidadEmpleados;
  int usuarioIdSecuencial;
  bool appHabilitada;
  bool laborando;
  bool expanded = false;
  String area;

  factory Empleado.fromJson(String str) => Empleado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empleado.fromMap(Map<String, dynamic> json) => Empleado(
        perfilUsuarioId: json["perfil_usuario_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        email: json["email"],
        avatar: json["avatar"],
        telefono: json["telefono"],
        rol: json["rol_fk"],
        /*   cantidadRegistros: json["cantidad_registros"], */
        cantidadEmpleados: json["cant_empleados"],
        usuarioIdSecuencial: json["id_usuario_secuencial"],
        appHabilitada: json["app_habilitada"],
        laborando: json["laborando"],
        area: json["nombre_area"],
      );

  Map<String, dynamic> toMap() => {
        "perfil_usuario_id": perfilUsuarioId,
        "nombre": nombre,
        "apellidos": apellidos,
        "email": email,
        "avatar": avatar,
        "telefono": telefono,
        "rol_fk": rol,
        /*   "cantidad_registros": cantidadRegistros, */
        "cant_empleados": cantidadEmpleados,
        "id_usuario_secuencial": usuarioIdSecuencial,
        "app_habilitada": appHabilitada,
        "laborando": laborando,
        "nombre_area": area,
      };
}
