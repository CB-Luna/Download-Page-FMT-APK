import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/providers/usuarios_provider.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class AltaUsuarioHeader extends StatefulWidget {
  const AltaUsuarioHeader({
    Key? key,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<AltaUsuarioHeader> createState() => _AltaUsuarioHeaderState();
}

class _AltaUsuarioHeaderState extends State<AltaUsuarioHeader> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              icon: Icons.arrow_back_outlined,
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              tooltip: 'Regresar',
              onTap: () {
                if (context.canPop()) context.pop();
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              tooltip: 'Limpiar',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.cleaning_services,
              onTap: () => provider.clearControllers(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: AnimatedHoverButton(
              tooltip: 'Guardar',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.save,
              onTap: () async {
                if (!widget.formKey.currentState!.validate()) {
                  return;
                }

                if (provider.webImage != null) {
                  final res = await provider.uploadImage();
                  if (res == null) {
                    ApiErrorHandler.callToast('Error al subir imagen');
                  }
                }

                //Registrar usuario
                final Map<String, String>? result =
                    await provider.registrarUsuario();

                if (result == null) {
                  await ApiErrorHandler.callToast('Error al registrar usuario');
                  return;
                } else {
                  if (result['Error'] != null) {
                    await ApiErrorHandler.callToast(result['Error']!);
                    return;
                  }
                }

                final String? userId = result['userId'];

                if (userId == null) {
                  await ApiErrorHandler.callToast('Error al registrar usuario');
                  return;
                }

                //Crear perfil de usuario
                bool res = await provider.crearPerfilDeUsuario(userId);

                if (!res) {
                  await ApiErrorHandler.callToast(
                      'Error al crear perfil de usuario');
                  return;
                }

                //Realizar pasos especificos por rol

                //Si algun paso falla => rollback

                if (!mounted) return;
                fToast.showToast(
                  child: const SuccessToast(
                    message: 'Usuario creado',
                  ),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );

                context.pushReplacement('/usuarios');
              },
            ),
          ),
        ],
      ),
    );
  }
}
