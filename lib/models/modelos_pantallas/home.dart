import 'dart:convert';

class Home {
  Home({
    required this.cantJefesArea,
    required this.puntosAsignados,
    required this.puntosGastados,
    required this.saldo,
    required this.eventosActuales,
    required this.eventosPasados,
    required this.eventosTotales,
  });

  int cantJefesArea;
  int puntosAsignados;
  int puntosGastados;
  int saldo;
  int eventosActuales;
  int eventosPasados;
  int eventosTotales;

  factory Home.fromJson(String str) => Home.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Home.fromMap(Map<String, dynamic> json) => Home(
        cantJefesArea: json["cant_jefes_area"],
        puntosAsignados: json["puntos_asignados"],
        puntosGastados: json["puntos_gastados"],
        saldo: json["saldo"],
        eventosActuales: json["eventos_activos"],
        eventosPasados: json["eventos_pasados"],
        eventosTotales: json["total_eventos"],
      );

  Map<String, dynamic> toMap() => {
        "cant_jefes_area": cantJefesArea,
        "puntos_asignados": puntosAsignados,
        "puntos_gastados": puntosGastados,
        "saldo": saldo,
        "eventos_activos": eventosActuales,
        "eventos_pasados": eventosPasados,
        "total_eventos": eventosTotales,
      };
}
