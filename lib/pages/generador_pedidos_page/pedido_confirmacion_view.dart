import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dowload_page_apk/pages/generador_pedidos_page/widgets/pedido_generado_popup.dart';
import '../../helpers/globals.dart';
import '../../helpers/responsive.dart';
import '../../providers/cart_provider.dart';
import '../../providers/saldo_controller.dart';
import '../../theme/theme.dart';
import 'widgets/column_builder.dart';

class PedidoConfirmacionView extends StatelessWidget {
  const PedidoConfirmacionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);

    final ScrollController scrollController = ScrollController();

    final saldoController = Provider.of<SaldoController>(context);

    //Función para restar al saldo del empleado el costo total del pedido,
    // generado esperando a que se genere el ticket para mandar su id.
    Future<void> restarSaldo() async {
      await Future.delayed(const Duration(seconds: 1));
      saldoController.substractPuntajeEmpleadoSupabase(
          currentUser!.id, cart.total, cart.idTicket);
    }

    return FractionallySizedBox(
      widthFactor: mobile(context)
          ? 1
          : screenSize(context).width <= 1300
              ? 0.70
              : 0.4,
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 50,
                  spreadRadius: -30,
                  color: Color.fromARGB(108, 30, 44, 75),
                  offset: Offset(0, 40),
                )
              ]),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Column(children: [
            Text("Este es el resumen de tu orden:",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  color: AppTheme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                )),
            Expanded(
              child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: ColumnBuilder(
                        itemCount: cart.seleccionados.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (cart.seleccionados.isEmpty) {
                            return const Text('No hay productos en tu pedido');
                          }
                          final item = cart.seleccionados[index];

                          return ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(05),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppTheme.of(context).gris),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/defaultproduct.png',
                                      image: item.imagenurl!,
                                      height: 300,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(item.nombre,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    // color: AppTheme.of(context).tertiaryColor,
                                    fontWeight: FontWeight.w600,
                                  )),
                              subtitle: Text("Producto",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      // color: AppTheme.of(context)
                                      //     .tertiaryColor
                                      //     .withOpacity(0.5),
                                      fontWeight: FontWeight.w400)),
                              trailing: Text('${item.costo.toString()} puntos',
                                  style: GoogleFonts.workSans(
                                      fontSize: 18,
                                      // color: AppTheme.of(context).tertiaryColor,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -1.0)));
                        }),
                  )),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("Costo total:",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          // color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(" ${cart.total} puntos",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          color: AppTheme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                )),
            Wrap(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.5,
                                color: AppTheme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor:
                              AppTheme.of(context).primaryBackground,
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () => cart.changeStatusPedido(),
                      child: Text('Volver',
                          style: GoogleFonts.plusJakartaSans(
                              height: 1.5,
                              fontSize: 15,
                              color: AppTheme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2)),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppTheme.of(context).primaryColor,
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () async {
                        cart.generarPedido(currentUser!.id, cart.total);

                        restarSaldo();

                        showDialog(
                            barrierColor: AppTheme.of(context)
                                .tertiaryColor
                                .withOpacity(0.50),
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return const PedidoGeneradoPopup();
                            });
                      },
                      child: Text('Confirmar',
                          style: GoogleFonts.plusJakartaSans(
                              height: 1.5,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2)),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
