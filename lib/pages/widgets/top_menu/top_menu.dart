import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/pages/widgets/hover_icon_widget.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/editar_perfil_popup/editar_perfil_popup.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/providers/saldo_controller.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopMenuWidget extends StatefulWidget {
  const TopMenuWidget({
    Key? key,
    this.title = '',
    this.titleSize = 0.0255,
  }) : super(key: key);

  final String title;
  final double titleSize;

  @override
  State<TopMenuWidget> createState() => _TopMenuWidgetState();
}

class _TopMenuWidgetState extends State<TopMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    final SaldoController saldoController =
        Provider.of<SaldoController>(context);

    if (currentUser == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              AppTheme.themeMode == ThemeMode.dark
                  ? Image.network(
                      assets.logoBlanco,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      assets.logoColor,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
              /*  Image.asset(
                AppTheme.of(context).primaryBackground == Colors.white
                    ? 'assets/images/LogoColor.png'
                    : 'assets/images/LogoBlanco.png',
                height: 0.05 * MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ), */
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTheme.of(context).title1.override(
                        useGoogleFonts: false,
                        fontSize: 26,
                        fontFamily: 'Bicyclette-Light',
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  InkWell(
                    child: Tooltip(
                      message: 'Cerrar Sesión',
                      child: HoverIconWidget(
                        icon: Icons.power_settings_new_outlined,
                        size: 0.05 * MediaQuery.of(context).size.height,
                      ),
                    ),
                    onTap: () async {
                      saldoController.clearControllers();
                      await userState.logout();
                    },
                  ),
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  InkWell(
                    child: Tooltip(
                      message: AppTheme.themeMode == ThemeMode.dark
                          ? 'Modo Claro'
                          : 'Modo Oscuro',
                      child: HoverIconWidget(
                        icon: AppTheme.themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        size: 0.05 * MediaQuery.of(context).size.height,
                      ),
                    ),
                    onTap: () {
                      if (AppTheme.themeMode == ThemeMode.dark) {
                        setDarkModeSetting(context, ThemeMode.light);
                      } else {
                        setDarkModeSetting(context, ThemeMode.dark);
                      }
                    },
                  ),
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Container(
                          width: 0.04 * MediaQuery.of(context).size.width,
                          height: 0.04 * MediaQuery.of(context).size.height,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: getNullableImage(
                            currentUser!.imagen,
                            boxFit: BoxFit.contain,
                          ),
                        ),
                        onTap: () async {
                          userState.initPerfilUsuario();
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return const EditarPerfilPopup();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 10),
                    child: Text(
                      currentUser!.nombreCompleto,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Gotham-Light',
                            fontSize: 0.02 * MediaQuery.of(context).size.height,
                            fontWeight: FontWeight.w400,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 2,
            thickness: 1,
            color: Color(0XFFB6B6B6),
          ),
        ],
      ),
    );
  }
}
