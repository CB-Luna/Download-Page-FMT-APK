import 'package:dowload_page_apk/theme/theme.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

import 'popup_confirmacion.dart';

class PopupTransferirEmpleadosWidget extends StatefulWidget {
  const PopupTransferirEmpleadosWidget({
    Key? key,
    required this.jefeAreaId,
    required this.nombreJefe,
    required this.avatarJefe,
    required this.listajefe,
    required this.emailJefe,
  }) : super(key: key);

  final List<dynamic> jefeAreaId;
  final List<dynamic> listajefe;
  final String nombreJefe;
  final String avatarJefe;
  final String emailJefe;

  @override
  _PopupTransferirEmpleadosWidgetState createState() =>
      _PopupTransferirEmpleadosWidgetState();
}

class _PopupTransferirEmpleadosWidgetState
    extends State<PopupTransferirEmpleadosWidget> {
  TextEditingController? textController;

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final JefesAreaProvider provider = Provider.of<JefesAreaProvider>(context);

    return Material(
      color: Colors.transparent,
      elevation: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tranferencia de empleados a Jefe de Área',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Darás de baja al jefe de área : ${widget.nombreJefe}',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      widget.avatarJefe,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nombreJefe,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'correo electrónico:',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            widget.emailJefe,
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                    child: Text(
                      'Empleados a cargo de ${widget.nombreJefe}',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 100, 0),
                    child: Text(
                      'Jefes de Área Disponibles',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//**************************  LISTA DERECHA ***************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
//*********************************************************************
                //forEach widget.jefeAreaId ListaDeEmpleados

                /*       for (var element in widget.jefeAreaId)
                  ListaDeEmpleados(
                    nombre: element['nombre_completo'].toString(),
                    avatar: element['foto'].toString(),
                    areaTrabajo: element['areatrabajo'].toString(),
                    id: element['id_empleado_pk'].toString(),
                  ), */
                /*  ListaDeEmpleados(
                  nombre: widget.jefeAreaId[0]['nombre_completo'].toString(),
                  avatar: widget.jefeAreaId[0]['foto'].toString(),
                  areaTrabajo: widget.jefeAreaId[0]['areatrabajo'].toString(),
                  id: widget.jefeAreaId[0]['id_empleado_pk'].toString(),
                ), */
                ListaDeEmpleados(
                  empleado: widget.jefeAreaId,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Transferir Empleados',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: MaterialButton(
                        color: provider.botonTransferir == true
                            ? const Color(0XFFf26925)
                            : const Color.fromARGB(118, 158, 158, 158),
                        textColor: Colors.white,
                        mouseCursor: provider.botonTransferir == true
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.forbidden,
                        disabledElevation:
                            provider.botonTransferir == true ? 2.0 : 0.0,
                        elevation: provider.botonTransferir == true ? 2.0 : 0.0,
                        hoverElevation:
                            provider.botonTransferir == true ? 2.0 : 0.0,
                        focusElevation:
                            provider.botonTransferir == true ? 2.0 : 0.0,
                        highlightElevation:
                            provider.botonTransferir == true ? 2.0 : 0.0,
                        focusColor: provider.botonTransferir == true
                            ? const Color.fromARGB(255, 255, 107, 33)
                            : Colors.transparent,
                        hoverColor: provider.botonTransferir == true
                            ? const Color.fromARGB(255, 255, 126, 61)
                            : Colors.transparent,
                        enableFeedback: false,
                        onPressed: () {
                          print('Button transferencia presionado');
                          if (provider.botonTransferir == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: PopupconfirmacionWidget(
                                  avatarOld: widget.avatarJefe,
                                  nombreOld: widget.nombreJefe,
                                  avatarNew: provider.avatarNew.toString(),
                                  nombreNew: provider.nombreNew.toString(),
                                )
                                    // Widget personalizado
                                    );
                              },
                            );
                          } else {
                            print("bloqueado");
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          size: (MediaQuery.of(context).size.width * 25 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
                ListaJefesArea(
                    textController: textController, jefes: widget.listajefe),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListaJefesArea extends StatefulWidget {
  const ListaJefesArea({
    Key? key,
    required this.textController,
    required this.jefes,
  }) : super(key: key);
  final List<dynamic> jefes;
  final TextEditingController? textController;

  @override
  State<ListaJefesArea> createState() => _ListaJefesAreaState();
}

class _ListaJefesAreaState extends State<ListaJefesArea> {
  bool? checkboxValue;

  @override
  Widget build(BuildContext context) {
    final JefesAreaProvider provider = Provider.of<JefesAreaProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        //Buscador(widget: widget),
        Container(
          width: MediaQuery.of(context).size.width * 0.28,
          height: MediaQuery.of(context).size.height * 0.52,
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.of(context).tertiaryColor,
              width: 2,
            ),
          ),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.jefes.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0x40EE8B60),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 5, 5, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Radio(
                                    value: widget.jefes[index]
                                            ['perfil_usuario_id']
                                        .toString(),
                                    groupValue: provider.selectedRadio,
                                    onChanged: provider.handleRadioValueChange,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      widget.jefes[index]['avatar'].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              widget.jefes[index]['nombre']
                                                  .toString(),
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Cantidad empleados: ',
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              widget.jefes[index]
                                                      ['cant_empleados']
                                                  .toString(),
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}

class Buscador extends StatelessWidget {
  const Buscador({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ListaJefesArea widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0x49FFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0x39000000),
            )
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                  child: TextFormField(
                    controller: widget.textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Buscar...',
                      labelStyle: AppTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: AppTheme.of(context).primaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).tertiaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
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

class ListaDeEmpleados extends StatelessWidget {
  ListaDeEmpleados({
    Key? key,
    required this.empleado,
  }) : super(key: key);
  List<dynamic> empleado;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.52,
            decoration: BoxDecoration(
              color: AppTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.of(context).tertiaryColor,
                width: 2,
              ),
            ),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: empleado.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x40EE8B60),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        empleado[index]['foto'].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                empleado[index]
                                                        ['nombre_completo']
                                                    .toString(),
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Área de trabajo: ',
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              Text(
                                                empleado[index]['areatrabajo']
                                                    .toString(),
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })),
      ],
    );
  }
}
