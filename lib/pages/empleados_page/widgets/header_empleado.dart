import 'package:dowload_page_apk/pages/widgets/alta_usuario_popup/alta_usuario_popup.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class EmpleadoPageHeader extends StatefulWidget {
  EmpleadoPageHeader({
    Key? key,
  }) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<EmpleadoPageHeader> createState() => _EmpleadoPageHeaderState();
}

class _EmpleadoPageHeaderState extends State<EmpleadoPageHeader> {
  @override
  Widget build(BuildContext context) {
    final EmpleadosProvider empleadoProvider =
        Provider.of<EmpleadosProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            width: 50,
            height: 50,
            child: FittedBox(
              child: AnimatedHoverButton(
                tooltip: 'Agregar',
                primaryColor: AppTheme.of(context).primaryColor,
                secondaryColor: AppTheme.of(context).primaryBackground,
                icon: Icons.person_add,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xffd1d0d0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: AltaUsuarioPopup(
                            key: UniqueKey(),
                            drawerController: widget.drawerController,
                            scaffoldKey: widget.scaffoldKey,
                            idRegistro: 2,
                            listaDropdownAreas: empleadoProvider.areaNames,
                            topMenuTittle:
                                "Alta de Empleado de Area"), // Widget personalizado
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Buscar(empleadoProvider: empleadoProvider),
      ],
    );
  }
}

class Buscar extends StatelessWidget {
  const Buscar({
    Key? key,
    required this.empleadoProvider,
  }) : super(key: key);

  final EmpleadosProvider empleadoProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
      child: Container(
        width: 250,
        height: 51,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppTheme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Icon(
                Icons.search,
                color: AppTheme.of(context).primaryColor,
                size: 24,
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: TextFormField(
                    controller: empleadoProvider.busquedaController,
                    /* autofocus: true, */
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      /*  hintText: 'Buscar', */
                      hintStyle: AppTheme.of(context).subtitle1.override(
                            fontSize: 14,
                            fontFamily: 'Gotham-Light',
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: false,
                          ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                    onChanged: (value) async {
                      //await provider.getUsuarios();
                      await empleadoProvider.getEmpleado();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
