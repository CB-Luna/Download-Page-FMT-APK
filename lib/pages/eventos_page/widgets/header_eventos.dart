import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../widgets/alta_evento_popup/alta_evento_popup.dart';

class EventosPageHeader extends StatefulWidget {
  EventosPageHeader({
    Key? key,
  }) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<EventosPageHeader> createState() => _EventosPageHeaderState();
}

class _EventosPageHeaderState extends State<EventosPageHeader> {
  @override
  Widget build(BuildContext context) {
    final EventosProvider eventosProvider =
        Provider.of<EventosProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /*         Text(
              'Usuarios',
              style: AppTheme.of(context).tituloPagina,
            ), */
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: FittedBox(
                child: AnimatedHoverButton(
                  tooltip: 'Agregar',
                  primaryColor: AppTheme.of(context).primaryColor,
                  secondaryColor: AppTheme.of(context).primaryBackground,
                  icon: Icons.assignment_add,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xffd1d0d0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          content: AltaEventoPopup(
                              key: UniqueKey(),
                              drawerController: widget.drawerController,
                              scaffoldKey: widget.scaffoldKey,
                              idRegistro: 2,
                              topMenuTittle:
                                  "Alta de Evento"), // Widget personalizado
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Buscar(eventosProvider: eventosProvider),
          ],
        ),
      ],
    );
  }
}

class Buscar extends StatelessWidget {
  const Buscar({
    Key? key,
    required this.eventosProvider,
  }) : super(key: key);

  final EventosProvider eventosProvider;

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
                    controller: eventosProvider.busquedaController,
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
                      await eventosProvider.getEventoTabla();
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
