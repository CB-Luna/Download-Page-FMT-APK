import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/providers/visual_state_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../get_image_widget.dart';

class MiAdvancedDrawer extends StatelessWidget {
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget? body;
  final PreferredSizeWidget? appBar;

  const MiAdvancedDrawer({
    super.key,
    required this.drawerController,
    required this.scaffoldKey,
    this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    return AdvancedDrawer(
      controller: drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      openScale: 0.9,
      openRatio: 0.4,
      disabledGestures: true,
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/BDLogo3.svg',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      width: 0.2 * MediaQuery.of(context).size.width,
                      height: 0.2 * MediaQuery.of(context).size.height,
                      clipBehavior: Clip.antiAlias,
                      child: getNullableImage(
                        currentUser!.imagen,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '${currentUser!.nombreCompleto} ',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Gotham-Light',
                            fontSize: 0.02 * MediaQuery.of(context).size.height,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '(${currentUser!.rol})',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Gotham-Light',
                            fontSize: 0.02 * MediaQuery.of(context).size.height,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Menú',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Bicyclette-Light',
                      fontSize: 24,
                      color: AppTheme.of(context).secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Divider(),
              //OPCIONES DEL MENU
              currentUser!.rol == 8
                  ? ListTile(
                      leading: Icon(Icons.dashboard,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'RH Dashboards',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[11] = true;
                        Navigator.pushNamed(
                          context,
                          '/rh-dashboard',
                        );
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.home_outlined,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Inicio',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[0] = true;
                        Navigator.pushNamed(
                          context,
                          '/home',
                        );
                        // Navegar a la página de inicio
                      },
                    ),
              const Divider(),
              Visibility(
                visible: [3, 4, 5].any((e) => currentUser!.rol == e),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.personal_video,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Gestión de contenido',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[6] = true;
                        Navigator.pushNamed(
                          context,
                          '/gestion-de-contenido',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: [3, 4, 5].any((e) => currentUser!.rol == e),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.video_stable,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Gestion de videos',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[8] = true;
                        Navigator.pushNamed(
                          context,
                          '/gestion-de-videos',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: [1, 3].any((e) => currentUser!.rol == e),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.receipt_long_outlined,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Administración de activos',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[3] = true;
                        Navigator.pushNamed(
                          context,
                          '/administracion-de-activos',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: [3, 4].any((e) => currentUser!.rol == e),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.diversity_3,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Encargados de area',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[7] = true;
                        Navigator.pushNamed(
                          context,
                          '/encargados-de-area',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: [1, 3].any((e) => currentUser!.rol == e),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.groups,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Jefes de area',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[4] = true;
                        Navigator.pushNamed(
                          context,
                          '/jefes-de-area',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: currentUser!.rol == 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.group_outlined,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Jefes patrimoniales',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[5] = true;
                        Navigator.pushNamed(
                          context,
                          '/jefes-patrimoniales',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: currentUser!.rol == 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.format_list_numbered,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Encuesta',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[10] = true;
                        Navigator.pushNamed(
                          context,
                          '/encuesta',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Visibility(
                visible: currentUser!.rol == 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings,
                          size: 35, color: AppTheme.of(context).primaryColor),
                      title: Text(
                        'Configuración',
                        style: TextStyle(
                          fontFamily: 'Bicyclette-Light',
                          fontSize: 18,
                          color: AppTheme.of(context).tertiaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        visualState.isTaped[12] = true;
                        Navigator.pushNamed(
                          context,
                          '/configuracion',
                        );
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: body,
      ),
    );
  }
}
