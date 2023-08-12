import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../providers/pedido_provider.dart';
import 'widgets/product_card.dart';

class ProductosView extends StatelessWidget {
  const ProductosView({Key? key, required this.saldo}) : super(key: key);

  final int saldo;

  @override
  Widget build(BuildContext context) {
    final productosController = Provider.of<PedidoController>(context);
    final ScrollController scrollController = ScrollController();
    return SizedBox(
      width: double.infinity,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (var producto in productosController.listaProductos)
                ProductCard(producto: producto, saldo: saldo)
            ],
          ),
        ),
      ),
    );
  }
}
