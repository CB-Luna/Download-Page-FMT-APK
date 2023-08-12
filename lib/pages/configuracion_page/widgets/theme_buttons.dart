import 'package:flutter/material.dart';

import 'package:dowload_page_apk/pages/configuracion_page/widgets/download_theme_popup.dart';
import 'package:dowload_page_apk/pages/configuracion_page/widgets/upload_theme_popup.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class ThemeButtons extends StatefulWidget {
  const ThemeButtons({Key? key}) : super(key: key);

  @override
  State<ThemeButtons> createState() => _ThemeButtonsState();
}

class _ThemeButtonsState extends State<ThemeButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              tooltip: 'Cargar tema',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.upload,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const UploadThemePopup();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: AnimatedHoverButton(
              tooltip: 'Descargar tema',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.download,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const DownloadThemePopup();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
