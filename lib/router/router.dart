import 'package:dowload_page_apk/pages/cotizador/cotizador_page.dart';
import 'package:dowload_page_apk/pages/tablero/tablero.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dowload_page_apk/pages/saldo_empleado_page/saldo_empleado_page.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/services/navigation_service.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/pages.dart';

import '../pages/empleados_page/empleados_page.dart';
import '../pages/generador_pedidos_page/pedidos_layout.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = currentUser != null;
    final bool isLoggingIn = state.location == '/login';

    //If user is not logged in and not in the login page
    if (!loggedIn && !isLoggingIn) return '/login';

    //if user is logged in and in the login page
    if (loggedIn && isLoggingIn) return '/';

    return null;
  },
  errorBuilder: (context, state) => const PageNotFoundPage(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'root',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.esEmpleado) {
          return const SaldoEmpleadoPage();
        } else if (currentUser!.esJefeDeArea) {
          return EmpleadosPage();
        }
        return HomePage();
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.home == null) {
          return const PageNotFoundPage();
        }
        return HomePage();
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/usuarios',
      name: 'usuarios',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.administracionDeUsuarios == null) {
          return const PageNotFoundPage();
        }
        return const UsuariosPage();
      },
      routes: [
        GoRoute(
          path: 'alta-usuario',
          name: 'alta_usuario',
          builder: (BuildContext context, GoRouterState state) {
            if (currentUser!.rol.permisos.administracionDeUsuarios == null) {
              return const PageNotFoundPage();
            }
            return const AltaUsuarioPage();
          },
        ),
        GoRoute(
          path: 'editar-usuario',
          name: 'editar_usuario',
          builder: (BuildContext context, GoRouterState state) {
            if (currentUser!.rol.permisos.administracionDeUsuarios == null) {
              return const PageNotFoundPage();
            }
            if (state.extra == null) return const UsuariosPage();
            return EditarUsuarioPage(usuario: state.extra as Usuario);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/historial',
      name: 'historial',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.historial == null) {
          return const PageNotFoundPage();
        }
        return const Tablero();
      },
    ),
    GoRoute(
      path: '/cotizador',
      name: 'cotizador',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.home == null) {
          return const PageNotFoundPage();
        }
        return CotizadorPage();
      },
    ),
    GoRoute(
      path: '/jefes-area',
      name: 'jefes_area',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.jefesArea == null) {
          return const PageNotFoundPage();
        }
        return GestionJefesAreaPage();
      },
    ),
    GoRoute(
      path: '/saldo',
      name: 'saldo',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.saldo == null) {
          return const PageNotFoundPage();
        }
        return const SaldoEmpleadoPage();
      },
    ),
    GoRoute(
      path: '/empleados',
      name: 'empleados',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.empleados == null) {
          return const PageNotFoundPage();
        }
        return EmpleadosPage();
      },
    ),
    GoRoute(
      path: '/validacion',
      name: 'validacion',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.validacionPuntaje == null) {
          return const PageNotFoundPage();
        }
        return const ValidacionPuntajePage();
      },
    ),
    GoRoute(
      path: '/productos',
      name: 'productos',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.productos == null) {
          return const PageNotFoundPage();
        }
        return ProductosPage();
      },
    ),
    GoRoute(
      path: '/eventos',
      name: 'eventos',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.eventos == null) {
          return const PageNotFoundPage();
        }
        return EventosPage();
      },
    ),

    GoRoute(
      path: '/comprar',
      name: 'comprar',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.rol.permisos.eCommerce == null) {
          return const PageNotFoundPage();
        }
        return PedidosLayout();
      },
    ),

    // GoRoute(
    //   path: '/configuracion',
    //   name: 'configuracion',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const ConfiguracionPage();
    //   },
    // ),
  ],
);
