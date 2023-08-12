import 'dart:convert';

class Eventos {
  Eventos({
    required this.eventoCollection,
  });

  final EventoCollection eventoCollection;

  factory Eventos.fromJson(String str) => Eventos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Eventos.fromMap(Map<String, dynamic> json) => Eventos(
        eventoCollection: EventoCollection.fromMap(json["eventoCollection"]),
      );

  Map<String, dynamic> toMap() => {
        "eventoCollection": eventoCollection.toMap(),
      };
}

class EventoCollection {
  EventoCollection({
    required this.edges,
  });

  final List<Edge?> edges;

  factory EventoCollection.fromJson(String str) =>
      EventoCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventoCollection.fromMap(Map<String, dynamic> json) =>
      EventoCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x?.toMap())),
      };
}

class Edge {
  Edge({
    required this.node,
  });

  final Node node;

  factory Edge.fromJson(String str) => Edge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Edge.fromMap(Map<String, dynamic> json) => Edge(
        node: Node.fromMap(json["node"]),
      );

  Map<String, dynamic> toMap() => {
        "node": node.toMap(),
      };
}

class Node {
  Node({
    required this.nombre,
    required this.eventoId,
    required this.createdAt,
    this.descripcion,
    required this.puntajeAsistencia,
  });

  final String nombre;
  final String eventoId;
  final DateTime createdAt;
  final String? descripcion;
  final int puntajeAsistencia;

  factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Node.fromMap(Map<String, dynamic> json) => Node(
        nombre: json["nombre"],
        eventoId: json["evento_id"],
        createdAt: DateTime.parse(json["created_at"]),
        descripcion: json["descripcion"],
        puntajeAsistencia: int.parse(json["puntaje_asistencia"]),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "evento_id": eventoId,
        "created_at": createdAt.toIso8601String(),
        "descripcion": descripcion,
        "puntaje_asistencia": puntajeAsistencia,
      };
}
