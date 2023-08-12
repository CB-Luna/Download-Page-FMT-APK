import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../providers/jefes_area_provider.dart';

import 'package:dowload_page_apk/providers/providers.dart';
import 'jefes_area_page_dektop.dart';
import 'jefes_area_page_tablet.dart';

class GestionJefesAreaPage extends StatelessWidget {
  GestionJefesAreaPage({Key? key}) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final JefesAreaProvider provider = Provider.of<JefesAreaProvider>(context);

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => GestionJefesAreaPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          desktop: (BuildContext context) => GestionJefesAreaPageDesktop(
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
