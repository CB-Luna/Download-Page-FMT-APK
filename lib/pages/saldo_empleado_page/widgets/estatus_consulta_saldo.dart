import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/providers/saldo_controller.dart';
import 'package:dowload_page_apk/theme/theme.dart';

class EstatusConsultaSaldoWidget extends StatefulWidget {
  const EstatusConsultaSaldoWidget({Key? key}) : super(key: key);

  @override
  State<EstatusConsultaSaldoWidget> createState() =>
      _EstatusConsultaSaldoWidgetState();
}

class _EstatusConsultaSaldoWidgetState extends State<EstatusConsultaSaldoWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SaldoController provider =
          Provider.of<SaldoController>(
        context,
        listen: false,
      );
      // await provider.getNumPuntos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SaldoController provider =
        Provider.of<SaldoController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6.0,
                      color: Color(0x4B1A1F24),
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                  gradient: LinearGradient(
                    colors: [AppTheme.of(context).gris, AppTheme.of(context).primaryColor],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(0.94, -1.0),
                    end: const AlignmentDirectional(-0.94, 1.0),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 20.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'PUNTOS' /* PUNTOS */,
                            style: AppTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Lexend',
                                color: AppTheme.of(context)
                                    .gris,
                                fontSize: 20
                              ),
                          ),
                          const Spacer(),
                          EstatusWidget(
                            numPuntos: provider.registroPuntajeGanado,
                            texto: 'Puntaje Ganado',
                            isTaped: provider.isTaped[1],
                            onTap: () async {
                              provider.seleccionado(1);
                              provider.estatusFiltrado = 'Puntaje Ganado';
                              await provider.getRegistrosSaldo();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 10.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          EstatusWidget(
                            numPuntos: provider.registroPuntajeGastado,
                            texto: 'Puntaje Gastado',
                            isTaped: provider.isTaped[2],
                            onTap: () async {
                              provider.seleccionado(2);
                              provider.estatusFiltrado = 'Puntaje Gastado';
                              await provider.getRegistrosSaldo();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 10.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Saldo ' /* Saldo */,
                            style: AppTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Lexend',
                                  color: AppTheme.of(context)
                                      .tertiaryColor,
                                  fontSize: 20
                                ),
                          ),
                          EstatusWidgetSaldo(
                            numPuntos: provider.registroTotal,
                            texto: '',
                            isTaped: provider.isTaped[0],
                            width: 120,
                            onTap: () async {
                              provider.seleccionado(0);
                              provider.estatusFiltrado = 'Saldo Total';
                              await provider.getRegistrosSaldo();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 12.0, 20.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Id Usuario: ${currentUser?.idSecuencial}',
                            style: AppTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Roboto Mono',
                                  color: AppTheme.of(context)
                                      .tertiaryColor,
                                ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                            .format(DateTime.now()),
                            style: AppTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Roboto Mono',
                                  color: AppTheme.of(context)
                                      .tertiaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 2,
            color: AppTheme.of(context).gris,
          ),
        ),
      ],
    );
  }
}

class EstatusWidget extends StatefulWidget {
  const EstatusWidget({
    Key? key,
    required this.numPuntos,
    required this.texto,
    required this.isTaped,
    required this.onTap,
    this.width = 240,
  }) : super(key: key);

  final int numPuntos;
  final String texto;
  final bool isTaped;
  final double width;
  final void Function() onTap;

  @override
  State<EstatusWidget> createState() => _EstatusWidgetState();
}

class _EstatusWidgetState extends State<EstatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedButton.strip(
          width: widget.width,
          height: 40,
          text: '  ${widget.texto}',
          textMaxLine: 2,
          textOverflow: TextOverflow.ellipsis,
          textStyle: AppTheme.of(context).bodyText1,
          textAlignment: Alignment.centerLeft,
          stripTransitionType: StripTransitionType.RIGHT_TO_LEFT,
          // isReverse: true,
          isSelected: widget.isTaped,
          backgroundColor: AppTheme.of(context).gris,
          stripColor: AppTheme.of(context).primaryColor,
          selectedTextColor: AppTheme.of(context).primaryBackground,
          selectedBackgroundColor: AppTheme.of(context).primaryColor,
          onPress: widget.onTap,
        ),
        Positioned(
          right: 10,
          child: IgnorePointer(
            child: Container(
              width: 100,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.isTaped
                    ? AppTheme.of(context).gris
                    : AppTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.numPuntos.toString(),
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Gotham-Regular',
                            color: AppTheme.of(context).primaryText,
                            useGoogleFonts: false,
                            fontSize: 20
                          ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/LogoBD.png',
                    height: 22,
                    fit: BoxFit.cover,
                  ) 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EstatusWidgetSaldo extends StatefulWidget {
  const EstatusWidgetSaldo({
    Key? key,
    required this.numPuntos,
    required this.texto,
    required this.isTaped,
    required this.onTap,
    this.width = 220,
  }) : super(key: key);

  final int numPuntos;
  final String texto;
  final bool isTaped;
  final double width;
  final void Function() onTap;

  @override
  State<EstatusWidgetSaldo> createState() => _EstatusWidgetSaldoState();
}

class _EstatusWidgetSaldoState extends State<EstatusWidgetSaldo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedButton.strip(
          width: widget.width,
          height: 40,
          text: '  ${widget.texto}',
          textMaxLine: 2,
          textOverflow: TextOverflow.ellipsis,
          textStyle: AppTheme.of(context).bodyText1,
          textAlignment: Alignment.centerLeft,
          stripTransitionType: StripTransitionType.RIGHT_TO_LEFT,
          // isReverse: true,
          isSelected: widget.isTaped,
          backgroundColor: AppTheme.of(context).gris,
          stripColor: AppTheme.of(context).primaryColor,
          selectedTextColor: AppTheme.of(context).primaryBackground,
          selectedBackgroundColor: AppTheme.of(context).primaryColor,
          onPress: widget.onTap,
        ),
        IgnorePointer(
          child: Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.isTaped
                  ? AppTheme.of(context).gris
                  : AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.numPuntos.toString(),
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Gotham-Regular',
                          color: AppTheme.of(context).primaryText,
                          useGoogleFonts: false,
                          fontSize: 20
                        ),
                  ),
                ),
                Image.asset(
                  'assets/images/LogoBD.png',
                  height: 22,
                  fit: BoxFit.cover,
                ) 
              ],
            ),
          ),
        ),
      ],
    );
  }
}
