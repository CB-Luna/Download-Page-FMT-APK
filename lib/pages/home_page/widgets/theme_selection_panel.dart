import 'package:dowload_page_apk/pages/widgets/custom_button.dart';
import 'package:dowload_page_apk/pages/widgets/toasts/success_toast.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ThemeSelectionPanel extends StatefulWidget {
  const ThemeSelectionPanel({Key? key}) : super(key: key);

  @override
  State<ThemeSelectionPanel> createState() => _ThemeSelectionPanelState();
}

class _ThemeSelectionPanelState extends State<ThemeSelectionPanel> {
  final formKey = GlobalKey<FormState>();
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 550,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Tema claro',
                          style: AppTheme.of(context).title2,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isLight ? Colors.grey : Colors.white,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ColorPickerWidget(
                                  nombre: 'Color Primario',
                                  color: visualState.primaryColorLight,
                                  controller:
                                      visualState.primaryColorLightController,
                                  onSelect: visualState.setPrimaryColorLight,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color Secundario',
                                  color: visualState.secondaryColorLight,
                                  controller:
                                      visualState.secondaryColorLightController,
                                  onSelect: visualState.setSecondaryColorLight,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color Terciario',
                                  color: visualState.tertiaryColorDark,
                                  controller:
                                      visualState.tertiaryColorLightController,
                                  onSelect: visualState.setTerciaryColorLight,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ColorPickerWidget(
                                  nombre: 'Color de Texto Primario',
                                  color: visualState.primaryTextColorLight,
                                  controller:
                                      visualState.primaryTextLightController,
                                  onSelect:
                                      visualState.setPrimaryTextColorLight,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color de Fondo Primario',
                                  color:
                                      visualState.primaryBackgroundColorLight,
                                  controller: visualState
                                      .primaryBackgroundLightController,
                                  onSelect: visualState
                                      .setPrimaryBackgroundColorLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 550,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Tema oscuro',
                          style: AppTheme.of(context).title2,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isLight ? Colors.grey : Colors.white,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ColorPickerWidget(
                                  nombre: 'Color Primario',
                                  color: visualState.primaryColorDark,
                                  controller:
                                      visualState.primaryColorDarkController,
                                  onSelect: visualState.setPrimaryColorDark,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color Secundario',
                                  color: visualState.secondaryColorDark,
                                  controller:
                                      visualState.secondaryColorDarkController,
                                  onSelect: visualState.setSecondaryColorDark,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color Terciario',
                                  color: visualState.tertiaryColorDark,
                                  controller:
                                      visualState.tertiaryColorDarkController,
                                  onSelect: visualState.setTerciaryColorDark,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ColorPickerWidget(
                                  nombre: 'Color de Texto Primario',
                                  color: visualState.primaryTextColorDark,
                                  controller:
                                      visualState.primaryTextDarkController,
                                  onSelect: visualState.setPrimaryTextColorDark,
                                ),
                                ColorPickerWidget(
                                  nombre: 'Color de Fondo Primario',
                                  color: visualState.primaryBackgroundColorDark,
                                  controller: visualState
                                      .primaryBackgroundDarkController,
                                  onSelect:
                                      visualState.setPrimaryBackgroundColorDark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final res = await visualState.actualizarTemas();
                  if (!res) {
                    Fluttertoast.showToast(
                      msg: 'Error al actualizar los temas',
                      toastLength: Toast.LENGTH_SHORT,
                      webBgColor: "#e74c3c",
                      textColor: Colors.black,
                      timeInSecForIosWeb: 5,
                      webPosition: 'center',
                    );
                  } else {
                    fToast.showToast(
                      child: const SuccessToast(
                        message:
                            'Cambio exitoso! Por favor actualiza la página',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                  }
                  if (!mounted) return;
                },
                text: 'Actualizar temas',
                options: ButtonOptions(
                  width: 200,
                  height: 50,
                  color: AppTheme.of(context).primaryColor,
                  textStyle: AppTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    Key? key,
    required this.nombre,
    required this.controller,
    required this.color,
    required this.onSelect,
  }) : super(key: key);

  final String nombre;
  final Color color;
  final TextEditingController controller;
  final void Function(Color) onSelect;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.nombre,
              style: AppTheme.of(context).subtitle1,
            ),
          ),
          Row(
            children: [
              Container(
                width: 150,
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isLight ? Colors.grey : Colors.white,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.controller,
                        validator: (value) {
                          RegExp regex = RegExp(r'^[A-Fa-f0-9]{8}$');
                          if (value == null || value.isEmpty) {
                            return 'El color es obligatorio';
                          } else if (!regex.hasMatch(value)) {
                            return 'El formato es incorrecto';
                          }
                          return null;
                        },
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Valor hexadecimal...',
                          labelStyle: AppTheme.of(context).bodyText2,
                          hintStyle: AppTheme.of(context).bodyText2,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(bottom: 15),
                        ),
                        style: AppTheme.of(context).bodyText1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ColorIndicator(
                      height: 30,
                      width: 30,
                      color: widget.color,
                      onSelectFocus: false,
                      selectedRequestsFocus: true,
                      onSelect: () async {
                        // Store current color before we open the dialog.
                        final Color colorBeforeDialog = widget.color;
                        // Wait for the picker to close, if dialog was dismissed,
                        // then restore the color we had before it was opened.
                        if (!(await colorPickerDialog(
                          widget.color,
                          widget.onSelect,
                        ))) {
                          widget.onSelect(colorBeforeDialog);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> colorPickerDialog(
    Color color,
    void Function(Color) onColorChanged,
  ) async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: color,
      // Update the dialogPickerColor using the callback.
      onColorChanged: onColorChanged,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Selecciona un color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Selecciona la sombra',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selecciona el color y sus sombras',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
