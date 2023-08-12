import 'dart:developer';

import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.icon,
    required this.money,
    required this.onEditingComplete,
    required this.date,
    required this.requiered,
    this.autofocus = false,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData? icon;
  final bool money;
  final bool date;
  final Function onEditingComplete;
  final bool requiered;
  final bool autofocus;
  final Function(String)? onChanged;
  final bool enabled;
  static bool validation = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppTheme.of(context).textoResaltado.override(
                      useGoogleFonts: false,
                      fontFamily: 'Gotham-Bold',
                      color: AppTheme.of(context).primaryText,
                    ),
              ),
              requiered == true
                  ? TextSpan(
                      text: ' *',
                      style: AppTheme.of(context).textoResaltado.override(
                            useGoogleFonts: false,
                            fontFamily: 'Gotham-Bold',
                            color: AppTheme.of(context).primaryColor,
                          ),
                    )
                  : const TextSpan()
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 200,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: validation == true
                  ? AppTheme.of(context).primaryColor
                  : Colors.red,
              width: 1.5,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: AppTheme.of(context).primaryColor),
                child: money == false && date == false
                    ? TextFormField(
                        autofocus: autofocus,
                        controller: controller,
                        keyboardType: TextInputType.text,
                        enabled: enabled,
                        style: AppTheme.of(context).subtitle1.override(
                              useGoogleFonts: false,
                              fontSize: 16,
                              fontFamily: 'Gotham-Regular',
                            ),
                        cursorColor: AppTheme.of(context).primaryColor,
                        decoration: InputDecoration(
                          prefixIcon: icon != null
                              ? Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    icon,
                                    color: AppTheme.of(context).primaryColor,
                                  ),
                                )
                              : null,
                          prefixIconColor: AppTheme.of(context).primaryColor,
                          hintStyle: AppTheme.of(context).hintText,
                          border: InputBorder.none,
                          prefixStyle: AppTheme.of(context).subtitle1,
                          hintText: hintText,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        textAlign: TextAlign.start,
                        onChanged: onChanged,
                        onEditingComplete: () => onEditingComplete,
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            validation = false;
                          } else {
                            validation = true;
                          }
                          return null;
                        },
                      )
                    : money == true
                        ? TextFormField(
                            autofocus: autofocus,
                            controller: controller,
                            keyboardType: TextInputType.number,
                            enabled: enabled,
                            style: AppTheme.of(context).subtitle1.override(
                                  useGoogleFonts: false,
                                  fontSize: 16,
                                  fontFamily: 'Gotham-Regular',
                                ),
                            cursorColor: AppTheme.of(context).primaryColor,
                            decoration: InputDecoration(
                              prefixIcon: icon != null
                                  ? Align(
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Icon(
                                        icon,
                                        color:
                                            AppTheme.of(context).primaryColor,
                                      ),
                                    )
                                  : null,
                              hintStyle: AppTheme.of(context).hintText,
                              border: InputBorder.none,
                              prefixStyle: AppTheme.of(context).subtitle1,
                              hintText: hintText,
                            ),
                            textAlignVertical: TextAlignVertical.bottom,
                            textAlign: TextAlign.start,
                            onChanged: onChanged,
                            onEditingComplete: () => onEditingComplete,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '0.00') {
                                validation = false;
                              } else {
                                validation = true;
                              }
                              return null;
                            },
                          )
                        : TextFormField(
                            autofocus: autofocus,
                            controller: controller,
                            obscureText: false,
                            enabled: enabled,
                            style: AppTheme.of(context).subtitle1.override(
                                  useGoogleFonts: false,
                                  fontSize: 16,
                                  fontFamily: 'Gotham-Regular',
                                ),
                            cursorColor: AppTheme.of(context).primaryColor,
                            decoration: InputDecoration(
                              hintText: hintText,
                              prefixIcon: icon != null
                                  ? Align(
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Icon(
                                        icon,
                                        color:
                                            AppTheme.of(context).primaryColor,
                                      ),
                                    )
                                  : null,
                              hintStyle: AppTheme.of(context).hintText,
                              border: InputBorder.none,
                              prefixStyle: AppTheme.of(context).subtitle1,
                            ),
                            textAlignVertical: TextAlignVertical.bottom,
                            textAlign: TextAlign.start,
                            onTap: () async {
                              try {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  locale: const Locale('es', 'MX'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary:
                                              AppTheme.of(context).primaryColor,
                                        ),
                                        disabledColor:
                                            AppTheme.of(context).secondaryText,
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            disabledBackgroundColor:
                                                AppTheme.of(context)
                                                    .primaryColor,
                                            textStyle: AppTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  useGoogleFonts: false,
                                                  fontSize: 16,
                                                  fontFamily: 'Gotham-Regular',
                                                ),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                controller.text = DateFormat('dd-MM-yyyy')
                                    .format(pickedDate!);
                              } catch (e) {
                                log('Error en custom_text_field.dart - $e');
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '') {
                                validation = false;
                              } else {
                                validation = true;
                              }
                              return null;
                            },
                          ),
              )),
        ),
      ],
    );
  }
}
