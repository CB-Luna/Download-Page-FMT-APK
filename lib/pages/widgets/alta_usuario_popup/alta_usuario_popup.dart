import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:dowload_page_apk/pages/widgets/alta_usuario_popup/widgets/header_alta_usuario.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:provider/provider.dart';
import 'widgets/avatarybotonborrar.dart';

class AltaUsuarioPopup extends StatefulWidget {
  const AltaUsuarioPopup({
    Key? key,
    required this.topMenuTittle,
    required this.idRegistro,
    required this.drawerController,
    required this.listaDropdownAreas,
    required this.scaffoldKey,
  }) : super(key: key);
  final String topMenuTittle;
  final int idRegistro;
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<String> listaDropdownAreas;

  @override
  State<AltaUsuarioPopup> createState() => _AltaUsuarioPopupState();
}

class _AltaUsuarioPopupState extends State<AltaUsuarioPopup> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);
    /*    provider.areaTrabajoController.text = "7";
 */
    return Material(
      child: Container(
        width: 700,
        height: 700,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              AltaUsuarioHeader(formKey: formKey, idRol: widget.idRegistro),
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
                                controller: provider.apellidosController,
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
                                  labelText: 'Apellidos',
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
                                controller: provider.correoController,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El correo es obligatorio';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'El correo no es válido';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Correo',
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
                        SizedBox(
                          width: 600,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 0),
                            child: DropdownButton(
                              value: provider.altaDropValue.isNotEmpty
                                  ? provider.altaDropValue.toString()
                                  : null,
                              style: AppTheme.of(context).bodyText2,
                              onChanged: (newValue) async {
                                await provider.getidarea(newValue.toString());
                                setState(() {
                                  provider.altaDropValue = newValue.toString();
                                });
                              },
                              hint: const Text("-- Seleccione una área --"),
                              items: widget.listaDropdownAreas
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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
