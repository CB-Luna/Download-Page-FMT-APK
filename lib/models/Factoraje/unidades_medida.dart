// To parse this JSON data, do
//
//     final unidadesMedida = unidadesMedidaFromJson(jsonString);

import 'dart:convert';

class UnidadesMedidaDD {
  UnidadesMedidaDD({
    required this.typename,
    required this.unidadesMedidaCollection,
  });

  final String typename;
  final UnidadesMedidaDDCollection unidadesMedidaCollection;

  factory UnidadesMedidaDD.fromRawJson(String str) => UnidadesMedidaDD.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnidadesMedidaDD.fromJson(Map<String, dynamic> json) => UnidadesMedidaDD(
        typename: json["__typename"],
        unidadesMedidaCollection: UnidadesMedidaDDCollection.fromJson(json["unidades_MedidaCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "unidades_MedidaCollection": unidadesMedidaCollection.toJson(),
      };
}

class UnidadesMedidaDDCollection {
  UnidadesMedidaDDCollection({
    required this.typename,
    required this.edges,
  });

  final String typename;
  final List<Edge> edges;

  factory UnidadesMedidaDDCollection.fromRawJson(String str) => UnidadesMedidaDDCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnidadesMedidaDDCollection.fromJson(Map<String, dynamic> json) => UnidadesMedidaDDCollection(
        typename: json["__typename"],
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class Edge {
  Edge({
    required this.typename,
    required this.node,
  });

  final String typename;
  final Node node;

  factory Edge.fromRawJson(String str) => Edge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        typename: json["__typename"],
        node: Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "node": node.toJson(),
      };
}

class Node {
  Node({
    required this.typename,
    required this.idUnidadPk,
    required this.nombreUnidad,
  });

  final String typename;
  final String idUnidadPk;
  final String nombreUnidad;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        typename: json["__typename"],
        idUnidadPk: json["id_unidad_pk"],
        nombreUnidad: json["nombre_unidad"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id_unidad_pk": idUnidadPk,
        "nombre_unidad": nombreUnidad,
      };
}
