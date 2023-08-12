import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/responsive.dart';
import '../../../models/producto.dart';
import '../../../providers/cart_provider.dart';
import '../../../theme/theme.dart';

class ProductoPopup extends StatelessWidget with Popup {
  final Producto producto;
  final int saldo;
  final CartController cart;

  const ProductoPopup(
      {Key? key,
      required this.producto,
      required this.saldo,
      required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    const double mobileTitle = 14;
    const double mobileText = 10.5;
    double boxPadding = mobile(context) ? 20.0 : 30.0;

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      content: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(
              maxHeight: mobile(context) ? double.infinity : 570,
              maxWidth: 850),
          decoration: buildBoxDecoration(
              bgColor: AppTheme.of(context).primaryBackground,
              fit: BoxFit.cover,
              alignment: Alignment.center),
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            FractionallySizedBox(
              widthFactor: mobile(context) ? 1.0 : 0.5,
              child: Container(
                  padding: EdgeInsets.all(boxPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: mobile(context) ? 15.0 : 0),
                          child: Text(producto.nombre,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppTheme.of(context).primaryText,
                                fontSize: mobile(context) ? mobileTitle : 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              )),
                        ),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Text("${producto.costo}",
                              style: GoogleFonts.workSans(
                                  fontSize: 26,
                                  color: AppTheme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.0)),
                          Text(" puntos",
                              style: GoogleFonts.workSans(
                                fontSize: 16,
                                color: AppTheme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                              ))
                        ]),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(8.0),
                              controller: scrollController,
                              child: Text(producto.descripcion,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.plusJakartaSans(
                                    height: 1.5,
                                    fontSize: mobile(context) ? mobileText : 14,
                                    color: AppTheme.of(context)
                                        .primaryText
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor:
                                  AppTheme.of(context).primaryColor,
                              minimumSize: const Size.fromHeight(50)),
                          onPressed: () {
                            if (saldo >= cart.total + producto.costo) {
                              cart.agregarCompra(producto);
                              Navigator.pop(context, 'Agregar');
                            }
                          },
                          child: Text('Agregar',
                              style: GoogleFonts.plusJakartaSans(
                                  height: 1.5,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2)),
                        ),
                      ])),
            ),
            FractionallySizedBox(
                widthFactor: mobile(context) ? 1 : 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppTheme.of(context).primaryColor,
                                    AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0),
                                    AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0)
                                  ])),
                          margin: const EdgeInsets.all(20),
                          child: Image.network(producto.imagenurl!)),
                    ],
                  ),
                ))
          ]),
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              splashRadius: 10.0,
              icon: Icon(
                Icons.close,
                color: AppTheme.of(context).primaryColor,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ]),
    );
  }
}

abstract class Popup {
  BoxConstraints getConstraints({context, width, height}) {
    final size = MediaQuery.of(context).size;
    //550, 650
    if (size.height > height && size.width > width) {
      return BoxConstraints(minHeight: height * 0.9, minWidth: width * 0.9);
    } else {
      return const BoxConstraints();
    }
  }

  BoxDecoration buildBoxDecoration({
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
    );
  }
}
