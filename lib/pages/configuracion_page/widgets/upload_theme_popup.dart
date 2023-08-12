import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/providers/visual_state_provider.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class UploadThemePopup extends StatefulWidget {
  const UploadThemePopup({Key? key}) : super(key: key);

  @override
  State<UploadThemePopup> createState() => _UploadThemePopupState();
}

class _UploadThemePopupState extends State<UploadThemePopup> {
  final formKey = GlobalKey<FormState>();
  FToast fToast = FToast();
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
          height: MediaQuery.of(context).size.height * 0.20,
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
                height: MediaQuery.of(context).size.height * 0.20,
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
                          'Cargar Tema',
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: formKey,
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.nombreTema,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre es obligatorio';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  errorMaxLines: 2,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Nombre',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 132, 132),
                                    fontSize: 15,
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AnimatedHoverButton(
                            icon: Icons.save,
                            tooltip: 'Guardar',
                            primaryColor: AppTheme.of(context).primaryColor,
                            secondaryColor:
                                AppTheme.of(context).primaryBackground,
                            onTap: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              final res = await provider.cargarTema();
                              if (!res) {
                                await ApiErrorHandler.callToast(
                                  'Error al cargar tema',
                                );
                                return;
                              }
                              if (!mounted) return;
                              fToast.showToast(
                                child: const SuccessToast(
                                  message: 'Tema creado',
                                ),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2),
                              );
                              if (context.canPop()) context.pop();
                            },
                          ),
                        ],
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
