import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class PuntajeSolicitadoHeader extends StatefulWidget {
  const PuntajeSolicitadoHeader({Key? key}) : super(key: key);

  @override
  State<PuntajeSolicitadoHeader> createState() =>
      _PuntajeSolicitadoHeaderState();
}

class _PuntajeSolicitadoHeaderState extends State<PuntajeSolicitadoHeader> {
  @override
  Widget build(BuildContext context) {
    final ValidacionPuntajeProvider provider =
        Provider.of<ValidacionPuntajeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              child: Container(
                width: 250,
                height: 51,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppTheme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Icon(
                        Icons.search,
                        color: AppTheme.of(context).primaryColor,
                        size: 24,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: TextFormField(
                            controller: provider.busquedaController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              hintStyle:
                                  AppTheme.of(context).subtitle1.override(
                                        fontSize: 14,
                                        fontFamily: 'Gotham-Light',
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            style: AppTheme.of(context).subtitle1.override(
                                  fontSize: 14,
                                  fontFamily: 'Gotham-Light',
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: false,
                                ),
                            onChanged: (value) async {
                              await provider.getValidacionPuntaje();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
