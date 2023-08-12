import 'dart:convert';

class TicketProductoPuntajeGastado {
    TicketProductoPuntajeGastado({
        required this.ticketProductoCollection,
    });

    final TicketProductoCollection ticketProductoCollection;

    factory TicketProductoPuntajeGastado.fromJson(String str) => TicketProductoPuntajeGastado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TicketProductoPuntajeGastado.fromMap(Map<String, dynamic> json) => TicketProductoPuntajeGastado(
        ticketProductoCollection: TicketProductoCollection.fromMap(json["ticket_productoCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "ticket_productoCollection": ticketProductoCollection.toMap(),
    };
}

class TicketProductoCollection {
    TicketProductoCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory TicketProductoCollection.fromJson(String str) => TicketProductoCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TicketProductoCollection.fromMap(Map<String, dynamic> json) => TicketProductoCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
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
        required this.producto,
        required this.ticket,
    });

    final Producto producto;
    final Ticket ticket;

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        producto: Producto.fromMap(json["producto"]),
        ticket: Ticket.fromMap(json["ticket"]),
    );

    Map<String, dynamic> toMap() => {
        "producto": producto.toMap(),
        "ticket": ticket.toMap(),
    };
}

class Producto {
    Producto({
        required this.nombre,
        this.descripcion,
        required this.costo,
        this.imagen,
    });

    final String nombre;
    final String? descripcion;
    final String costo;
    final String? imagen;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "costo": costo,
        "imagen": imagen,
    };
}

class Ticket {
    Ticket({
        required this.id,
        required this.total,
        required this.createdAt,
        required this.perfilUsuario,
    });

    final String id;
    final String total;
    final DateTime createdAt;
    final PerfilUsuario perfilUsuario;

    factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
        perfilUsuario: PerfilUsuario.fromMap(json["perfil_usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "perfil_usuario": perfilUsuario.toMap(),
    };
}

class PerfilUsuario {
    PerfilUsuario({
        required this.nombre,
        required this.apellidos,
        required this.rol,
    });

    final String nombre;
    final String apellidos;
    final Rol rol;

    factory PerfilUsuario.fromJson(String str) => PerfilUsuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PerfilUsuario.fromMap(Map<String, dynamic> json) => PerfilUsuario(
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        rol: Rol.fromMap(json["rol"]),
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "apellidos": apellidos,
        "rol": rol.toMap(),
    };
}

class Rol {
    Rol({
        required this.nombre,
    });

    final String nombre;

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}
