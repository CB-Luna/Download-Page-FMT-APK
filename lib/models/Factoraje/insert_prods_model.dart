// To parse this JSON data, do
//
//     final insertProdsModel = insertProdsModelFromJson(jsonString);

import 'dart:convert';

class InsertProdsModel {
  InsertProdsModel({
    required this.typename,
    required this.insertIntoProductosCollection,
  });

  final String typename;
  final InsertIntoProductosCollection insertIntoProductosCollection;

  factory InsertProdsModel.fromRawJson(String str) => InsertProdsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsertProdsModel.fromJson(Map<String, dynamic> json) => InsertProdsModel(
        typename: json["__typename"],
        insertIntoProductosCollection: InsertIntoProductosCollection.fromJson(json["insertIntoProductosCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "insertIntoProductosCollection": insertIntoProductosCollection.toJson(),
      };
}

class InsertIntoProductosCollection {
  InsertIntoProductosCollection({
    required this.records,
    required this.typename,
  });

  final List<Record> records;
  final String typename;

  factory InsertIntoProductosCollection.fromRawJson(String str) => InsertIntoProductosCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsertIntoProductosCollection.fromJson(Map<String, dynamic> json) => InsertIntoProductosCollection(
        records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        typename: json["__typename"],
      );

  Map<String, dynamic> toJson() => {
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "__typename": typename,
      };
}

class Record {
  Record({
    required this.total,
    required this.idItem,
    required this.cantidad,
    required this.impuestos,
    required this.typename,
    required this.descripcion,
    required this.idUnidadFk,
    required this.idDocumentoFk,
    required this.precioUnitario,
  });

  final double total;
  final String idItem;
  final String cantidad;
  final int impuestos;
  final String typename;
  final String descripcion;
  final String idUnidadFk;
  final String idDocumentoFk;
  final int precioUnitario;

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        total: json["total"]?.toDouble(),
        idItem: json["id_item"],
        cantidad: json["cantidad"],
        impuestos: json["impuestos"],
        typename: json["__typename"],
        descripcion: json["descripcion"],
        idUnidadFk: json["id_unidad_fk"],
        idDocumentoFk: json["id_documento_fk"],
        precioUnitario: json["precio_unitario"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "id_item": idItem,
        "cantidad": cantidad,
        "impuestos": impuestos,
        "__typename": typename,
        "descripcion": descripcion,
        "id_unidad_fk": idUnidadFk,
        "id_documento_fk": idDocumentoFk,
        "precio_unitario": precioUnitario,
      };
}
