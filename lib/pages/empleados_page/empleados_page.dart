import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dowload_page_apk/providers/providers.dart';

import 'empleados_page_desktop.dart';

class EmpleadosPage extends StatefulWidget {
  EmpleadosPage({Key? key}) : super(key: key);

  @override
  State<EmpleadosPage> createState() => _EmpleadosPageState();
}

class _EmpleadosPageState extends State<EmpleadosPage> {
  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EmpleadosProvider provider = Provider.of<EmpleadosProvider>(
        context,
        listen: false,
      );
      await provider.getEmpleado();
    });
  }

  @override
  Widget build(BuildContext context) {
    final EmpleadosProvider provider = Provider.of<EmpleadosProvider>(context);
    final AdvancedDrawerController drawerController =
        AdvancedDrawerController();

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => EmpleadosPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          desktop: (BuildContext context) => EmpleadosPageDesktop(
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
