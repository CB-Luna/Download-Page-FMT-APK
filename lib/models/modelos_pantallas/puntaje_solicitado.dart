// To parse this JSON data, do
//
//     final puntajeSolicitado = puntajeSolicitadoFromMap(jsonString);

import 'dart:convert';

class PuntajeSolicitado {
  PuntajeSolicitado({
    required this.usuario,
    required this.evento,
    required this.puntajeSolicitadoId,
    required this.imagen,
    required this.fechaRegistro,
  });

  UsuarioEvento usuario;
  Evento evento;
  int puntajeSolicitadoId;
  String imagen;
  DateTime fechaRegistro;

  factory PuntajeSolicitado.fromJson(String str) =>
      PuntajeSolicitado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PuntajeSolicitado.fromMap(Map<String, dynamic> json) =>
      PuntajeSolicitado(
          usuario: UsuarioEvento.fromMap(json["usuario"]),
          evento: Evento.fromMap(json["evento"]),
          puntajeSolicitadoId: json["puntaje_solicitado_id"],
          imagen: json["imagen"],
          fechaRegistro: DateTime.parse(json['fecha_registro']));

  Map<String, dynamic> toMap() => {
        "usuario": usuario.toMap(),
        "evento": evento.toMap(),
        "puntaje_solicitado_id": puntajeSolicitadoId,
        "imagen": imagen,
      };
}

class Evento {
  Evento({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.puntos,
  });

  int id;
  String nombre;
  DateTime fecha;
  int puntos;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        id: json["id"],
        nombre: json["nombre"],
        fecha: json['fecha'] != null
            ? DateTime.parse(json['fecha'])
            : DateTime.now(),
        puntos: json['puntaje_asistencia'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}

class UsuarioEvento {
  UsuarioEvento({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.area,
    required this.jefeDeArea,
  });

  String id;
  String nombre;
  String apellidos;
  String area;
  String jefeDeArea;

  String get nombreCompleto => '$nombre $apellidos';

  factory UsuarioEvento.fromJson(String str) =>
      UsuarioEvento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioEvento.fromMap(Map<String, dynamic> json) => UsuarioEvento(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        area: json['area'],
        jefeDeArea: json['jefe_de_area'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
      };
}
