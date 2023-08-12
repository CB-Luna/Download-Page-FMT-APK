// To parse this JSON data, do
//
//     final insertDocModel = insertDocModelFromJson(jsonString);

import 'dart:convert';

class InsertDocModel {
  InsertDocModel({
    required this.typename,
    required this.insertIntoDocumentosCollection,
  });

  final String typename;
  final InsertIntoDocumentosCollection insertIntoDocumentosCollection;

  factory InsertDocModel.fromRawJson(String str) => InsertDocModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsertDocModel.fromJson(Map<String, dynamic> json) => InsertDocModel(
        typename: json["__typename"],
        insertIntoDocumentosCollection: InsertIntoDocumentosCollection.fromJson(json["insertIntoDocumentosCollection"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "insertIntoDocumentosCollection": insertIntoDocumentosCollection.toJson(),
      };
}

class InsertIntoDocumentosCollection {
  InsertIntoDocumentosCollection({
    required this.records,
    required this.typename,
  });

  final List<Record> records;
  final String typename;

  factory InsertIntoDocumentosCollection.fromRawJson(String str) => InsertIntoDocumentosCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsertIntoDocumentosCollection.fromJson(Map<String, dynamic> json) => InsertIntoDocumentosCollection(
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
    required this.importe,
    required this.mensaje,
    required this.comision,
    required this.typename,
    required this.idMonedaFk,
    required this.idCompCliFk,
    required this.idCompProvFk,
    required this.fechaDocumento,
    required this.idEstatusDocFk,
    required this.idTipoArchivoFk,
    required this.idDocumentoPk,
  });

  final double total;
  final double importe;
  final String mensaje;
  final double comision;
  final String typename;
  final String idMonedaFk;
  final String idCompCliFk;
  final String idCompProvFk;
  final DateTime fechaDocumento;
  final String idEstatusDocFk;
  final String idTipoArchivoFk;
  final String idDocumentoPk;

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        total: json["total"]?.toDouble(),
        importe: json["importe"],
        mensaje: json["mensaje"],
        comision: json["comision"],
        typename: json["__typename"],
        idMonedaFk: json["id_moneda_fk"],
        idCompCliFk: json["id_compCli_fk"],
        idCompProvFk: json["id_compProv_fk"],
        fechaDocumento: DateTime.parse(json["fecha_documento"]),
        idEstatusDocFk: json["id_estatusDoc_fk"],
        idTipoArchivoFk: json["id_tipo_archivo_fk"],
        idDocumentoPk: json["id_documento_pk"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "importe": importe,
        "mensaje": mensaje,
        "comision": comision,
        "__typename": typename,
        "id_moneda_fk": idMonedaFk,
        "id_compCli_fk": idCompCliFk,
        "id_compProv_fk": idCompProvFk,
        "fecha_documento": "${fechaDocumento.year.toString().padLeft(4, '0')}-${fechaDocumento.month.toString().padLeft(2, '0')}-${fechaDocumento.day.toString().padLeft(2, '0')}",
        "id_estatusDoc_fk": idEstatusDocFk,
        "id_tipo_archivo_fk": idTipoArchivoFk,
        "id_documento_pk": idDocumentoPk,
      };
}
