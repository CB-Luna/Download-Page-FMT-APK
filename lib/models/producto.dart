class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final int costo;
  final bool seleccionado;
  final bool activo;
  String? categoria; //tipo de producto
  String? imagenurl;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.costo,
    required this.seleccionado,
    required this.activo,
    this.categoria,
    this.imagenurl,
  });

  Producto copyWith(
      {String? id,
      String? nombre,
      String? descripcion,
      int? costo,
      String? categoria,
      bool? seleccionado,
      bool? activo,
      String? imagenurl}) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      costo: costo ?? this.costo,
      categoria: categoria ?? this.categoria,
      seleccionado: seleccionado ?? this.seleccionado,
      activo: activo ?? this.activo,
      imagenurl: imagenurl ?? this.imagenurl,
    );
  }
}
