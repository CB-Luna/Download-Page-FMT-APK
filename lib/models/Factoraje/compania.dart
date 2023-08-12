import 'dart:convert';

class Compania {
  Compania({
    required this.idCompaniaPk,
    required this.nombre,
    this.logoCompania,
  });

  int idCompaniaPk;
  String nombre;
  String? logoCompania;

  factory Compania.fromJson(String str) => Compania.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Compania.fromMap(Map<String, dynamic> json) => Compania(
        idCompaniaPk: json["id_compania_pk"],
        nombre: json["nombre_fiscal"],
        logoCompania: json["logo_compania"],
      );

  Map<String, dynamic> toMap() => {
        "id_compania_pk": idCompaniaPk,
        "nombre_fiscal": nombre,
        "logo_compania": logoCompania,
      };
}
