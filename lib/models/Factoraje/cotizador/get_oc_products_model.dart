// To parse this JSON data, do
//
//     final getOcProductsModel = getOcProductsModelFromJson(jsonString);

import 'dart:convert';

class GetOcProductsModel {
  GetOcProductsModel({
    required this.typename,
    required this.documentosCollection,
  });

  final String typename;
  final DocumentosCollection documentosCollection;

  factory GetOcProductsModel.fromRawJson(String str) => GetOcProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOcProductsModel.fromJson(Map<String, dynamic> json) => GetOcProductsModel(
        typename: json["__typename"],
        documentosCollection: DocumentosCollection.fromJson(json["documentosCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "documentosCollection": documentosCollection.toJson(),
      };
}

class DocumentosCollection {
  DocumentosCollection({
    required this.typename,
    required this.edges,
  });

  final String typename;
  final List<DocumentosCollectionEdge> edges;

  factory DocumentosCollection.fromRawJson(String str) => DocumentosCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentosCollection.fromJson(Map<String, dynamic> json) => DocumentosCollection(
        typename: json["__typename"],
        edges: List<DocumentosCollectionEdge>.from(json["edges"].map((x) => DocumentosCollectionEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class DocumentosCollectionEdge {
  DocumentosCollectionEdge({
    required this.typename,
    required this.node,
  });

  final String typename;
  final PurpleNode node;

  factory DocumentosCollectionEdge.fromRawJson(String str) => DocumentosCollectionEdge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentosCollectionEdge.fromJson(Map<String, dynamic> json) => DocumentosCollectionEdge(
        typename: json["__typename"],
        node: PurpleNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "node": node.toJson(),
      };
}

class PurpleNode {
  PurpleNode({
    required this.typename,
    required this.idDocFk,
    required this.productosCollection,
    required this.mensaje,
    required this.importe,
    required this.monedas,
    required this.comision,
    required this.total,
    required this.idCompCliFk,
  });

  final String typename;
  final int idDocFk;
  final ProductosCollection productosCollection;
  final String mensaje;
  final double importe;
  final Monedas monedas;
  final double comision;
  final double total;
  final String idCompCliFk;

  factory PurpleNode.fromRawJson(String str) => PurpleNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurpleNode.fromJson(Map<String, dynamic> json) => PurpleNode(
        typename: json["__typename"],
        idDocFk: int.parse(json["id_documento_pk"]),
        productosCollection: ProductosCollection.fromJson(json["productosCollection"]),
        mensaje: json["mensaje"],
        importe: json["importe"],
        monedas: Monedas.fromJson(json["monedas"]),
        comision: json["comision"],
        total: json["total"],
        idCompCliFk: json["id_compCli_fk"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id_documento_pk": idDocFk,
        "productosCollection": productosCollection.toJson(),
        "mensaje": mensaje,
        "importe": importe,
        "monedas": monedas.toJson(),
        "comision": comision,
        "total": total,
        "id_compCli_fk": idCompCliFk,
      };
}

class Monedas {
  Monedas({
    required this.typename,
    required this.idMonedaPk,
    required this.nombreMoneda,
  });

  final String typename;
  final String idMonedaPk;
  final String nombreMoneda;

  factory Monedas.fromRawJson(String str) => Monedas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Monedas.fromJson(Map<String, dynamic> json) => Monedas(
        typename: json["__typename"],
        idMonedaPk: json["id_moneda_pk"],
        nombreMoneda: json["nombre_moneda"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id_moneda_pk": idMonedaPk,
        "nombre_moneda": nombreMoneda,
      };
}

class ProductosCollection {
  ProductosCollection({
    required this.typename,
    required this.edges,
  });

  final String typename;
  final List<ProductosCollectionEdge> edges;

  factory ProductosCollection.fromRawJson(String str) => ProductosCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductosCollection.fromJson(Map<String, dynamic> json) => ProductosCollection(
        typename: json["__typename"],
        edges: List<ProductosCollectionEdge>.from(json["edges"].map((x) => ProductosCollectionEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class ProductosCollectionEdge {
  ProductosCollectionEdge({
    required this.typename,
    required this.node,
  });

  final String typename;
  final FluffyNode node;

  factory ProductosCollectionEdge.fromRawJson(String str) => ProductosCollectionEdge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductosCollectionEdge.fromJson(Map<String, dynamic> json) => ProductosCollectionEdge(
        typename: json["__typename"],
        node: FluffyNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "node": node.toJson(),
      };
}

class FluffyNode {
  FluffyNode({
    required this.typename,
    required this.idItem,
    required this.descripcion,
    required this.cantidad,
    required this.unidadesMedida,
    required this.precioUnitario,
    required this.impuestos,
    required this.total,
  });

  final String typename;
  final String idItem;
  final String descripcion;
  final String cantidad;
  final UnidadesMedida unidadesMedida;
  final double precioUnitario;
  final double impuestos;
  final double total;

  factory FluffyNode.fromRawJson(String str) => FluffyNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FluffyNode.fromJson(Map<String, dynamic> json) => FluffyNode(
        typename: json["__typename"],
        idItem: json["id_item"],
        descripcion: json["descripcion"],
        cantidad: json["cantidad"],
        unidadesMedida: UnidadesMedida.fromJson(json["unidades_Medida"]),
        precioUnitario: json["precio_unitario"],
        impuestos: json["impuestos"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id_item": idItem,
        "descripcion": descripcion,
        "cantidad": cantidad,
        "unidades_Medida": unidadesMedida.toJson(),
        "precio_unitario": precioUnitario,
        "impuestos": impuestos,
        "total": total,
      };
}

class UnidadesMedida {
  UnidadesMedida({
    required this.typename,
    required this.idUnidadPk,
    required this.nombreUnidad,
  });

  final String typename;
  final String idUnidadPk;
  final String nombreUnidad;

  factory UnidadesMedida.fromRawJson(String str) => UnidadesMedida.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnidadesMedida.fromJson(Map<String, dynamic> json) => UnidadesMedida(
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
