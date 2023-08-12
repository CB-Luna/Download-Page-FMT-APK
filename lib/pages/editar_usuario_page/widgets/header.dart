import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/providers/usuarios_provider.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class EditarUsuarioHeader extends StatefulWidget {
  const EditarUsuarioHeader({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  State<EditarUsuarioHeader> createState() => _EditarUsuarioHeaderState();
}

class _EditarUsuarioHeaderState extends State<EditarUsuarioHeader> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);
    final Usuario? usuario = provider.usuarioEditado;
    if (usuario == null) return Container();
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
                }),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              tooltip: 'Limpiar',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.cleaning_services,
              onTap: () => provider.clearControllers(clearEmail: false),
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

                final imagen = usuario.imagen;

                if (imagen == null) {
                  if (provider.webImage != null) {
                    //usuario no tiene imagen y se agrego => se sube imagen
                    final res = await provider.uploadImage();
                    if (res == null) {
                      ApiErrorHandler.callToast('Error al subir imagen');
                    }
                  }
                  //usuario no tiene imagen y no se agrego => no hace nada
                } else {
                  //usuario tiene imagen y se borro => se borra en bd
                  if (provider.webImage == null && provider.imageName == null) {
                    final res =
                        await supabase.storage.from('avatars').remove([imagen]);
                    // if (res.hasError) {
                    //   ApiErrorHandler.callToast('Error al borrar imagen');
                    // }
                  }
                  //usuario tiene imagen y no se modifico => no se hace nada

                  //usuario tiene imagen y se cambio => se borra en bd y se sube la nueva
                  if (provider.webImage != null &&
                      provider.imageName != imagen) {
                    final res1 =
                        await supabase.storage.from('avatars').remove([imagen]);
                    // if (res1.hasError) {
                    //   ApiErrorHandler.callToast('Error al borrar imagen');
                    // }
                    final res2 = await provider.uploadImage();
                    if (res2 == null) {
                      ApiErrorHandler.callToast('Error al subir imagen');
                    }
                  }
                }

                //Editar perfil de usuario
                bool res = await provider.editarPerfilDeUsuario(usuario.id);

                if (!res) {
                  await ApiErrorHandler.callToast(
                      'Error al editar perfil de usuario');
                  return;
                }

                //Realizar pasos especificos por rol

                //Si algun paso falla => rollback

                if (!mounted) return;
                fToast.showToast(
                  child: const SuccessToast(
                    message: 'Usuario editado',
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
