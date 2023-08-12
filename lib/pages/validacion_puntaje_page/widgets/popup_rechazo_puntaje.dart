import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/widgets/custom_button.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class PopupRechazoPuntaje extends StatefulWidget {
  const PopupRechazoPuntaje({
    Key? key,
    required this.puntajeSolicitado,
    fecha,
  }) : super(key: key);

  final PuntajeSolicitado puntajeSolicitado;

  @override
  State<PopupRechazoPuntaje> createState() => _PopupRechazoPuntajeState();
}

class _PopupRechazoPuntajeState extends State<PopupRechazoPuntaje> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ValidacionPuntajeProvider provider =
        Provider.of<ValidacionPuntajeProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: AppTheme.of(context).primaryColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Motivos de rechazo *",
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      const SizedBox(width: 25),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          width: 420,
                          child: TextField(
                            controller: provider.motivosRechazo,
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.of(context).primaryBackground,
                              labelText: 'Motivo de rechazo...',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 135, 132, 132),
                                  fontSize: 15),
                              focusColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.of(context).primaryColor,
                                    width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.of(context).primaryColor,
                                    width: 2.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                    child: CustomButton(
                      onPressed: () async {
                        final res = await provider
                            .rechazarPuntaje(widget.puntajeSolicitado);
                        if (!res) {
                          ApiErrorHandler.callToast(
                              'Error al rechazar puntaje');
                        }
                        if (!mounted) return;
                        if (context.canPop()) context.pop();
                      },
                      text: 'Aceptar',
                      options: ButtonOptions(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 20, 20, 20),
                        color: AppTheme.of(context).primaryColor,
                        textStyle: AppTheme.of(context).subtitle2.override(
                              fontFamily: 'Gotham-Bold',
                              color: AppTheme.of(context).secondaryBackground,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: AppTheme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Titulo extends StatelessWidget {
  const Titulo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'Motivos de Rechazo',
            style: AppTheme.of(context).title1.override(
                fontFamily: 'Gotham-Bold',
                color: AppTheme.of(context).primaryColor,
                fontSize: 35,
                useGoogleFonts: false,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          child: InkWell(
            onTap: () {
              if (context.canPop()) context.pop();
            },
            child: Icon(
              Icons.close,
              color: AppTheme.of(context).primaryColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
