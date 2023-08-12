import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/editar_usuario_page/widgets/header.dart';
import 'package:dowload_page_apk/pages/editar_usuario_page/widgets/input_field_label.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/get_image_widget.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/pages/editar_usuario_page/widgets/rol_dropdown.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class EditarUsuarioPage extends StatefulWidget {
  const EditarUsuarioPage({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.usuario.imagen != null) {
      final res =
          supabase.storage.from('avatars').getPublicUrl(widget.usuario.imagen!);
      imageUrl = res;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UsuariosProvider provider = Provider.of<UsuariosProvider>(
        context,
        listen: false,
      );
      await provider.getRoles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //MENU
                const TopMenuWidget(
                  title: 'Edición de Usuario',
                ),

                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          child: Column(
                            children: [
                              //HEADER EDITAR USUARIO
                              EditarUsuarioHeader(
                                formKey: formKey,
                              ),

                              //Formulario
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    150, 30, 150, 0),
                                child: Form(
                                  key: formKey,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await provider
                                                        .selectImage();
                                                  },
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: getUserImage(
                                                      provider.webImage ??
                                                          imageUrl,
                                                    ),
                                                  ),
                                                ),
                                                AnimatedHoverButton(
                                                  icon:
                                                      FontAwesomeIcons.trashCan,
                                                  tooltip: 'Borrar Imagen',
                                                  primaryColor:
                                                      AppTheme.of(context)
                                                          .primaryColor,
                                                  secondaryColor:
                                                      AppTheme.of(context)
                                                          .primaryBackground,
                                                  size: 40,
                                                  iconSize: 25,
                                                  onTap: () async {
                                                    imageUrl = null;
                                                    provider.clearImage();
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 500,
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Stack(
                                                children: [
                                                  if (provider.nombreController
                                                      .text.isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Nombre',
                                                    ),
                                                  TextFormField(
                                                    controller: provider
                                                        .nombreController,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                            r"^[a-zA-ZÀ-ÿ´ ]+"),
                                                      )
                                                    ],
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'El nombre es obligatorio';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          AppTheme.of(context)
                                                              .bodyText2,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              width: 500,
                                              child: Stack(
                                                children: [
                                                  if (provider
                                                      .apellidosController
                                                      .text
                                                      .isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Apellidos',
                                                    ),
                                                  TextFormField(
                                                    controller: provider
                                                        .apellidosController,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                            r"^[a-zA-ZÀ-ÿ´ ]+"),
                                                      )
                                                    ],
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Los apellidos son obligatorios';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          AppTheme.of(context)
                                                              .bodyText2,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              width: 500,
                                              child: Stack(
                                                children: [
                                                  if (provider.correoController
                                                      .text.isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Correo',
                                                    ),
                                                  TextFormField(
                                                    controller: provider
                                                        .correoController,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    readOnly: true,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'El correo es obligatorio';
                                                      } else if (!EmailValidator
                                                          .validate(value)) {
                                                        return 'El correo no es válido';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle:
                                                          AppTheme.of(context)
                                                              .bodyText2,
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                              child: RolDropDown(
                                                key: UniqueKey(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
