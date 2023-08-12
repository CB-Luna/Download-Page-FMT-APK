import 'dart:convert';

class AreaTrabajo {
  AreaTrabajo({
    required this.idAreaPk,
    required this.nombreArea,
  });

  int idAreaPk;
  String nombreArea;

  factory AreaTrabajo.fromJson(String str) =>
      AreaTrabajo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AreaTrabajo.fromMap(Map<String, dynamic> json) => AreaTrabajo(
        idAreaPk: json["id_area_pk"],
        nombreArea: json["nombre_area"],
      );

  Map<String, dynamic> toMap() => {
        "id_area_pk": idAreaPk,
        "nombre_area": nombreArea,
      };
}
