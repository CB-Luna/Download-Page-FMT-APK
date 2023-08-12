// To parse this JSON data, do
//
//     final invitacionesEpb = invitacionesEpbFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class InvitacionesEpb {
  InvitacionesEpb({
    required this.typename,
    required this.programaProveedoresCollection,
  });

  String typename;
  ProgramaProveedoresCollection programaProveedoresCollection;

  factory InvitacionesEpb.fromJson(String str) => InvitacionesEpb.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvitacionesEpb.fromMap(Map<String, dynamic> json) => InvitacionesEpb(
        typename: json["__typename"],
        programaProveedoresCollection: ProgramaProveedoresCollection.fromMap(json["programa_ProveedoresCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "programa_ProveedoresCollection": programaProveedoresCollection.toMap(),
      };
}

class ProgramaProveedoresCollection {
  ProgramaProveedoresCollection({
    required this.edges,
    required this.typename,
  });

  List<ProgramaProveedoresCollectionEdge> edges;
  String typename;

  factory ProgramaProveedoresCollection.fromJson(String str) => ProgramaProveedoresCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProgramaProveedoresCollection.fromMap(Map<String, dynamic> json) => ProgramaProveedoresCollection(
        edges: List<ProgramaProveedoresCollectionEdge>.from(json["edges"].map((x) => ProgramaProveedoresCollectionEdge.fromMap(x))),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
        "__typename": typename,
      };
}

class ProgramaProveedoresCollectionEdge {
  ProgramaProveedoresCollectionEdge({
    required this.node,
    required this.typename,
  });

  PurpleNode node;
  String typename;

  factory ProgramaProveedoresCollectionEdge.fromJson(String str) => ProgramaProveedoresCollectionEdge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProgramaProveedoresCollectionEdge.fromMap(Map<String, dynamic> json) => ProgramaProveedoresCollectionEdge(
        node: PurpleNode.fromMap(json["node"]),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "node": node.toMap(),
        "__typename": typename,
      };
}

class PurpleNode {
  PurpleNode({
    required this.monedas,
    required this.urlDoc,
    required this.companias,
    required this.typename,
    required this.idProgProvFk,
    required this.nombrePrograma,
    required this.invitacionesCollection,
  });

  Monedas monedas;
  String urlDoc;
  Companias companias;
  String typename;
  String idProgProvFk;
  String nombrePrograma;
  InvitacionesCollection invitacionesCollection;

  factory PurpleNode.fromJson(String str) => PurpleNode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurpleNode.fromMap(Map<String, dynamic> json) => PurpleNode(
        monedas: Monedas.fromMap(json["monedas"]),
        urlDoc: json["url_doc"],
        companias: Companias.fromMap(json["companias"]),
        typename: json["__typename"],
        idProgProvFk: json["id_progProv_fk"],
        nombrePrograma: json["nombre_programa"],
        invitacionesCollection: InvitacionesCollection.fromMap(json["invitacionesCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "monedas": monedas.toMap(),
        "url_doc": urlDoc,
        "companias": companias.toMap(),
        "__typename": typename,
        "id_progProv_fk": idProgProvFk,
        "nombre_programa": nombrePrograma,
        "invitacionesCollection": invitacionesCollection.toMap(),
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

class InvitacionesCollection {
  InvitacionesCollection({
    required this.edges,
    required this.typename,
  });

  List<InvitacionesCollectionEdge> edges;
  String typename;

  factory InvitacionesCollection.fromJson(String str) => InvitacionesCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvitacionesCollection.fromMap(Map<String, dynamic> json) => InvitacionesCollection(
        edges: List<InvitacionesCollectionEdge>.from(json["edges"].map((x) => InvitacionesCollectionEdge.fromMap(x))),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
        "__typename": typename,
      };
}

class InvitacionesCollectionEdge {
  InvitacionesCollectionEdge({
    required this.node,
    required this.typename,
  });

  FluffyNode node;
  String typename;

  factory InvitacionesCollectionEdge.fromJson(String str) => InvitacionesCollectionEdge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvitacionesCollectionEdge.fromMap(Map<String, dynamic> json) => InvitacionesCollectionEdge(
        node: FluffyNode.fromMap(json["node"]),
        typename: json["__typename"],
      );

  Map<String, dynamic> toMap() => {
        "node": node.toMap(),
        "__typename": typename,
      };
}

class FluffyNode {
  FluffyNode({
    required this.companias,
    required this.typename,
    required this.createdAt,
    required this.idInvitacionPk,
    required this.estatusProveedor,
    required this.fechaModificacion,
    required this.etiquetaProveedores,
    this.expanded = false,
  });

  Companias companias;
  String typename;
  DateTime createdAt;
  String idInvitacionPk;
  EstatusProveedor estatusProveedor;
  DateTime fechaModificacion;
  EtiquetaProveedores etiquetaProveedores;
  bool expanded;

  factory FluffyNode.fromJson(String str) => FluffyNode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluffyNode.fromMap(Map<String, dynamic> json) => FluffyNode(
        companias: Companias.fromMap(json["companias"]),
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        idInvitacionPk: json["id_invitacion_pk"],
        estatusProveedor: EstatusProveedor.fromMap(json["estatus_Proveedor"]),
        fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
        etiquetaProveedores: EtiquetaProveedores.fromMap(json["etiqueta_Proveedores"]),
      );

  Map<String, dynamic> toMap() => {
        "companias": companias.toMap(),
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "id_invitacion_pk": idInvitacionPk,
        "estatus_Proveedor": estatusProveedor.toMap(),
        "fecha_modificacion": fechaModificacion.toIso8601String(),
        "etiqueta_Proveedores": etiquetaProveedores.toMap(),
      };
}

class EstatusProveedor {
  EstatusProveedor({
    required this.typename,
    required this.nombreEstatus,
    required this.idEstatusProvPk,
  });

  String typename;
  String nombreEstatus;
  String idEstatusProvPk;

  factory EstatusProveedor.fromJson(String str) => EstatusProveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EstatusProveedor.fromMap(Map<String, dynamic> json) => EstatusProveedor(
        typename: json["__typename"],
        nombreEstatus: json["nombre_estatus"],
        idEstatusProvPk: json["id_estatusProv_pk"],
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "nombre_estatus": nombreEstatus,
        "id_estatusProv_pk": idEstatusProvPk,
      };
}

class EtiquetaProveedores {
  EtiquetaProveedores({
    required this.typename,
    required this.idEtiquetaFk,
    required this.nombreEtiqueta,
  });

  String typename;
  String idEtiquetaFk;
  String nombreEtiqueta;

  factory EtiquetaProveedores.fromJson(String str) => EtiquetaProveedores.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EtiquetaProveedores.fromMap(Map<String, dynamic> json) => EtiquetaProveedores(
        typename: json["__typename"],
        idEtiquetaFk: json["id_etiqueta_fk"],
        nombreEtiqueta: json["nombre_etiqueta"],
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "id_etiqueta_fk": idEtiquetaFk,
        "nombre_etiqueta": nombreEtiqueta,
      };
}

class Monedas {
  Monedas({
    required this.typename,
    required this.idMonedaPk,
    required this.nombreMoneda,
  });

  String typename;
  String idMonedaPk;
  String nombreMoneda;

  factory Monedas.fromJson(String str) => Monedas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Monedas.fromMap(Map<String, dynamic> json) => Monedas(
        typename: json["__typename"],
        idMonedaPk: json["id_moneda_pk"],
        nombreMoneda: json["nombre_moneda"],
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "id_moneda_pk": idMonedaPk,
        "nombre_moneda": nombreMoneda,
      };
}
