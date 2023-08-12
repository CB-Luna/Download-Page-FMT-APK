import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/pages/widgets/hover_icon_widget.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.titleSize = 0.0355,
    required this.drawerController,
  }) : super(key: key);

  final String title;
  final double titleSize;
  final AdvancedDrawerController drawerController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    const double toolbarHeight = kToolbarHeight + 20;
    return SizedBox(
      height: toolbarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            foregroundColor: AppTheme.of(context).primaryColor,
            backgroundColor: Color.fromARGB(0, 93, 93, 93),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                child: const HoverIconWidget(
                  icon: Icons.menu,
                  size: 50,
                  isRed: false,
                ),
                onTap: () {
                  drawerController.showDrawer();
                },
              ),
            ),
            title: Text(
              title,
              maxLines: 2,
              style: AppTheme.of(context).title1.override(
                    useGoogleFonts: false,
                    fontSize: titleSize * MediaQuery.of(context).size.height,
                    fontFamily: 'Bicyclette-Light',
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            actions: [
              InkWell(
                child: Tooltip(
                  message: 'Cerrar Sesión',
                  child: HoverIconWidget(
                    icon: Icons.power_settings_new_outlined,
                    size: 0.04 * MediaQuery.of(context).size.height,
                  ),
                ),
                onTap: () async {
                  await userState.logout();
                },
              ),
              SizedBox(
                height: kToolbarHeight,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(0, 204, 86, 12),
                  child: Container(
                    width: 0.06 * MediaQuery.of(context).size.width,
                    height: 0.06 * MediaQuery.of(context).size.height,
                    clipBehavior: Clip.antiAlias,
                    child: getNullableImage(
                      currentUser!.imagen,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
