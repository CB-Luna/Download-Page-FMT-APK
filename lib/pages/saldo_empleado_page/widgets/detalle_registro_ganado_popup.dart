import 'package:flutter/material.dart';
import 'package:dowload_page_apk/models/detalle_puntaje_ganado.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';

import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/pages/widgets/header_alta_producto.dart';
import 'package:dowload_page_apk/theme/theme.dart';

//import neumorphism

class DetalleRegistroGanadoPopup extends StatefulWidget {
  const DetalleRegistroGanadoPopup(
      {Key? key,
      required this.topMenuTittle,
      required this.registroGanado,})
      : super(key: key);
  final String topMenuTittle;
  final DetallePuntajeGanado registroGanado;

  @override
  State<DetalleRegistroGanadoPopup> createState() => _DetalleRegistroGanadoPopupState();
}

class _DetalleRegistroGanadoPopupState extends State<DetalleRegistroGanadoPopup> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
        width: 700,
        height: 700,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: FittedBox(
                        child: AnimatedHoverButton(
                          size: 45,
                          tooltip: 'Cerrar',
                          primaryColor: AppTheme.of(context).primaryColor,
                          secondaryColor: AppTheme.of(context).primaryBackground,
                          icon: Icons.close,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AvatarYbotonBorrar(
                          imagen: widget.registroGanado.imagenurl ?? ""),
                      Container(
                        width: 600,
                        padding: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          children: [
                            Text(
                              "Evento: ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).tertiaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              widget.registroGanado.evento,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 600,
                        padding: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          children: [
                            Text(
                              "Descripción: ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).tertiaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "${widget.registroGanado.descripcion}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 600,
                        padding: const EdgeInsets.only(top: 20),
                        child: Wrap(
                          children: [
                            Text(
                              "Puntaje Ganado: ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).tertiaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "${widget.registroGanado.puntaje}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 600,
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              "Autorizó: ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).tertiaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "Juan Pérez",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).secondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarYbotonBorrar extends StatefulWidget {
  final String imagen;
  const AvatarYbotonBorrar({
    Key? key, 
    required this.imagen,
  }) : super(key: key);

  @override
  State<AvatarYbotonBorrar> createState() => _AvatarYbotonBorrarState();
}

class _AvatarYbotonBorrarState extends State<AvatarYbotonBorrar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 300,
          height: 300,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: getProductoImage(widget.imagen),
        ),
      ],
    );
  }
}
