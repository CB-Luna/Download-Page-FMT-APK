import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:dowload_page_apk/providers/providers.dart';

import 'eventos_pagea_desktop.dart';

class EventosPage extends StatefulWidget {
  EventosPage({Key? key}) : super(key: key);

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EventosProvider provider = Provider.of<EventosProvider>(
        context,
        listen: false,
      );
      provider.clearControllers();
      provider.initImage();
      await provider.getEventoTabla();
    });
  }

  @override
  Widget build(BuildContext context) {
    EventosProvider provider = Provider.of<EventosProvider>(context);

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => EventosPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          desktop: (BuildContext context) => EventosPageDesktop(
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
