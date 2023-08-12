import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/providers/visual_state_provider.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class DownloadThemePopup extends StatefulWidget {
  const DownloadThemePopup({Key? key}) : super(key: key);

  @override
  State<DownloadThemePopup> createState() => _DownloadThemePopupState();
}

class _DownloadThemePopupState extends State<DownloadThemePopup> {
  final formKey = GlobalKey<FormState>();
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      VisualStateProvider provider = Provider.of<VisualStateProvider>(
        context,
        listen: false,
      );
      await provider.descargarTemas();
    });
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final VisualStateProvider provider =
        Provider.of<VisualStateProvider>(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
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
          width: MediaQuery.of(context).size.width * 0.175,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: AppTheme.of(context).primaryColor,
            ),
          ),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 25,
                        ),
                        child: Text(
                          'Descargar Tema',
                          style: AppTheme.of(context).title1.override(
                                fontFamily: 'Gotham-Bold',
                                color: AppTheme.of(context).primaryColor,
                                fontSize: 30,
                                useGoogleFonts: false,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      provider.temas.isEmpty
                          ? const CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: provider.temas.length,
                                  itemBuilder: (context, index) {
                                    final TemaDescargado tema =
                                        provider.temas[index];
                                    final bool seleccionado = tema.id ==
                                        provider.temaSeleccionado?.id;
                                    return ThemeCardWidget(
                                      tema: tema,
                                      seleccionado: seleccionado,
                                    );
                                  },
                                ),
                              ),
                            ),
                      AnimatedHoverButton(
                        icon: Icons.check,
                        tooltip: 'Seleccionar',
                        primaryColor: AppTheme.of(context).primaryColor,
                        secondaryColor: AppTheme.of(context).primaryBackground,
                        onTap: () async {
                          if (provider.temaSeleccionado == null) {
                            await ApiErrorHandler.callToast(
                              'Se debe elegir un tema',
                            );
                            return;
                          }
                          final res = await provider.actualizarTema(
                            tema: provider.temaSeleccionado!.tema,
                          );
                          if (!res) {
                            await ApiErrorHandler.callToast(
                              'Error al actualizar los temas',
                            );
                          } else {
                            fToast.showToast(
                              child: const SuccessToast(
                                message: 'Cambio exitoso!',
                              ),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: const Duration(seconds: 2),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 8,
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
        ),
      ),
    );
  }
}

class ThemeCardWidget extends StatefulWidget {
  const ThemeCardWidget({
    Key? key,
    required this.tema,
    required this.seleccionado,
  }) : super(key: key);

  final TemaDescargado tema;
  final bool seleccionado;

  @override
  State<ThemeCardWidget> createState() => _ThemeCardWidgetState();
}

class _ThemeCardWidgetState extends State<ThemeCardWidget> {
  final bool isLight = AppTheme.themeMode == ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    final VisualStateProvider provider =
        Provider.of<VisualStateProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            provider.setTemaSeleccionado(widget.tema);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.seleccionado
                    ? Colors.blueAccent
                    : isLight
                        ? Colors.grey
                        : Colors.white,
              ),
            ),
            child: Row(
              children: [
                Text(
                  widget.tema.nombre,
                  style: AppTheme.of(context).bodyText1,
                ),
                const Spacer(),
                ColorContainer(colorValue: widget.tema.tema.light.primaryColor),
                ColorContainer(
                    colorValue: widget.tema.tema.light.secondaryColor),
                ColorContainer(
                    colorValue: widget.tema.tema.light.tertiaryColor),
                ColorContainer(colorValue: widget.tema.tema.light.primaryText),
                ColorContainer(
                    colorValue: widget.tema.tema.light.primaryBackground),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColorContainer extends StatelessWidget {
  const ColorContainer({
    Key? key,
    required this.colorValue,
  }) : super(key: key);

  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(colorValue),
        ),
      ),
    );
  }
}
