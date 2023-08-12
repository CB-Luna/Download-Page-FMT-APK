import 'dart:convert';

class PedidosSinSolicitar {
  PedidosSinSolicitar({
    required this.idProducto,
    required this.costoProducto,
    required this.nombreProducto,
    required this.descripcionProducto,
    required this.cantidad,
  });

  int idProducto;
  int costoProducto;
  String nombreProducto;
  String descripcionProducto;
  int cantidad;

  factory PedidosSinSolicitar.fromJson(String str) => PedidosSinSolicitar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PedidosSinSolicitar.fromMap(Map<String, dynamic> json) => PedidosSinSolicitar(
        idProducto: json["ID_Producto"],
        costoProducto: json["Costo_producto"],
        nombreProducto: json["Nombre_Producto"],
        descripcionProducto: json["Descripcion_Producto"],
        cantidad: json["Cantidad"],
      );

  Map<String, dynamic> toMap() => {"ID_Producto": idProducto, "Costo_producto": costoProducto, "Nombre_Producto": nombreProducto, "Descripcion_Producto": descripcionProducto, "Cantidad": cantidad};
}
