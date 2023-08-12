import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../providers/jefes_area_provider.dart';
import '../../../theme/theme.dart';
import 'popup_animacion.dart';

class PopupconfirmacionWidget extends StatefulWidget {
  const PopupconfirmacionWidget({
    Key? key,
    required this.avatarOld,
    required this.nombreOld,
    required this.nombreNew,
    required this.avatarNew,
  }) : super(key: key);
  final String avatarOld;
  final String nombreOld;
  final String nombreNew;
  final String avatarNew;
  @override
  _PopupconfirmacionWidgetState createState() =>
      _PopupconfirmacionWidgetState();
}

class _PopupconfirmacionWidgetState extends State<PopupconfirmacionWidget> {
  @override
  Widget build(BuildContext context) {
    final JefesAreaProvider provider = Provider.of<JefesAreaProvider>(context);
    return Container(
      width: 672,
      height: 288,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Confirmar transferencia',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFFF8600),
                          fontSize: 25,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.avatarOld,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                widget.nombreOld,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.people_alt,
                    color: Colors.black,
                    size: 35,
                  ),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                ],
              ),
              Text(
                widget.nombreNew,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.avatarNew,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Button aceptado');
                  if (provider.botonTransferir == true) {
                    provider.transferencia(provider.jefeOld.toString(),
                        provider.selectedRadio.toString());

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(content: AnimacionSuccesWidget());
                        // Widget personalizado
                      },
                    );
                  } else {
                    print("bloqueado");
                  }
                },
                child: Text('Confirmar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
