import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';

import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import '../../providers/eventos_provider.dart';

class AltaEventoHeader extends StatefulWidget {
  const AltaEventoHeader({
    Key? key,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  State<AltaEventoHeader> createState() => _AltaEventoHeaderState();
}

class _AltaEventoHeaderState extends State<AltaEventoHeader> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final EventosProvider provider = Provider.of<EventosProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
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
                  provider.clearImage();
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

                  //Crear perfil de usuario
                  bool res = await provider.crearEvento();

                  if (!res) {
                    await ApiErrorHandler.callToast(
                        'Error al crear perfil de usuario');
                    return;
                  }

                  if (!mounted) return;
                  fToast.showToast(
                    child: const SuccessToast(
                      message: 'Evento creado',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );

                  Navigator.pop(context);

                  /*          print(provider.nombreController.text);
                  print(provider.descripcionController.text);
                  print(provider.puntosController.text);
                  print(provider.fechaController.text);
                  print(provider.imageName);
              */
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
