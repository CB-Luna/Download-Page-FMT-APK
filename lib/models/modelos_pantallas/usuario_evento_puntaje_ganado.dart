import 'dart:convert';

class UsuarioEventoPuntajeGanado {
    UsuarioEventoPuntajeGanado({
        required this.puntajeGanadoCollection,
    });

    final PuntajeGanadoCollection puntajeGanadoCollection;

    factory UsuarioEventoPuntajeGanado.fromJson(String str) => UsuarioEventoPuntajeGanado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioEventoPuntajeGanado.fromMap(Map<String, dynamic> json) => UsuarioEventoPuntajeGanado(
        puntajeGanadoCollection: PuntajeGanadoCollection.fromMap(json["puntaje_ganadoCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "puntaje_ganadoCollection": puntajeGanadoCollection.toMap(),
    };
}

class PuntajeGanadoCollection {
    PuntajeGanadoCollection({
        required this.edges,
    });

    final List<Edge?> edges;

    factory PuntajeGanadoCollection.fromJson(String str) => PuntajeGanadoCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PuntajeGanadoCollection.fromMap(Map<String, dynamic> json) => PuntajeGanadoCollection(
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
        required this.createdAt,
        required this.monto,
        required this.usuarioEvento,
    });

    final String id;
    final DateTime createdAt;
    final String monto;
    final UsuarioEvento usuarioEvento;

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        monto: json["monto"],
        usuarioEvento: UsuarioEvento.fromMap(json["usuario_evento"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "monto": monto,
        "usuario_evento": usuarioEvento.toMap(),
    };
}

class UsuarioEvento {
    UsuarioEvento({
        required this.evento,
        required this.perfilUsuario,
    });

    final Evento evento;
    final PerfilUsuario perfilUsuario;

    factory UsuarioEvento.fromJson(String str) => UsuarioEvento.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioEvento.fromMap(Map<String, dynamic> json) => UsuarioEvento(
        evento: Evento.fromMap(json["evento"]),
        perfilUsuario: PerfilUsuario.fromMap(json["perfil_usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "evento": evento.toMap(),
        "perfil_usuario": perfilUsuario.toMap(),
    };
}

class Evento {
    Evento({
        required this.eventoId,
        required this.nombre,
        this.imagen,
        required this.descripcion,
        required this.fecha,
        required this.puntajeAsistencia,
    });

    final String eventoId;
    final String nombre;
    final String? imagen;
    final String descripcion;
    final DateTime fecha;
    final String puntajeAsistencia;

    factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        eventoId: json["evento_id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        fecha: DateTime.parse(json["fecha"]),
        puntajeAsistencia: json["puntaje_asistencia"],
    );

    Map<String, dynamic> toMap() => {
        "evento_id": eventoId,
        "nombre": nombre,
        "imagen": imagen,
        "descripcion": descripcion,
        "fecha": fecha.toIso8601String(),
        "puntaje_asistencia": puntajeAsistencia,
    };
}

class PerfilUsuario {
    PerfilUsuario({
        required this.nombre,
        required this.apellidos,
        required this.rol,
        required this.areas,
    });

    final String nombre;
    final String apellidos;
    final Rol rol;
    final Areas areas;

    factory PerfilUsuario.fromJson(String str) => PerfilUsuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PerfilUsuario.fromMap(Map<String, dynamic> json) => PerfilUsuario(
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        rol: Rol.fromMap(json["rol"]),
        areas: Areas.fromMap(json["areas"]),
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "apellidos": apellidos,
        "rol": rol.toMap(),
        "areas": areas.toMap(),
    };
}

class Areas {
    Areas({
        required this.idAreaPk,
        required this.nombreArea,
    });

    final String idAreaPk;
    final String nombreArea;

    factory Areas.fromJson(String str) => Areas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Areas.fromMap(Map<String, dynamic> json) => Areas(
        idAreaPk: json["id_area_pk"],
        nombreArea: json["nombre_area"],
    );

    Map<String, dynamic> toMap() => {
        "id_area_pk": idAreaPk,
        "nombre_area": nombreArea,
    };
}

class Rol {
    Rol({
        required this.rolId,
        required this.nombre,
    });

    final String rolId;
    final String nombre;

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        rolId: json["rol_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "rol_id": rolId,
        "nombre": nombre,
    };
}
