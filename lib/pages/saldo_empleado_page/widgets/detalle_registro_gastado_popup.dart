import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dowload_page_apk/models/detalle_puntaje_gastado.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';

import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/theme/theme.dart';

//import neumorphism

class DetalleRegistroGastadoPopup extends StatefulWidget {
  const DetalleRegistroGastadoPopup(
      {Key? key,
      required this.topMenuTittle,
      required this.registroGastado,
      })
      : super(key: key);
  final String topMenuTittle;
  final DetallePuntajeGastado registroGastado;

  @override
  State<DetalleRegistroGastadoPopup> createState() => _DetalleRegistroGastadoPopupState();
}

class _DetalleRegistroGastadoPopupState extends State<DetalleRegistroGastadoPopup> {
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
          child: Column(
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Total Ticket: ",
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
                      widget.registroGastado.ticket.total,
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Id Ticket: ",
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
                      widget.registroGastado.ticket.id,
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Fecha Registro: ",
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
                      DateFormat('dd/MM/yyyy HH:mm:ss')
                       .format(widget.registroGastado.ticket.createdAt),
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
              Text(
                "Lista de productos",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: AppTheme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 500,
                child: Builder(
                  builder: (context) {
                    return ListView.builder(
                      controller: ScrollController(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.registroGastado.productos.length,
                      itemBuilder: (context, index) {
                        final producto = widget.registroGastado.productos[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: getProductoImage(
                                  producto.imagen, 
                                  boxFit: BoxFit.contain, 
                                ),
                              ),
                              Container(
                                width: 600,
                                padding: const EdgeInsets.only(top: 20),
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Producto ${index + 1}: ",
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
                                      producto.nombre,
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
                                      "${producto.descripcion}",
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
                                      "Puntaje Gastado: ",
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
                                      producto.costo,
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
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
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
          child: getProductoImage(null),
        ),
      ],
    );
  }
}
