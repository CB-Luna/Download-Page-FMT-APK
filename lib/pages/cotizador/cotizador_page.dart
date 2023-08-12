import 'dart:convert';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/cotizador/widgets/carga_factura_popup.dart';
import 'package:dowload_page_apk/pages/widgets/animated_hover_button.dart';
import 'package:dowload_page_apk/pages/widgets/side_menu/side_menu.dart';
import 'package:dowload_page_apk/pages/widgets/top_menu/top_menu.dart';
import 'package:dowload_page_apk/providers/cotizador_provider.dart';
import 'package:dowload_page_apk/providers/visual_state_provider.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';
import '../widgets/dDown.dart';

class CotizadorPage extends StatefulWidget {
  CotizadorPage({Key? key}) : super(key: key);

  @override
  _CotizadorPageState createState() => _CotizadorPageState();
}

class _CotizadorPageState extends State<CotizadorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final CotizadorProvider provider = Provider.of<CotizadorProvider>(
        context,
        listen: false,
      );
      await provider.clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);
    final CotizadorProvider provider = Provider.of<CotizadorProvider>(context);
    visualState.setTapedOption(11);

    return Scaffold(
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const TopMenuWidget(
              title: 'Cotizador',
            ),
            Expanded(
              child: Row(
                children: [
                  const SideMenuWidget(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: AnimatedHoverButton(
                                      primaryColor: AppTheme.of(context).primaryColor,
                                      secondaryColor: AppTheme.of(context).primaryBackground,
                                      icon: Icons.play_arrow_outlined,
                                      tooltip: 'Ejecutar',
                                      onTap: () async {},
                                    ),
                                  ),
                                  /* (provider.pdfController != null && provider.docProveedor != null && provider.popupVisorPdfVisible)
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: AnimatedHoverButton(
                                            tooltip: 'Ver Documento',
                                            primaryColor: AppTheme.of(context).primaryColor,
                                            secondaryColor: AppTheme.of(context).primaryBackground,
                                            icon: Icons.remove_red_eye,
                                            onTap: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return StatefulBuilder(builder: (context, setState) {
                                                      return CargaFacturaPopUp(provider: provider);
                                                    });
                                                  });
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                  (provider.pdfController != null && provider.docProveedor != null && provider.popupVisorPdfVisible)
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: AnimatedHoverButton(
                                            tooltip: 'Borrar Documento',
                                            primaryColor: AppTheme.of(context).primaryColor,
                                            secondaryColor: AppTheme.of(context).primaryBackground,
                                            icon: Icons.delete,
                                            onTap: () async {
                                              provider.clearDoc();
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                  (provider.pdfController != null && provider.docProveedor != null && provider.popupVisorPdfVisible)
                                      ? const SizedBox()
                                      : AnimatedHoverButton(
                                          primaryColor: AppTheme.of(context).primaryColor,
                                          secondaryColor: AppTheme.of(context).primaryBackground,
                                          icon: Icons.upload_file,
                                          tooltip: 'cargar oc', //currentUser!.rol.idRolPk == 1 ? 'Cargar Factura' : 'Cargar Orden de Compra',
                                          onTap: () async {
                                            await provider.pickProveedorDoc();
                                            if (provider.pdfController != null && provider.docProveedor != null && provider.popupVisorPdfVisible) {
                                              provider.verPdf(true);
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return StatefulBuilder(builder: (context, setState) {
                                                      return CargaFacturaPopUp(provider: provider);
                                                    });
                                                  });
                                            }
                                          },
                                        )
                                 */
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20, left: 20),
                                child: AnimatedHoverButton(
                                  primaryColor: AppTheme.of(context).primaryColor,
                                  secondaryColor: AppTheme.of(context).primaryBackground,
                                  icon: Icons.file_download_outlined,
                                  tooltip: 'Descargar',
                                  onTap: () async {
                                    await provider.descargarCotizacion();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.15,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: Form(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            child: TextFormField(
                                              controller: provider.textController1,
                                              autofocus: true,
                                              obscureText: false,
                                              cursorColor: AppTheme.of(context).primaryColor,
                                              decoration: tFFInputDecoration(context, 'Cotización'),
                                              style: AppTheme.of(context).bodyText1.override(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.15,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: Form(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            child: TextFormField(
                                              controller: provider.textController2,
                                              autofocus: true,
                                              obscureText: false,
                                              cursorColor: AppTheme.of(context).primaryColor,
                                              decoration: tFFInputDecoration(context, 'Ubicación'),
                                              style: AppTheme.of(context).bodyText1.override(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.15,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: Form(
                                            autovalidateMode: AutovalidateMode.disabled,
                                            child: TextFormField(
                                              controller: provider.textControllerRango,
                                              autofocus: true,
                                              obscureText: false,
                                              cursorColor: AppTheme.of(context).primaryColor,
                                              decoration: tFFInputDecoration(context, 'Rango'),
                                              style: AppTheme.of(context).bodyText1.override(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.15,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          child: InkWell(
                                            child: Form(
                                              autovalidateMode: AutovalidateMode.disabled,
                                              child: TextFormField(
                                                autofocus: true,
                                                obscureText: false,
                                                enabled: false,
                                                cursorColor: AppTheme.of(context).primaryColor,
                                                decoration: tFFInputDecoration(context, 'Rango'),
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                            onTap: () async {
                                              var range = await showDateRangePicker(
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(
                                                      colorScheme: ColorScheme.light(
                                                        primary: AppTheme.of(context).primaryColor, // color Appbar
                                                        onPrimary: AppTheme.of(context).primaryBackground, // Color letras
                                                        onSurface: AppTheme.of(context).primaryColor, // Color Meses
                                                      ),
                                                      dialogBackgroundColor: AppTheme.of(context).primaryBackground,
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                                initialEntryMode: DatePickerEntryMode.input,
                                                context: context,
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(3000),
                                                currentDate: DateTime.now(),
                                                locale: const Locale('es', 'MX'),
                                              );
                                              if (range != null) {
                                                provider.textControllerRango.text =
                                                    '${range.start.day}/${range.start.month}/${range.start.year} - ${range.end.day}/${range.end.month}/${range.end.year}';
                                                provider.fechaIni = range.start;
                                                provider.fechaFin = range.end;
                                                await provider.getPedidos();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                    child: SizedBox(
                                      width: 585,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 480,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context).primaryBackground,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            child: Form(
                                              autovalidateMode: AutovalidateMode.disabled,
                                              child: TextFormField(
                                                controller: provider.textController5,
                                                autofocus: true,
                                                obscureText: false,
                                                cursorColor: AppTheme.of(context).primaryColor,
                                                decoration: tFFInputDecoration(context, 'Correo'),
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ButtonWidget(
                                                  onPressed: () {
                                                    Clipboard.getData(Clipboard.kTextPlain).then((value) {
                                                      if (value?.text.toString() != null || value?.text.toString() != '') {
                                                        provider.textController5.text = value!.text.toString();
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  text: 'Paste',
                                                  options: ButtonOptions(
                                                    height: 35,
                                                    color: AppTheme.of(context).primaryBackground,
                                                    textStyle: AppTheme.of(context).subtitle2.override(
                                                          fontFamily: 'Poppins',
                                                          color: AppTheme.of(context).primaryColor,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: AppTheme.of(context).primaryColor,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
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
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                child: SizedBox(
                                  height: 250,
                                  child: VerticalDivider(
                                    thickness: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).primaryBackground,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 450,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context).primaryBackground,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: AppTheme.of(context).primaryText,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 450,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context).primaryColor,
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'CANTIDAD', // currentUser!.rol.idRolPk == 1 ? 'Invoice total amount' : 'Purchase Order Amount',
                                                textAlign: TextAlign.center,
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                                            child: Container(
                                              width: 450,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Productos',
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      provider.listCarrito.length.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                                            child: Container(
                                              width: 450,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Piezas',
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      provider.piezas.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          /* Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                                            child: Container(
                                              width: 450,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Total',
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryText,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      provider.total.toString(),
                                                      //'\$ ${moneyFormat(provider.total)} USD',
                                                      textAlign: TextAlign.center,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            color: AppTheme.of(context).primaryText,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ), */
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.90,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'ID Producto',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 350,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'Nombre',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'Cantidad',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'Puntos',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 25,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                            child: Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'Total',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: AppTheme.of(context).primaryBackground,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.90,
                                        decoration: BoxDecoration(
                                          color: AppTheme.of(context).primaryBackground,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppTheme.of(context).primaryText,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 80,
                                                  decoration: const BoxDecoration(),
                                                  child: TextFormField(
                                                    controller: provider.textControllerItemID,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.digitsOnly,
                                                    ],
                                                    cursorColor: AppTheme.of(context).primaryColor,
                                                    decoration: tFFInputDecoration(context, 'ID Producto'),
                                                    style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                    onChanged: (value) async {
                                                      if (value.isNotEmpty) {
                                                        var response = await supabase.from('producto').select('nombre,costo').eq('producto_id', value);
                                                        if (response.isNotEmpty) {
                                                          var descripcion = jsonEncode(response[0]['nombre']).replaceAll('"', '');
                                                          var costo = jsonEncode(response[0]['costo']).replaceAll('"', '');
                                                          provider.textControllerDescription.text = descripcion;
                                                          provider.textControllerPoints.text = costo;
                                                        } else {
                                                          provider.textControllerDescription.text = '';
                                                          provider.textControllerPoints.text = '';
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 350,
                                                  decoration: const BoxDecoration(),
                                                  child: TextFormField(
                                                    controller: provider.textControllerDescription,
                                                    enabled: false,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    cursorColor: AppTheme.of(context).primaryColor,
                                                    decoration: tFFInputDecoration(context, 'Nombre'),
                                                    style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 100,
                                                  decoration: const BoxDecoration(),
                                                  child: TextFormField(
                                                    controller: provider.textControllerQuantity,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.digitsOnly,
                                                    ],
                                                    cursorColor: AppTheme.of(context).primaryColor,
                                                    decoration: tFFInputDecoration(context, 'Cantidad'),
                                                    onChanged: (value) {
                                                      provider.textControllerTotal.text =
                                                          (double.parse(provider.textControllerQuantity.text) * double.parse(provider.textControllerPoints.text)).toString();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 120,
                                                  decoration: const BoxDecoration(),
                                                  child: TextFormField(
                                                    controller: provider.textControllerPoints,
                                                    enabled: false,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
                                                    ],
                                                    cursorColor: AppTheme.of(context).primaryColor,
                                                    decoration: tFFInputDecoration(context, 'Puntos'),
                                                    style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                    onChanged: (value) {
                                                      provider.textControllerTotal.text =
                                                          (double.parse(provider.textControllerQuantity.text) * double.parse(provider.textControllerPoints.text)).toString();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: SizedBox(
                                                  width: 25,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                                        child: InkWell(
                                                          child: const Icon(
                                                            Icons.add_circle,
                                                            color: Colors.green,
                                                            size: 24,
                                                          ),
                                                          onTap: () {
                                                            if (provider.textControllerItemID.text == '' ||
                                                                provider.textControllerDescription.text == '' ||
                                                                provider.textControllerQuantity.text == '' ||
                                                                provider.textControllerPoints.text == '') {
                                                              ApiErrorHandler.callToast('Favor de ingresar todos los campos para añadir un nuevo producto');
                                                            } else {
                                                              provider.addCarrito();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                          size: 24,
                                                        ),
                                                        onTap: () {
                                                          provider.textControllerItemID.text = '';
                                                          provider.textControllerDescription.text = '';
                                                          provider.textControllerQuantity.text = '';
                                                          provider.textControllerPoints.text = '';
                                                          provider.textControllerTotal.text = '';
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                child: Container(
                                                  width: 120,
                                                  decoration: const BoxDecoration(),
                                                  child: TextFormField(
                                                    controller: provider.textControllerTotal,
                                                    enabled: false,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    cursorColor: AppTheme.of(context).primaryColor,
                                                    decoration: tFFInputDecoration(context, 'Total'),
                                                    style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  child: PlutoGrid(
                                    key: UniqueKey(),
                                    configuration: PlutoGridConfiguration(
                                      localeText: const PlutoGridLocaleText.spanish(),
                                      scrollbar: plutoGridScrollbarConfig(context),
                                      style: plutoGridStyleConfig(context),
                                      columnFilter: const PlutoGridColumnFilterConfig(
                                        filters: [
                                          ...FilterHelper.defaultFilters,
                                        ],
                                      ),
                                    ),
                                    columns: [
                                      PlutoColumn(
                                        title: 'ID Producto',
                                        field: 'itemID',
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                      ),
                                      PlutoColumn(
                                        title: 'Nombre',
                                        field: 'nombre',
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                      ),
                                      PlutoColumn(
                                        title: 'Cant',
                                        field: 'quantity',
                                        width: 100,
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                      ),
                                      /* PlutoColumn(
                                        title: 'Puntos',
                                        field: 'points',
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                double.parse(rendererContext.cell.value).toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ],
                                          );
                                        },
                                      ), */
                                      /* PlutoColumn(
                                        title: 'Total',
                                        field: 'total',
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                double.parse(rendererContext.cell.value).toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ],
                                          );
                                        },
                                      ), */
                                      PlutoColumn(
                                        title: 'Acciones',
                                        field: 'acciones',
                                        width: 150,
                                        titleTextAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableContextMenu: false,
                                        enableFilterMenuItem: false,
                                        enableSorting: false,
                                        enableSetColumnsMenuItem: false,
                                        enableHideColumnMenuItem: false,
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return InkWell(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: 24,
                                            ),
                                            onTap: () async {
                                              provider.listCarrito.removeAt(rendererContext.rowIdx);
                                              await provider.removeCarrito();
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                    rows: provider.listCarrito,
                                    onLoaded: (event) async {
                                      provider.stateManager = event.stateManager;
                                      provider.stateManager!.setShowColumnFilter(true);
                                      provider.stateManager!.setSelectingMode(
                                        PlutoGridSelectingMode.row,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
