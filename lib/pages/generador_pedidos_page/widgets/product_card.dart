import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/pages/generador_pedidos_page/widgets/producto_detalle_popup.dart';
import 'package:dowload_page_apk/providers/cart_provider.dart';

import '../../../helpers/responsive.dart';
import '../../../models/producto.dart';
import '../../../theme/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.producto,
    required this.saldo,
  });

  final Producto producto;
  final int saldo;

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return FractionallySizedBox(
      widthFactor: mobile(context) ? 1 : 0.33,
      child: Opacity(
        opacity: producto.activo ? 1 : 0.5,
        child: Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                blurRadius: 25,
                spreadRadius: -15,
                color: Color.fromARGB(80, 105, 136, 168),
                offset: Offset(0, 25),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 130,
                  color: const Color.fromARGB(255, 216, 221, 227),
                  child: Image.network(producto.imagenurl!)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 2.5),
                              child: Icon(Icons.circle,
                                  color: producto.activo
                                      ? AppTheme.of(context).primaryColor
                                      : Colors.grey,
                                  size: 16)),
                        ),
                        TextSpan(
                          text: (producto.costo.toString()),
                          style: GoogleFonts.workSans(
                              fontSize: 18,
                              color: producto.activo
                                  ? AppTheme.of(context).primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.25),
                        ),
                        TextSpan(
                          text: (" puntos"),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppTheme.of(context)
                                .tertiaryColor
                                .withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                        height: 50,
                        child: Text(producto.nombre,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              color: AppTheme.of(context).tertiaryColor,
                              fontWeight: FontWeight.w500,
                            ))),
                    Wrap(
                      // alignment: WrapAlignment.center,
                      // crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CardButton(
                          producto: producto,
                          text: "Agregar",
                          isFilled: true,
                          onPressed: () {
                            if (saldo >=
                                cartController.total + producto.costo) {
                              cartController.agregarCompra(producto);
                            }
                          },
                        ),
                        CardButton(
                          producto: producto,
                          text: "Ver más",
                          onPressed: () => openPopup(
                              context, producto, saldo, cartController),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.producto,
    required this.text,
    this.onPressed,
    this.isFilled,
  });

  final Producto producto;
  final String text;
  final bool? isFilled;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    Color color =
        producto.activo ? AppTheme.of(context).primaryColor : Colors.grey;

    return FractionallySizedBox(
      widthFactor: screenSize(context).width >= 1390 ? 0.5 : 1,
      child: MouseRegion(
        cursor: producto.activo
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        child: GestureDetector(
          onTap: () => onPressed != null ? onPressed!() : null,
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
                color: isFilled != null ? color : Colors.transparent,
              ),
              child: Text(text,
                  style: buttonText(
                      isFilled != null ? Colors.white : color, context))),
        ),
      ),
    );
  }
}

TextStyle buttonText(Color color, context) {
  return AppTheme.of(context).subtitle2.override(
        fontFamily: 'Plus Jakarta Sans',
        color: color,
        fontSize: mobile(context) ? 12 : screenSize(context).width * 0.0085,
        fontWeight: FontWeight.normal,
      );
}

void openPopup(context, Producto producto, int saldo, CartController cart) {
  showDialog(
      barrierColor: AppTheme.of(context).tertiaryColor.withOpacity(0.50),
      context: context,
      builder: (_) {
        return ProductoPopup(producto: producto, saldo: saldo, cart: cart);
      });
}
