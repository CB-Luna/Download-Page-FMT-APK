import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import '../../../../providers/usuarios_provider.dart';
import '../../../../services/api_error_handler.dart';
import '../../toasts/success_toast.dart';

class AltaUsuarioHeader extends StatefulWidget {
  const AltaUsuarioHeader({
    Key? key,
    required this.formKey,
    required this.idRol,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final int idRol;

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
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          /*     Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              decoration: neumorphism.neuMorphismCirculoInteriorPie(),
              child: AnimatedHoverButton(
                icon: Icons.arrow_back_outlined,
                primaryColor: neumorphism.lightColor,
                secondaryColor: const Color(0XFFf26925),
                tooltip: 'Regresar',
                onTap: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              ),
            ),
          ),
          const Spacer(), */
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.of(context).secondaryColor,
            ),
            child: FittedBox(
              child: AnimatedHoverButton(
                size: 45,
                tooltip: 'Limpiar',
                primaryColor: AppTheme.of(context).primaryColor,
                secondaryColor: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.of(context).primaryBackground.withAlpha(200)
                    : AppTheme.of(context).primaryBackground,
                icon: Icons.cleaning_services,
                onTap: () {
                  provider.clearControllers();
                  setState(() {});
                },
              ),
            ),
          ),
          const SizedBox(width: 25),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.of(context).secondaryColor,
            ),
            child: FittedBox(
              child: AnimatedHoverButton(
                size: 45,
                tooltip: 'Guardar',
                primaryColor: AppTheme.of(context).primaryColor,
                secondaryColor: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.of(context).primaryBackground.withAlpha(200)
                    : AppTheme.of(context).primaryBackground,
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
                  final String? userId = await provider.registrarUsuarioV2();
                  print('userIdxxx: $userId');

                  if (userId == null) {
                    print('WTF!!!: $userId');
                    await ApiErrorHandler.callToast(
                        'Error al registrar usuario :(');
                    return;
                  }

                  //Crear perfil de usuario
                  bool res = await provider.crearPerfilDeUsuarioV2(
                      userId, widget.idRol);

                  if (!res) {
                    await ApiErrorHandler.callToast(
                        'Error al crear perfil de usuario');
                    return;
                  }

                  if (!mounted) return;
                  fToast.showToast(
                    child: const SuccessToast(
                      message: 'Usuario creado',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );
                  /*        await provider
                      .getUsuarios()
                      .then((value) => Navigator.pop(context)); */
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
