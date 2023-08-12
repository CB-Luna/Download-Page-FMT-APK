import 'dart:convert';

class RolApi {
  RolApi({
    required this.nombreRol,
    required this.rolId,
    required this.permisos,
  });

  int rolId;
  String nombreRol;
  Permisos permisos;

  factory RolApi.fromJson(String str) => RolApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolApi.fromMap(Map<String, dynamic> json) => RolApi(
        nombreRol: json["nombre"],
        rolId: json["rol_id"],
        permisos: Permisos.fromMap(json["permisos"]),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombreRol,
        "rol_id": rolId,
        "permisos": permisos.toMap(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RolApi &&
        other.nombreRol == nombreRol &&
        other.rolId == rolId;
  }

  @override
  int get hashCode => Object.hash(nombreRol, rolId, permisos);
}

class Permisos {
  Permisos({
    required this.home,
    required this.administracionDeUsuarios,
    required this.perfilDeUsuario,
    required this.jefesArea,
    required this.saldo,
    required this.historial,
    required this.productos,
    required this.eCommerce,
    required this.eventos,
    required this.empleados,
    required this.validacionPuntaje,
  });

  String? home;
  String? administracionDeUsuarios;
  String? perfilDeUsuario;
  String? jefesArea;
  String? saldo;
  String? historial;
  String? productos;
  String? eCommerce;
  String? eventos;
  String? empleados;
  String? validacionPuntaje;

  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        home: json['Home'],
        administracionDeUsuarios: json["Administración de Usuarios"],
        perfilDeUsuario: json["Perfil de Usuario"],
        jefesArea: json['Jefes de Área'],
        saldo: json['Saldo'],
        historial: json['Historial'],
        productos: json['Productos'],
        eCommerce: json['eCommerce'],
        eventos: json['Eventos'],
        empleados: json['Empleados'],
        validacionPuntaje: json['Validación de Puntaje'],
      );

  Map<String, dynamic> toMap() => {
        "Home": home,
        "Administracion de Usuarios": administracionDeUsuarios,
        "Perfil de Usuario": perfilDeUsuario,
        "Validación de Puntaje": validacionPuntaje,
      };
}
