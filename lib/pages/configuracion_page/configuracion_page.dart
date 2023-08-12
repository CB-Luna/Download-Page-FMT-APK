import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/configuracion_page/widgets/image_selection_panel.dart';
import 'package:dowload_page_apk/pages/configuracion_page/widgets/theme_selection_panel.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isThemeSelectionOpen = true;
  bool isImageSelectionOpen = true;

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(5);

    final bool isLight = AppTheme.themeMode == ThemeMode.light;
    final Color iconColor = isLight
        ? Color.alphaBlend(AppTheme.of(context).primaryColor.withAlpha(0x99),
            const Color(0xFF121313))
        : Color.alphaBlend(AppTheme.of(context).primaryColor.withAlpha(0x7F),
            const Color(0XFFB6B6B6));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const TopMenuWidget(title: 'Configuración', titleSize: 0.025),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Configuracion de temas
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppTheme.of(context).primaryBackground,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  side: BorderSide(
                                    color: Color(0x1E090909),
                                    width: 1,
                                  ),
                                ),
                                elevation: 0,
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  children: <Widget>[
                                    Material(
                                      type: MaterialType.card,
                                      color: Color.alphaBlend(
                                        AppTheme.of(context)
                                            .primaryColor
                                            .withAlpha(20),
                                        isLight
                                            ? Colors.white
                                            : const Color(0XFF262626),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                        leading: Icon(
                                          Icons.palette_outlined,
                                          color: iconColor,
                                        ),
                                        title: Text(
                                          'Configuración de temas',
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                        trailing: ExpandIcon(
                                          size: 32,
                                          isExpanded: isThemeSelectionOpen,
                                          padding: EdgeInsets.zero,
                                          onPressed: (_) {
                                            setState(() =>
                                                isThemeSelectionOpen =
                                                    !isThemeSelectionOpen);
                                          },
                                        ),
                                        onTap: () {
                                          setState(() => isThemeSelectionOpen =
                                              !isThemeSelectionOpen);
                                        },
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return SizeTransition(
                                          sizeFactor: animation,
                                          child: child,
                                        );
                                      },
                                      child: (isThemeSelectionOpen)
                                          ? const ThemeSelectionPanel()
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Configuracion de imagenes
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: AppTheme.of(context).primaryBackground,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  side: BorderSide(
                                    color: Color(0x1E090909),
                                    width: 1,
                                  ),
                                ),
                                elevation: 0,
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  children: <Widget>[
                                    Material(
                                      type: MaterialType.card,
                                      color: Color.alphaBlend(
                                        AppTheme.of(context)
                                            .primaryColor
                                            .withAlpha(20),
                                        isLight
                                            ? Colors.white
                                            : const Color(0XFF262626),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                        leading: Icon(
                                          Icons.image_outlined,
                                          color: iconColor,
                                        ),
                                        title: Text(
                                          'Configuración de imágenes',
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                        trailing: ExpandIcon(
                                          size: 32,
                                          isExpanded: isImageSelectionOpen,
                                          padding: EdgeInsets.zero,
                                          onPressed: (_) {
                                            setState(() =>
                                                isImageSelectionOpen =
                                                    !isImageSelectionOpen);
                                          },
                                        ),
                                        onTap: () {
                                          setState(() => isImageSelectionOpen =
                                              !isImageSelectionOpen);
                                        },
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return SizeTransition(
                                          sizeFactor: animation,
                                          child: child,
                                        );
                                      },
                                      child: (isImageSelectionOpen)
                                          ? const ImageSelectionPanel()
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
