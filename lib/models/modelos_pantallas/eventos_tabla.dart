import 'dart:convert';

class EventoTabla {
  EventoTabla(
      {required this.id,
      required this.nombre,
      required this.fecha,
      this.imagenEventoTabla,
      this.descripcion,
      required this.puntos});

  int id;
  String nombre;
  DateTime fecha;
  String? imagenEventoTabla = "";
  String? descripcion = "";
  int puntos;
  factory EventoTabla.fromJson(String str) =>
      EventoTabla.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventoTabla.fromMap(Map<String, dynamic> json) => EventoTabla(
      id: json["evento_id"],
      nombre: json["nombre"],
      fecha: json['fecha'] != null
          ? DateTime.parse(json['fecha'])
          : DateTime.now(),
      imagenEventoTabla: json["imagen"],
      descripcion: json["descripcion"],
      puntos: json['puntaje_asistencia']);

  Map<String, dynamic> toMap() => {
        "evento_id": id,
        "nombre": nombre,
        "imagen": imagenEventoTabla,
        "descripcion": descripcion,
        "fecha": fecha.toIso8601String(),
        "puntaje_asistencia": puntos
      };
}
