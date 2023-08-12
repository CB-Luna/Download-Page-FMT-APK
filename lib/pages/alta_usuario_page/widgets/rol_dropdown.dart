import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:dowload_page_apk/pages/widgets/drop_down.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class RolDropDown extends StatefulWidget {
  const RolDropDown({Key? key}) : super(key: key);

  @override
  State<RolDropDown> createState() => _RolDropDownState();
}

class _RolDropDownState extends State<RolDropDown> {
  @override
  Widget build(BuildContext context) {
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);

    if (provider.roles.isEmpty) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: SpinKitCircle(
            color: AppTheme.of(context).primaryColor,
            size: 50,
          ),
        ),
      );
    } else {
      final List<String> nombresRoles =
          provider.roles.map((rol) => rol.nombreRol).toList();
      String? nombreRolSeleccionado;
      if (provider.rolSeleccionado != null) {
        nombreRolSeleccionado = provider.rolSeleccionado!.nombreRol;
      }
      return CustomDropDown(
        options: nombresRoles,
        initialOption: nombreRolSeleccionado,
        onChanged: (val) async {
          if (val == null) return;
          final String rol = val;
          provider.setRolSeleccionado(rol);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Es obligatorio elegir un rol';
          }
          return null;
        },
        width: 500,
        height: 50,
        textStyle: AppTheme.of(context).bodyText2,
        hint: RichText(
          text: TextSpan(
            text: '  Rol ',
            style: AppTheme.of(context).bodyText2,
            children: [
              TextSpan(
                text: '*',
                style: AppTheme.of(context).bodyText2.override(
                      fontFamily: 'Gotham-Regular',
                      color: AppTheme.of(context).primaryColor,
                      useGoogleFonts: false,
                    ),
              )
            ],
          ),
        ),
        fillColor: AppTheme.of(context).primaryBackground,
        elevation: 1,
        borderColor: AppTheme.of(context).primaryColor,
        borderWidth: 1.5,
        borderRadius: 1,
        margin: EdgeInsets.zero,
        hidesUnderline: true,
        onlyBottomBorder: true,
      );
    }
  }
}
