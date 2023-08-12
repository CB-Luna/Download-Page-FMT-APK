import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/pages/generador_pedidos_page/productos_view.dart';

import '../../helpers/globals.dart';
import '../../helpers/responsive.dart';
import '../../providers/cart_provider.dart';
import '../../providers/pedido_provider.dart';
import '../../providers/saldo_controller.dart';
import '../../providers/visual_state_provider.dart';
import '../../theme/theme.dart';
import '../widgets/side_menu/side_menu.dart';
import '../widgets/top_menu/top_menu.dart';
import 'pedido_confirmacion_view.dart';
import 'widgets/shopping_cart.dart';

class PedidosLayout extends StatefulWidget {
  const PedidosLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<PedidosLayout> createState() => _PedidosLayoutState();
}

class _PedidosLayoutState extends State<PedidosLayout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SaldoController provider = Provider.of<SaldoController>(
        context,
        listen: false,
      );
      await provider.updateState(currentUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final saldoController = Provider.of<SaldoController>(context);
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);

    visualState.setTapedOption(10);

    Future<int> getSaldo(int saldo) async {
      await Future.delayed(const Duration(milliseconds: 500));
      int saldoFinal = saldo;
      return saldoFinal;
    }

    return FutureBuilder(
      future: getSaldo((saldoController
              .objectSaldoEmpleado?.saldoCollection.edges.first?.node.saldo ??
          0)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? MultiProvider(
                providers: [
                  ChangeNotifierProvider<CartController>(
                    create: (_) => CartController(mobile(context)),
                  ),
                  ChangeNotifierProvider<PedidoController>(
                    create: (_) => PedidoController(snapshot.data),
                    lazy: false,
                  ),
                ],
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  key: _scaffoldKey,
                  body: Consumer<CartController>(
                    builder: (context, cartController, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: -5,
                                  color: Color.fromARGB(80, 0, 37, 75),
                                  offset: Offset(0, 5),
                                )
                              ],
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            child: const TopMenuWidget(
                                title: 'Canjear Puntos', titleSize: 0.025),
                          ),
                          Flexible(
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 195, 211, 235),
                                    Color.fromARGB(255, 184, 196, 221)
                                  ])),
                                  child: Container(
                                    color: AppTheme.of(context)
                                        .primaryBackground
                                        .withOpacity(0.75),
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SideMenuWidget(),
                                        Container(
                                            height: double.infinity,
                                            width: cartController.statusPedido ||
                                                    mobile(context)
                                                ? screenSize(context).width -
                                                    (screenSize(context).width *
                                                        0.067) -
                                                    40
                                                : screenSize(context).width -
                                                    cartWidth -
                                                    (horBorderPadding * 5) -
                                                    (screenSize(context).width *
                                                        0.067),
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                shape: cartController
                                                        .statusPedido
                                                    ? BoxShape.circle
                                                    : BoxShape.rectangle,
                                                gradient: cartController
                                                        .statusPedido
                                                    ? LinearGradient(
                                                        begin: Alignment
                                                            .bottomLeft,
                                                        end: Alignment.topRight,
                                                        colors: [
                                                            AppTheme.of(context)
                                                                .primaryColor,
                                                            AppTheme.of(context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.5),
                                                            AppTheme.of(context)
                                                                .primaryColor
                                                                .withOpacity(0),
                                                            AppTheme.of(context)
                                                                .primaryColor
                                                                .withOpacity(0)
                                                          ])
                                                    : null,
                                                color:
                                                    cartController.statusPedido
                                                        ? null
                                                        : AppTheme.of(context)
                                                            .primaryBackground,
                                                borderRadius:
                                                    cartController.statusPedido
                                                        ? null
                                                        : BorderRadius.circular(
                                                            25)),
                                            child: cartController.statusPedido
                                                ? const PedidoConfirmacionView()
                                                : ProductosView(
                                                    saldo: snapshot.data)),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !cartController.statusPedido,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: CartWidget(saldo: snapshot.data),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
