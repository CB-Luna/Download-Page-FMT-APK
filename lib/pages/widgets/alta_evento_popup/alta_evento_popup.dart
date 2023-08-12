import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:provider/provider.dart';
import '../animated_hover_button.dart';
import '../header_alta_evento.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AltaEventoPopup extends StatefulWidget {
  const AltaEventoPopup(
      {Key? key,
      required this.topMenuTittle,
      required this.idRegistro,
      required this.drawerController,
      required this.scaffoldKey})
      : super(key: key);
  final String topMenuTittle;
  final int idRegistro;
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<AltaEventoPopup> createState() => _AltaEventoPopupState();
}

class _AltaEventoPopupState extends State<AltaEventoPopup> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EventosProvider provider = Provider.of<EventosProvider>(
        context,
        listen: false,
      );
      provider.clearControllers();
      provider.clearImage();
      await provider.getEventoTabla();
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventosProvider provider = Provider.of<EventosProvider>(context);
    provider.areaTrabajoController.text = "7";
    provider.rolParaRegistro = widget.idRegistro;

    return Material(
      child: Container(
        width: 700,
        height: 700,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              AltaEventoHeader(formKey: formKey),
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
                        AvatarYbotonBorrar(provider: provider),
                        Container(
                          width: 600,
                          padding: const EdgeInsets.only(top: 20),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: provider.nombreController,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre es obligatorio';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Nombre',
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
                                controller: provider.descripcionController,
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
                                controller: provider.puntosController,
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
                                    return 'El puntaje es obligatorio';
                                  }
                                  if (value.length <= 1) {
                                    return 'El puntaje debe ser mayor a 0';
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
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: 600,
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: provider.fechaController,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La fecha es obligatoria';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Fecha y Hora',
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
                                onTap: () {
                                  DatePicker.showDateTimePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      provider.fechaController.text =
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.es,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
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

  final EventosProvider provider;

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
          child: Consumer<EventosProvider>(
            builder: (context, provider, child) {
              return Container(
                width: 300,
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: getProductoImage(provider.webImage),
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
