// To parse this JSON data, do
//
//     final invitacionesEpc = invitacionesEpcFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class InvitacionesEpp {
  InvitacionesEpp({
    required this.typename,
    required this.invitacionesCollection,
  });

  String typename;
  InvitacionesCollection invitacionesCollection;

  factory InvitacionesEpp.fromJson(String str) => InvitacionesEpp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvitacionesEpp.fromMap(Map<String, dynamic> json) => InvitacionesEpp(
        typename: json["__typename"],
        invitacionesCollection: InvitacionesCollection.fromMap(json["invitacionesCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "__typename": typename,
        "invitacionesCollection": invitacionesCollection.toMap(),
      };
}

class InvitacionesCollection {
  InvitacionesCollection({
    required this.edges,
    required this.typename,
  });

  List<Edge> edges;
  String typename;

  factory InvitacionesCollection.fromJson(String str) => InvitacionesCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvitacionesCollection.fromMap(Map<String, dynamic> json) => InvitacionesCollection(
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
    required this.companias,
    required this.typename,
    required this.createdAt,
    required this.idInvitacionPk,
    required this.estatusProveedor,
    required this.fechaModificacion,
    required this.etiquetaProveedores,
    required this.programaProveedores,
  });

  Companias companias;
  String typename;
  DateTime createdAt;
  String idInvitacionPk;
  EstatusProveedor estatusProveedor;
  DateTime fechaModificacion;
  EtiquetaProveedores etiquetaProveedores;
  ProgramaProveedores programaProveedores;

  factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Node.fromMap(Map<String, dynamic> json) => Node(
        companias: Companias.fromMap(json["companias"]),
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        idInvitacionPk: json["id_invitacion_pk"],
        estatusProveedor: EstatusProveedor.fromMap(json["estatus_Proveedor"]),
        fechaModificacion: DateTime.parse(json["fecha_modificacion"]),
        etiquetaProveedores: EtiquetaProveedores.fromMap(json["etiqueta_Proveedores"]),
        programaProveedores: ProgramaProveedores.fromMap(json["programa_Proveedores"]),
      );

  Map<String, dynamic> toMap() => {
        "companias": companias.toMap(),
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "id_invitacion_pk": idInvitacionPk,
        "estatus_Proveedor": estatusProveedor.toMap(),
        "fecha_modificacion": fechaModificacion.toIso8601String(),
        "etiqueta_Proveedores": etiquetaProveedores.toMap(),
        "programa_Proveedores": programaProveedores.toMap(),
      };
}

class Companias {
  Companias({
    required this.codigo,
    required this.typename,
    required this.createdAt,
    required this.nombreFiscal,
    required this.idCompaniaPk,
    required this.fechaActualizacion,
    required this.logoCompania,
  });

  String codigo;
  String typename;
  DateTime createdAt;
  String nombreFiscal;
  String idCompaniaPk;
  DateTime fechaActualizacion;
  String logoCompania;

  factory Companias.fromJson(String str) => Companias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Companias.fromMap(Map<String, dynamic> json) => Companias(
        codigo: json["codigo"],
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        nombreFiscal: json["nombre_fiscal"],
        idCompaniaPk: json["id_compania_pk"],
        fechaActualizacion: DateTime.parse(json["fecha_actualizacion"]),
        logoCompania: json["logo_compania"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "nombre_fiscal": nombreFiscal,
        "id_compania_pk": idCompaniaPk,
        "fecha_actualizacion": fechaActualizacion.toIso8601String(),
        "logo_compania": logoCompania,
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

class ProgramaProveedores {
  ProgramaProveedores({
    required this.monedas,
    required this.comision,
    required this.companias,
    required this.typename,
    required this.createdAt,
    required this.idProgProvFk,
    required this.nombrePrograma,
  });

  Monedas monedas;
  double comision;
  Companias companias;
  String typename;
  DateTime createdAt;
  String idProgProvFk;
  String nombrePrograma;

  factory ProgramaProveedores.fromJson(String str) => ProgramaProveedores.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProgramaProveedores.fromMap(Map<String, dynamic> json) => ProgramaProveedores(
        monedas: Monedas.fromMap(json["monedas"]),
        comision: json["comision"]?.toDouble(),
        companias: Companias.fromMap(json["companias"]),
        typename: json["__typename"],
        createdAt: DateTime.parse(json["created_at"]),
        idProgProvFk: json["id_progProv_fk"],
        nombrePrograma: json["nombre_programa"],
      );

  Map<String, dynamic> toMap() => {
        "monedas": monedas.toMap(),
        "comision": comision,
        "companias": companias.toMap(),
        "__typename": typename,
        "created_at": createdAt.toIso8601String(),
        "id_progProv_fk": idProgProvFk,
        "nombre_programa": nombrePrograma,
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
