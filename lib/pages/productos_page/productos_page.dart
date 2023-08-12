import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:dowload_page_apk/providers/providers.dart';

import 'productos_page_desktop.dart';

class ProductosPage extends StatelessWidget {
  ProductosPage({Key? key}) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ProductosProvider provider = Provider.of<ProductosProvider>(context);

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => ProductosPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          desktop: (BuildContext context) => ProductosPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
