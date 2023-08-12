import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/empleados_page/widgets/drop_down.dart';
import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/providers/usuario_evento_controller.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../widgets/animated_hover_button.dart';
import 'header_ticket.dart';

class CargarTicketPopup extends StatefulWidget {
  const CargarTicketPopup(
      {Key? key,
      required this.topMenuTittle,
      required this.idRegistro,
      required this.drawerController,
      required this.scaffoldKey,
      required this.usuarioId,
      required this.usuarioNombre})
      : super(key: key);
  final String topMenuTittle;
  final int idRegistro;
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final String usuarioId;
  final String usuarioNombre;

  @override
  State<CargarTicketPopup> createState() => _CargarTicketPopupState();
}

class _CargarTicketPopupState extends State<CargarTicketPopup> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UsuarioEventoController provider = Provider.of<UsuarioEventoController>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioEventoController =
        Provider.of<UsuarioEventoController>(context);
    return Material(
      child: Container(
        width: 700,
        height: 780,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              CargaTicketHeader(
                  formKey: formKey,
                  usuarioId: widget.usuarioId,
                  usuarioNombre: widget.usuarioNombre),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        AvatarYbotonBorrar(provider: usuarioEventoController),
                        Container(
                          width: 600,
                          padding: const EdgeInsets.only(top: 20),
                          child: Stack(
                            children: [
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                    child: DropDown(
                                      options:
                                          usuarioEventoController.listEventos,
                                      onChanged: (value) {
                                        if (value == null) return;
                                        final res = usuarioEventoController
                                            .seleccionarEvento(value);
                                        if (!res) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Aún no hay eventos registrados."),
                                          ));
                                        }
                                      },
                                      width: double.infinity,
                                      height: 70,
                                      textStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Seleccione un evento*',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color:
                                            AppTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      fillColor: AppTheme.of(context)
                                          .primaryBackground,
                                      elevation: 2,
                                      borderColor:
                                          AppTheme.of(context).secondaryColor,
                                      borderWidth: 2,
                                      borderRadius: 8,
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (usuarioEventoController.evento == "" ||
                                      usuarioEventoController.evento.isEmpty) {
                                    return 'Para continuar, seleccione un evento.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 600,
                          child: Stack(
                            children: [
                              TextFormField(
                                readOnly: true,
                                controller: usuarioEventoController
                                    .descripcionEventoController,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Los apellidos son obligatorios';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Descripción',
                                  hintStyle:
                                      AppTheme.of(context).bodyText2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 1.2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 600,
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: usuarioEventoController
                                    .puntajeAgregadoController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  )
                                ],
                                onChanged: (_) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El costo es obligatorio';
                                  }
                                  if (value.length <= 0) {
                                    return 'No se ha añaadido un costo';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Puntos',
                                  /*    hintText: 'Usuario', */
                                  hintStyle:
                                      AppTheme.of(context).bodyText2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 1.2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 600,
                          child: Stack(
                            children: [
                              TextFormField(
                                readOnly: false,
                                controller: usuarioEventoController
                                    .notaEventoController,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                /*    validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Los apellidos son obligatorios';
                                  }
                                  return null;
                                }, */
                                decoration: InputDecoration(
                                  labelText: 'Nota (opcional)',
                                  hintStyle:
                                      AppTheme.of(context).bodyText2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 1.2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          AppTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
  const AvatarYbotonBorrar({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final UsuarioEventoController provider;

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
        InkWell(
          onTap: () async {
            await widget.provider.selectImage();
            setState(() {});
          },
          child: Consumer<UsuarioEventoController>(
            builder: (context, provider, child) {
              return Container(
                width: 300,
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: getComprobanteImage(provider.webImage),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.of(context).secondaryColor,
          ),
          child: FittedBox(
            child: AnimatedHoverButton(
              icon: Icons.delete_rounded,
              tooltip: 'Eliminar imagen',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.of(context).primaryBackground.withAlpha(200)
                  : AppTheme.of(context).primaryBackground,
              onTap: () async {
                widget.provider.clearImage();
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
