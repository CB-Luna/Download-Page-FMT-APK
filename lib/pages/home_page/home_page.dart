import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../providers/home_provider.dart';

import 'home_page_desktop.dart';
/* import 'home_page_tablet.dart'; */

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      HomeProvider provider = Provider.of<HomeProvider>(
        context,
        listen: false,
      );
      await provider.getHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider provider = Provider.of<HomeProvider>(context);

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => HomePageDesktop(
            key: UniqueKey(),
            drawerController: drawerController,
            scaffoldKey: scaffoldKey,
            providerHome: provider,
          ),
          desktop: (BuildContext context) => HomePageDesktop(
            key: UniqueKey(),
            drawerController: drawerController,
            scaffoldKey: scaffoldKey,
            providerHome: provider,
          ),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
