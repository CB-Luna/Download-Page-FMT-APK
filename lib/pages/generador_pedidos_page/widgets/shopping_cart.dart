import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helpers/responsive.dart';
import '../../../providers/cart_provider.dart';
import '../../../theme/theme.dart';
import 'column_builder.dart';

class CartWidget extends StatelessWidget {
  final double saldo;
  const CartWidget({Key? key, required this.saldo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);

    final scrollController = ScrollController();

    Color infoColor = Theme.of(context).brightness == Brightness.dark
        ? AppTheme.of(context).primaryText
        : AppTheme.of(context).secondaryColor;

    return cart.isCartVisible
        ? Visibility(
            visible: cart.isCartVisible,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: mobile(context) ? screenSize(context).width : cartWidth,
              margin: const EdgeInsets.all(horBorderPadding),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50)),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      PuntosIndicator(
                        saldo: saldo,
                        title: "Puntos actuales",
                        color: Colors.transparent,
                        description: "",
                      ),
                      PuntosIndicator(
                        saldo: (saldo - cart.total),
                        title: "Puntos disponibles",
                        color: Colors.transparent,
                        description:
                            "Este es el saldo que te queda para seguir realizando tu pedido.",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: mobile(context),
                          child: ClayContainer(
                            spread: 3,
                            color: Colors.white,
                            parentColor: const Color(0xff2e5899),
                            height: 35,
                            width: 35,
                            depth: 30,
                            borderRadius: 25,
                            curveType: CurveType.concave,
                            child: IconButton(
                              icon: const Icon(
                                Icons.keyboard_tab_rounded,
                                color: Color(0xff2e5899),
                                size: 18,
                              ),
                              onPressed: () {
                                cart.changeCartVisibility();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    )),
                Expanded(
                    child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          ColumnBuilder(
                            itemCount: cart.seleccionados.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (cart.seleccionados.isEmpty) {
                                return const Text(
                                    'No hay productos en tu pedido');
                              }
                              final item = cart.seleccionados[index];
                              return ListTile(
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25.0)),
                                          border: Border.all(
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: IconButton(
                                          iconSize: 20,
                                          padding: const EdgeInsets.all(1),
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            Icons.cancel,
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            cart.removerCompra(item);
                                          },
                                        ),
                                      ),
                                      FadeInImage.assetNetwork(
                                        placeholder:
                                            '../assets/images/loading.gif',
                                        image: item.imagenurl!,
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                  title: Text(item.nombre,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        color: AppTheme.of(context).primaryText,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  subtitle: Text("Producto",
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: AppTheme.of(context)
                                              .primaryText
                                              .withOpacity(0.5),
                                          fontWeight: FontWeight.w400)),
                                  trailing: Text(
                                      '${item.costo.toString()} puntos',
                                      style: GoogleFonts.workSans(
                                          fontSize: 18,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: -1.0)));
                            },
                          ),
                        ],
                      )),
                )),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 15.0, left: 20.0, right: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5)),
                        Text("${cart.total.toStringAsFixed(0)} puntos",
                            style: GoogleFonts.workSans(
                                fontSize: 25,
                                color: infoColor,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.5)),
                      ]),
                ),
                Visibility(
                  visible: !mobile(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(),
                      Row(children: [
                        CartButton(
                          text: "Pedir",
                          isFilled: true,
                          onPressed: () {
                            if (cart.total > 0) {
                              cart.changeStatusPedido();
                              // cart.generarPedido(currentUser!.id, cart.total);
                              // restarSaldo();
                            }
                          },
                        )
                      ])
                    ],
                  ),
                )
              ]),
            ),
          )
        : Visibility(
            visible: !cart.isCartVisible,
            child: const Padding(
                padding: EdgeInsets.all(10.0), child: Text("Qty")
                // ClayContainer(
                //   spread: 6,
                //   color: const Color(0xff2e5899),
                //   parentColor: const Color(0xffdfedff),
                //   height: 45,
                //   width: 45,
                //   depth: 40,
                //   borderRadius: 25,
                //   curveType: CurveType.concave,
                //   child: GestureDetector(
                //     onTap: () {
                //       cart.changeCartVisibility();
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //       child: badge.Badge(
                //         badgeContent: const Text("Qty",
                //             // cartController.generalCartCounter.toString(),
                //             style: const TextStyle(color: Colors.white)),
                //         showBadge: true,
                //         position: BadgePosition.bottomStart(),
                //         child: const Icon(
                //           Icons.add_shopping_cart,
                //           color: Colors.white,
                //           size: 25,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                ),

            // IconButton(
            //   splashRadius: 15.0,
            //   padding: const EdgeInsets.all(12.0),
            //   icon: const Icon(
            //     Icons.shopping_cart,
            //     color: Color.fromARGB(255, 10, 56, 126),
            //     size: 30,
            //   ),
            //   onPressed: () {
            //     cartController.changeVisibility();
            //   },
            // ),
          );
  }
}

class PuntosIndicator extends StatelessWidget {
  const PuntosIndicator(
      {super.key,
      required this.saldo,
      required this.title,
      required this.color,
      required this.description});

  final double saldo;
  final String title;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    Color infoColor = Theme.of(context).brightness == Brightness.dark
        ? AppTheme.of(context).primaryText
        : AppTheme.of(context).secondaryColor;

    return FractionallySizedBox(
      widthFactor: mobile(context) ? 1 : 0.48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 30,
                  spreadRadius: -30,
                  color: Color.fromARGB(108, 30, 44, 75),
                  offset: Offset(0, 40),
                )
              ],
            ),
            child: Column(
              children: [
                Text(title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: infoColor,
                    )),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text("$saldo puntos",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: infoColor,
                            letterSpacing: -0.25)),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        'assets/images/LogoBD.png',
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.info_outline_rounded,
                  size: 16, color: infoColor.withOpacity(0.5)),
            ),
          )
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFilled,
  });

  final String text;
  final bool? isFilled;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    Color color = AppTheme.of(context).primaryColor;

    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onPressed != null ? onPressed!() : null,
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        fontSize: screenSize(context).width * 0.01,
        fontWeight: FontWeight.w600,
      );
}
