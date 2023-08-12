// To parse this JSON data, do
//
//     final proveedoresModel = proveedoresModelFromJson(jsonString);

import 'dart:convert';

class ProveedoresModel {
  ProveedoresModel({
    required this.edges,
    required this.typename,
  });

  final List<Edge> edges;
  final String typename;

  factory ProveedoresModel.fromRawJson(String str) => ProveedoresModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProveedoresModel.fromJson(Map<String, dynamic> json) => ProveedoresModel(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
        typename: json["__typename"],
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
        "__typename": typename,
      };
}

class Edge {
  Edge({
    required this.node,
    required this.typename,
  });

  final Node node;
  final String typename;

  factory Edge.fromRawJson(String str) => Edge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: Node.fromJson(json["node"]),
        typename: json["__typename"],
      );

  Map<String, dynamic> toJson() => {
        "node": node.toJson(),
        "__typename": typename,
      };
}

class Node {
  Node({
    required this.codigo,
    required this.typename,
    required this.createdAt,
    this.logoCompania,
    required this.nombreFiscal,
    required this.idCompaniaPk,
    required this.fechaActualizacion,
  });

  final String codigo;
  final String typename;
  final DateTime createdAt;
  final String? logoCompania;
  final String nombreFiscal;
  final String idCompaniaPk;
  final DateTime fechaActualizacion;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        codigo: json["codigo"],
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        logoCompania: json["logo_compania"],
        nombreFiscal: json["nombre_fiscal"],
        idCompaniaPk: json["id_compania_pk"],
        fechaActualizacion: DateTime.parse(json["fecha_actualizacion"]),
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "logo_compania": logoCompania,
        "nombre_fiscal": nombreFiscal,
        "id_compania_pk": idCompaniaPk,
        "fecha_actualizacion": fechaActualizacion.toIso8601String(),
      };
}
