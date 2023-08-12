import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/pages/validacion_puntaje_page/widgets/popup_rechazo_puntaje.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class PopUpValidarPuntajeWidget extends StatefulWidget {
  const PopUpValidarPuntajeWidget({
    Key? key,
    required this.puntajeSolicitado,
  }) : super(key: key);

  final PuntajeSolicitado puntajeSolicitado;

  @override
  State<PopUpValidarPuntajeWidget> createState() =>
      _PopUpValidarPuntajeWidgetState();
}

class _PopUpValidarPuntajeWidgetState extends State<PopUpValidarPuntajeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ValidacionPuntajeProvider provider =
        Provider.of<ValidacionPuntajeProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.78,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: AppTheme.of(context).primaryColor,
          ),
        ),
        child: Column(
          children: [
            const Titulo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.of(context).primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Puntaje:',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      fontSize: 18,
                                      useGoogleFonts: false,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.puntajeSolicitado.evento.puntos}',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Light',
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Datos del Empleado:',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Gotham-Light',
                                  color: AppTheme.of(context).primaryColor,
                                  useGoogleFonts: false,
                                  fontSize: 25,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Nombre:',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      fontSize: 18,
                                      useGoogleFonts: false,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.puntajeSolicitado.usuario.nombreCompleto,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Light',
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Datos del Evento:',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Gotham-Bold',
                                  color: AppTheme.of(context).primaryColor,
                                  useGoogleFonts: false,
                                  fontSize: 25,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Nombre:',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      fontSize: 18,
                                      useGoogleFonts: false,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.puntajeSolicitado.evento.nombre,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Light',
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Fecha:',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      fontSize: 18,
                                      useGoogleFonts: false,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                dateFormat(
                                    widget.puntajeSolicitado.evento.fecha),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Light',
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.of(context).primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: FadeInImage(
                        placeholder: const AssetImage(
                          'assets/images/fadeInAnimation.gif',
                        ),
                        placeholderFit: BoxFit.fill,
                        placeholderFilterQuality: FilterQuality.high,
                        image: NetworkImage(
                          widget.puntajeSolicitado.imagen,
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (currentUser!.rol.permisos.validacionPuntaje == 'C')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 30, 0),
                    child: AnimatedHoverButton(
                      icon: Icons.check,
                      tooltip: 'Aceptar',
                      primaryColor: AppTheme.of(context).primaryColor,
                      secondaryColor: AppTheme.of(context).primaryBackground,
                      showLoading: true,
                      onTap: () async {
                        final res = await provider.aceptarPuntaje(
                          widget.puntajeSolicitado,
                        );
                        if (!res) {
                          ApiErrorHandler.callToast('Error al aceptar puntaje');
                        }
                        await provider.getValidacionPuntaje();
                        if (!mounted) return;
                        if (context.canPop()) context.pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 0, 0),
                    child: AnimatedHoverButton(
                      icon: Icons.close,
                      tooltip: 'Rechazar',
                      primaryColor: AppTheme.of(context).primaryColor,
                      secondaryColor: AppTheme.of(context).primaryBackground,
                      showLoading: true,
                      onTap: () async {
                        provider.motivosRechazo.clear();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return PopupRechazoPuntaje(
                              puntajeSolicitado: widget.puntajeSolicitado,
                            );
                          },
                        );
                        await provider.getValidacionPuntaje();
                        if (!mounted) return;
                        if (context.canPop()) context.pop();
                      },
                    ),
                  ),
                ],
              ),
          ],
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
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Información',
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
      ),
    );
  }
}
