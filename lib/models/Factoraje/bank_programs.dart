// To parse this JSON data, do
//
//     final bankPrograms = bankProgramsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BankPrograms {
  BankPrograms({
    required this.edges,
    required this.typename,
  });

  List<Edge> edges;
  String typename;

  factory BankPrograms.fromJson(String str) => BankPrograms.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankPrograms.fromMap(Map<String, dynamic> json) => BankPrograms(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
        "__typename": typename,
      };
}

class Edge {
  Edge({
    required this.node,
    required this.typename,
  });

  Node node;
  String typename;

  factory Edge.fromJson(String str) => Edge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Edge.fromMap(Map<String, dynamic> json) => Edge(
        node: Node.fromMap(json["node"]),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "node": node.toMap(),
        "__typename": typename,
      };
}

class Node {
  Node({
    required this.urlDoc,
    required this.companias,
    required this.typename,
    required this.idBancoFk,
    required this.idProgProvFk,
    required this.nombrePrograma,
    required this.estatusProgramas,
    required this.idEstatusProgFk,
  });

  String urlDoc;
  Companias companias;
  String typename;
  String idBancoFk;
  String idProgProvFk;
  String nombrePrograma;
  EstatusProgramas estatusProgramas;
  String idEstatusProgFk;

  factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Node.fromMap(Map<String, dynamic> json) => Node(
        urlDoc: json["url_doc"],
        companias: Companias.fromMap(json["companias"]),
        typename: json["__typename"],
        idBancoFk: json["id_banco_fk"],
        idProgProvFk: json["id_progProv_fk"],
        nombrePrograma: json["nombre_programa"],
        estatusProgramas: EstatusProgramas.fromMap(json["estatus_Programas"]),
        idEstatusProgFk: json["id_estatus_prog_fk"],
      );

  Map<String, dynamic> toMap() => {
        "url_doc": urlDoc,
        "companias": companias.toMap(),
        "__typename": typename,
        "id_banco_fk": idBancoFk,
        "id_progProv_fk": idProgProvFk,
        "nombre_programa": nombrePrograma,
        "estatus_Programas": estatusProgramas.toMap(),
        "id_estatus_prog_fk": idEstatusProgFk,
      };
}

class Companias {
  Companias({
    required this.codigo,
    required this.typename,
    required this.createdAt,
    required this.logoCompania,
    required this.nombreFiscal,
    required this.idCompaniaPk,
    required this.fechaActualizacion,
  });

  String codigo;
  String typename;
  DateTime createdAt;
  String logoCompania;
  String nombreFiscal;
  String idCompaniaPk;
  DateTime fechaActualizacion;

  factory Companias.fromJson(String str) => Companias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Companias.fromMap(Map<String, dynamic> json) => Companias(
        codigo: json["codigo"],
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        logoCompania: json["logo_compania"],
        nombreFiscal: json["nombre_fiscal"],
        idCompaniaPk: json["id_compania_pk"],
        fechaActualizacion: DateTime.parse(json["fecha_actualizacion"]),
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "logo_compania": logoCompania,
        "nombre_fiscal": nombreFiscal,
        "id_compania_pk": idCompaniaPk,
        "fecha_actualizacion": fechaActualizacion.toIso8601String(),
      };
}

class EstatusProgramas {
  EstatusProgramas({
    required this.typename,
    required this.createdAt,
    required this.nombreEstatus,
    required this.idEstatusProgPk,
  });

  String typename;
  DateTime createdAt;
  String nombreEstatus;
  String idEstatusProgPk;

  factory EstatusProgramas.fromJson(String str) => EstatusProgramas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EstatusProgramas.fromMap(Map<String, dynamic> json) => EstatusProgramas(
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        nombreEstatus: json["nombre_estatus"],
        idEstatusProgPk: json["id_estatus_prog_pk"],
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "nombre_estatus": nombreEstatus,
        "id_estatus_prog_pk": idEstatusProgPk,
      };
}
