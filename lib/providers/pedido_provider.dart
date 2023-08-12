import 'package:flutter/material.dart';

import '../helpers/globals.dart';
import '../models/producto.dart';

class PedidoController with ChangeNotifier {
  List<Producto> _listaProductos = [];
  List<Producto> get listaProductos => _listaProductos;

  PedidoController(double saldoEmp) {
    //Carga de planes obtenidos al momento
    cargarProductos(saldoEmp);
    notifyListeners();
  }

  Future<List<Producto>?> cargarProductos(double saldo) async {
    try {
      final res = await supabase
          .from(
            'producto',
          )
          .select('*');

      _listaProductos = res
          .map<Producto>((item) => Producto(
              id: item['producto_id'].toString(),
              nombre: item['nombre'],
              descripcion: item['descripcion'],
              costo: item['costo'],
              activo: productoActivado(saldo, item['costo']),
              seleccionado: false,
              imagenurl: item['imagen'] ??
                  "https://placehold.co/800?text=Picture&font=roboto"))
          .toList();

      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Exception on loadProductos(): $e');
    }
    return null;
  }

  // seleccionarProducto(Producto producto, bool status) {
  //   _listaProductos = _listaProductos
  //       .map(
  //         (item) => item.nombre == producto.nombre
  //             ? item.copyWith(seleccionado: status)
  //             : item,
  //       )
  //       .toList();

  //   notifyListeners();
  // }

  // deseleccionarTodo() {
  //   _listaProductos = _listaProductos
  //       .map((item) => item.copyWith(seleccionado: false))
  //       .toList();
  //   notifyListeners();
  // }

  bool productoActivado(double saldo, double costo) {
    bool activo = false;
    if (saldo >= costo) activo = !activo;
    return activo;
  }
}
