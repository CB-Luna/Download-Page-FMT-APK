import 'dart:convert';

import 'package:dowload_page_apk/models/models.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.idSecuencial,
    required this.email,
    required this.nombre,
    required this.apellidos,
    this.imagen,
    required this.rol,
  });

  String id;
  int idSecuencial;
  String email;
  String nombre;
  String apellidos;
  String? imagen;
  RolApi rol;

  String get nombreCompleto => '$nombre $apellidos';

  bool get esAdministrador => rol.nombreRol == 'Administrador';

  bool get esEmpleado => rol.nombreRol == 'Empleado';

  bool get esJefeDeArea => rol.nombreRol == 'Jefe de Área';

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  factory Usuario.fromMap(Map<String, dynamic> json) {
    Usuario usuario = Usuario(
      id: json["id"],
      idSecuencial: json["id_secuencial"],
      email: json["email"],
      nombre: json["nombre"],
      apellidos: json["apellidos"],
      imagen: json['imagen'],
      rol: RolApi.fromJson(jsonEncode(json['rol'])),
    );
    return usuario;
  }

  Usuario copyWith({
    String? id,
    int? idSecuencial,
    String? email,
    String? nombre,
    String? apellidos,
    String? imagen,
    RolApi? rol,
  }) {
    return Usuario(
      id: id ?? this.id,
      idSecuencial: idSecuencial ?? this.idSecuencial,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      imagen: imagen ?? this.imagen,
      rol: rol ?? this.rol,
    );
  }
}
