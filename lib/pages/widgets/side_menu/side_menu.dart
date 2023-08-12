import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/widgets/menu_button.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);

    final userPermissions = currentUser!.rol.permisos;

    return SizedBox(
      width: 0.067 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userPermissions.home != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Home',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.home_outlined,
                      isTaped: visualState.isTaped[0],
                      onPressed: () {
                        context.pushReplacement('/home');
                      },
                    ),
                  )
                : Container(),

            userPermissions.administracionDeUsuarios != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Usuarios',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.group_outlined,
                      isTaped: visualState.isTaped[1],
                      onPressed: () {
                        context.pushReplacement('/usuarios');
                      },
                    ),
                  )
                : Container(),

            userPermissions.jefesArea != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Jefes de área',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.badge,
                      isTaped: visualState.isTaped[2],
                      onPressed: () {
                        context.pushReplacement('/jefes-area');
                      },
                    ),
                  )
                : Container(),

            userPermissions.saldo != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Saldo',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.credit_score,
                      isTaped: visualState.isTaped[5],
                      onPressed: () {
                        context.pushReplacement('/saldo');
                      },
                    ),
                  )
                : Container(),

            userPermissions.historial != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Historial',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.history,
                      isTaped: visualState.isTaped[3],
                      onPressed: () {
                        context.pushReplacement('/historial');
                      },
                    ),
                  )
                : Container(),

            userPermissions.empleados != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Empleados',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.groups,
                      isTaped: visualState.isTaped[6],
                      onPressed: () {
                        context.pushReplacement('/empleados');
                      },
                    ),
                  )
                : Container(),

            userPermissions.productos != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Productos',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.storefront,
                      isTaped: visualState.isTaped[7],
                      onPressed: () {
                        context.pushReplacement('/productos');
                      },
                    ),
                  )
                : Container(),

            userPermissions.validacionPuntaje != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Validación',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.price_check,
                      isTaped: visualState.isTaped[8],
                      onPressed: () {
                        context.pushReplacement('/validacion');
                      },
                    ),
                  )
                : Container(),

            userPermissions.eventos != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Eventos',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.event,
                      isTaped: visualState.isTaped[9],
                      onPressed: () {
                        context.pushReplacement('/eventos');
                      },
                    ),
                  )
                : Container(),

            userPermissions.eCommerce != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Comprar',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.store_rounded,
                      isTaped: visualState.isTaped[10],
                      onPressed: () {
                        context.pushReplacement('/comprar');
                      },
                    ),
                  )
                : Container(),
            userPermissions.administracionDeUsuarios != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Cotizador',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.request_quote_outlined,
                      isTaped: visualState.isTaped[11],
                      onPressed: () {
                        context.pushReplacement('/cotizador');
                      },
                    ),
                  )
                : Container(),

            // Padding(
            //   padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
            //   child: MenuButton(
            //     tooltip: 'Configuración',
            //     fillColor: AppTheme.of(context).primaryColor,
            //     icon: Icons.build_outlined,
            //     isTaped: visualState.isTaped[13],
            //     onPressed: () {
            //       context.pushReplacement('/configuracion');
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
