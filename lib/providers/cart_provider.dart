import 'package:flutter/material.dart';

import '../helpers/globals.dart';
import '../models/producto.dart';

class CartController extends ChangeNotifier {
  bool isCartVisible = true;
  int badgeTotal = 0;
  List<Producto> seleccionados = [];
  List<Producto> get listaPedido => seleccionados;
  int ticketId = 0;
  int get idTicket => ticketId;

  bool _statusPedido = false;
  bool get statusPedido => _statusPedido;
  bool pedidoGenerado = false;

  changeStatusPedido() {
    _statusPedido = !_statusPedido;
    notifyListeners();
  }

  CartController(bool mobile) {
    mobile ? isCartVisible = false : isCartVisible = true;
    notifyListeners();
  }

  void agregarCompra(Producto producto) {
    seleccionados.add(producto);

    notifyListeners();
  }

  void removerCompra(Producto producto) {
    seleccionados.remove(producto);
    notifyListeners();
  }

  ticket(int id) {
    ticketId = id;
    notifyListeners();
  }

  Future<void> generarPedido(String userId, int total) async {
    //Se genera el ticket con la información de los puntos totales

    try {
      await supabase.from('ticket').insert([
        {
          'total': total,
          'usuario_fk': userId,
        },
      ]);

      final ticketResult = await supabase
          .from('ticket')
          .select('id')
          .order('created_at', ascending: false)
          .limit(1);

      if (ticketResult == null) {
        // maneja el error de la consulta
      } else {
        ticket(ticketResult[0]['id']);
        //Se generan los registros de cada producto correspondiente al ticket
        for (var producto in listaPedido) {
          final insertResult = await supabase.from('ticket_producto').insert([
            {
              'producto_fk': producto.id,
              'ticket_fk': ticketId,
              'id_estatus_fk': 1
            },
          ]);

          if (insertResult != null) {
            if (!pedidoGenerado) {
              pedidoGenerado = true;
              changeStatusPedido();
              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      pedidoGenerado = false;
      notifyListeners();
      print('ERROR - function createLead(): $e');
    }
  }

  //Se obtiene el id del ticket recientemente generado.

  int get total {
    int total = seleccionados.fold(0, (int totalActual, Producto productoSig) {
      return totalActual + productoSig.costo;
    });

    return total;
  }

  void limpiarPedido() {
    seleccionados.clear();
    ticket(0);
    changeStatusPedido();

    notifyListeners();
  }

  void changeCartVisibility() {
    isCartVisible = !isCartVisible;
    notifyListeners();
  }
}
