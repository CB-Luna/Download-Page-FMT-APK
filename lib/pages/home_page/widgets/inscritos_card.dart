import 'package:flutter/material.dart';

import 'package:dowload_page_apk/providers/providers.dart';

import 'package:dowload_page_apk/theme/theme.dart';

import 'package:provider/provider.dart';

import '../../../helpers/globals.dart';

class ProveedoresInscritosCard extends StatelessWidget {
  const ProveedoresInscritosCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider providerHome = Provider.of<HomeProvider>(context);

    return Stack(
      children: [
        Container(
          width: 0.28 * MediaQuery.of(context).size.width,
          height: 0.25 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: AppTheme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 0.15 * MediaQuery.of(context).size.width,
                    child: Text(
                      currentUser!.rol.rolId == 1
                          ? 'Jefes de área'
                          : 'Empleados',
                      style: TextStyle(
                        fontFamily: 'Bicyclette-Light',
                        fontSize: 0.016 * MediaQuery.of(context).size.width,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //box decoration inner shadow withe
                    width: 0.1 * MediaQuery.of(context).size.width,
                    height: 0.1 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: AppTheme.of(context).tertiaryColor,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      widthFactor: 2.0,
                      heightFactor: 3,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            providerHome.homeData == null
                                ? '0'
                                : providerHome.homeData!.cantJefesArea
                                    .toString(),
                            style: TextStyle(
                              fontFamily: 'Bicyclette-Light',
                              fontSize:
                                  0.05 * MediaQuery.of(context).size.height,
                              color: AppTheme.of(context).tertiaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
