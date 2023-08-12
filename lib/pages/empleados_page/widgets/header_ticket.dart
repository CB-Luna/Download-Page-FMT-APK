import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import '../../../providers/usuario_evento_controller.dart';

class CargaTicketHeader extends StatefulWidget {
  const CargaTicketHeader({
    Key? key,
    required this.formKey,
    required this.usuarioId,
    required this.usuarioNombre,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final String usuarioId;
  final String usuarioNombre;

  @override
  State<CargaTicketHeader> createState() => _CargaTicketHeaderState();
}

class _CargaTicketHeaderState extends State<CargaTicketHeader> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UsuarioEventoController provider = Provider.of<UsuarioEventoController>(
        context,
        listen: false,
      );
      provider.clearControllers();
      provider.clearImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final UsuarioEventoController provider =
        Provider.of<UsuarioEventoController>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //Agregar un texto con el nombre del usuario
          Text(
            widget.usuarioNombre,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.of(context).primaryColor,
            ),
          ),

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
                  setState(() {});
                  if (widget.formKey.currentState!.validate()) {
                    await provider.uploadImage();
                    if (provider.imageName == null ||
                        provider.imageName == "") {
                      fToast.showToast(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.red,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.error),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text("Error al guardar"),
                            ],
                          ),
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );
                      return;
                    }
                    await provider.guardarTicket(widget.usuarioId);

                    fToast.showToast(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.check),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text("Ticket guardado"),
                          ],
                        ),
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
