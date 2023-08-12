import 'dart:convert';


class SaldoEmpleado {
    SaldoEmpleado({
        required this.saldoCollection,
    });

    final SaldoCollection saldoCollection;

    factory SaldoEmpleado.fromJson(String str) => SaldoEmpleado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SaldoEmpleado.fromMap(Map<String, dynamic> json) => SaldoEmpleado(
        saldoCollection: SaldoCollection.fromMap(json["saldoCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "saldoCollection": saldoCollection.toMap(),
    };
}

class SaldoCollection {
    SaldoCollection({
        required this.edges,
    });

    final List<Edge?> edges;

    factory SaldoCollection.fromJson(String str) => SaldoCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SaldoCollection.fromMap(Map<String, dynamic> json) => SaldoCollection(
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
        required this.id,
        required this.saldo,
        required this.createdAt,
    });

    String id;
    int saldo;
    DateTime createdAt;

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        saldo: int.parse(json["saldo"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "saldo": saldo,
        "created_at": createdAt.toIso8601String(),
    };
}
