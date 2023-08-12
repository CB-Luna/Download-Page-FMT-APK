import 'dart:convert';

class TicketPuntajeGastado {
    TicketPuntajeGastado({
        required this.puntajegastadoCollection,
    });

    final PuntajeGastadoCollection puntajegastadoCollection;

    factory TicketPuntajeGastado.fromJson(String str) => TicketPuntajeGastado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TicketPuntajeGastado.fromMap(Map<String, dynamic> json) => TicketPuntajeGastado(
        puntajegastadoCollection: PuntajeGastadoCollection.fromMap(json["puntaje_gastadoCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "puntaje_gastadoCollection": puntajegastadoCollection.toMap(),
    };
}

class PuntajeGastadoCollection {
    PuntajeGastadoCollection({
        required this.edges,
    });

    final List<Edge?> edges;

    factory PuntajeGastadoCollection.fromJson(String str) => PuntajeGastadoCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PuntajeGastadoCollection.fromMap(Map<String, dynamic> json) => PuntajeGastadoCollection(
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
        required this.monto,
        required this.idTicket,
        required this.createdAt,
    });

    final String monto;
    final String idTicket;
    final DateTime createdAt;

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        monto: json["monto"],
        idTicket: json["id_ticket"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "monto": monto,
        "id_ticket": idTicket,
        "created_at": createdAt.toIso8601String(),
    };
}
