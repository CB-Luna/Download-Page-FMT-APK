import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:excel/excel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/pages/tablero/qt/grafica_puntos_mes.dart';
import 'package:dowload_page_apk/pages/tablero/qt/grafica_puntos_totales.dart';
import 'package:dowload_page_apk/pages/tablero/qt/tabla_compras.dart';
import 'package:dowload_page_apk/pages/tablero/qt/tabla_puntos_evento.dart';
import 'package:dowload_page_apk/pages/tablero/qt/tabla_puntos_ganados.dart';
import 'package:dowload_page_apk/pages/tablero/samples/dateranges.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:dowload_page_apk/helpers/globals.dart';

class TableroStateProvider extends ChangeNotifier {
  TableroStateProvider() {
    touchedValue = -1;
    updateState();
  }
/////////////////////////////////////////////////////////////
  /// Grafica Ahorro_Beneficio
  Color facturacionNormal = const Color(0XFFf26925);
  Color cAhorro = const Color(0xFF2D59CA);
  Color ahorroPullNp = const Color(0xFF0BACC2);
  Color ahorroPullPn = const Color(0xFFEC9E0D);
  Color ahorroPushNP = const Color(0xFF9B18F3);
  late double touchedValue;
  int condiciontabla = 0;
  int condicionInicialTabla = 5;
  String name = '';

  List<List<dynamic>> pullnc = [];
  List<List<dynamic>> puntosahorro = [];
  List<GraficaPuntosTotales> getTotales = [];

  /////////////////////////////////////////////////////////////
  ///Tablero
  var titleGroup = AutoSizeGroup();
  var contenGroup = AutoSizeGroup();
  List<List<dynamic>> listTablero = [];
  DateTimeRange dateRange = DateTimeRange(
      start: findFirstDateOfTheMonth(DateTime.now()),
      end: findLastDateOfTheMonth(DateTime.now()));
  /////////////////////////////////////////////////////////////
  ///Reporte Seguimiento de facturas
  List<PlutoRow> rowsReporte = [];

  //////////////////////////////////////////////////////////////
  /// Tabla_v2
  List<PlutoRow> rowsbitacora = [];
  List<PlutoRow> rows = [];
  List<PlutoRow> rowsv2 = [];
  List<bool> pageChecked = [];
  PlutoGridStateManager? stateManager;
  List<TablaPuntosGanados> listapganados = [];
  List<TablaPuntosEvento> listapevento = [];
  List<TablaCompras> listcompras = [];
  var tableTopGroup = AutoSizeGroup();
  var tableContentGroup = AutoSizeGroup();
  final controllerBusqueda = TextEditingController();
  DateTime fechainiTabla = findFirstDateOfTheMonth(DateTime.now());
  DateTime fechafinTabla = findLastDateOfTheMonth(DateTime.now());
  ///////////////////////////////////////////////
  /// Grafica Perdidas
  Color facturacionNormalPerdidas = const Color(0XFFf26925);
  Color cAhorroPerdidas = const Color(0xFF2D59CA);
  Color ahorroPullNpPerdidas = const Color(0xFF0BACC2);
  Color ahorroPullPnPerdidas = const Color(0xFFEC9E0D);
  Color ahorroPushNPPerdidas = const Color(0xFF9B18F3);
  int touchedIndex = -1;
  List<GraficaPuntosMes> pmes = [];
  String mes = DateFormat.yMMM('es_MX').format(DateTime.now());
  String mesFinPerdidas = "";
  int x = DateTime.now().year.toInt();
////////////////////////////////////////////////////////////////////////////////////

  Future<void> updateState() async {
    await graficaPuntosTotales(DateTime.now());
    await graficaPuntosMes();
    await tablaCompras();
    await tablaPuntosGanados();
  }

//////////////////////////////////////////////

  /// Tablero
  Future<void> pickDateRange(
    BuildContext context,
  ) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        locale: const Locale("es", ""),
        initialDateRange: dateRange,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary:
                    AppTheme.of(context).primaryBackground, // Color letras
                onSurface: AppTheme.of(context).primaryColor, // Color Meses
              ),
              dialogBackgroundColor: AppTheme.of(context).primaryBackground,
            ),
            child: child!,
          );
        },
        initialEntryMode: DatePickerEntryMode.input);
    if (newDateRange == null) return;
    dateRange = newDateRange;
    fechafinTabla = dateRange.end;
    fechainiTabla = dateRange.start;
    mes = (DateFormat.yMMM('es_MX').format(dateRange.start));
    mesFinPerdidas = (DateFormat.yMMM('es_MX').format(dateRange.end));
    await tablaPuntosGanados();
    await graficaPuntosMes();
    await tablaCompras();
    await graficaPuntosTotales(dateRange.start);
    notifyListeners();
  }

  ///Tabla Tablero

  Future<void> tablaPuntosGanados() async {
    try {
      switch (condiciontabla) {
        case 0:
          final response = await supabase.rpc('tabla_puntos_evento', params: {
            'fechaini': fechainiTabla.toString(),
            'fechafin': fechafinTabla.toString(),
            'usuario': currentUser?.id,
            'condicion': condiciontabla
          });
          listapevento.clear();
          listapevento = (response as List<dynamic>)
              .map((factura) => TablaPuntosEvento.fromJson(jsonEncode(factura)))
              .toList();
          rows.clear();
          for (var i = 0; i < listapevento.length - 1; i++) {
            rows.add(
              PlutoRow(
                cells: {
                  'nombre': PlutoCell(value: listapevento[i].nombre),
                  'evento': PlutoCell(value: listapevento[i].idEvento),
                  'descripcion': PlutoCell(value: listapevento[i].descripcion),
                  'puntos': PlutoCell(value: listapevento[i].puntos),
                  'fecha': PlutoCell(value: dateFormat(listapevento[i].fecha)),
                },
              ),
            );
          }
          break;
        case 1:
          final response = await supabase.rpc('tabla_puntos_evento', params: {
            'fechaini': fechainiTabla.toString(),
            'fechafin': fechafinTabla.toString(),
            'usuario': currentUser?.id,
            'condicion': condiciontabla
          });
          listapevento.clear();
          listapevento = (response as List<dynamic>)
              .map((factura) => TablaPuntosEvento.fromJson(jsonEncode(factura)))
              .toList();
          rows.clear();
          for (var i = 0; i < listapevento.length - 1; i++) {
            rows.add(
              PlutoRow(
                cells: {
                  'nombre': PlutoCell(value: listapevento[i].nombre),
                  'evento': PlutoCell(value: listapevento[i].idEvento),
                  'descripcion': PlutoCell(value: listapevento[i].descripcion),
                  'puntos': PlutoCell(value: listapevento[i].puntos),
                  'fecha': PlutoCell(value: dateFormat(listapevento[i].fecha)),
                },
              ),
            );
          }
          break;
        case 2:
          final response = await supabase.rpc('tabla_puntos_evento', params: {
            'fechaini': fechainiTabla.toString(),
            'fechafin': fechafinTabla.toString(),
            'usuario': currentUser?.id,
            'condicion': condiciontabla
          });
          listapevento.clear();
          listapevento = (response as List<dynamic>)
              .map((factura) => TablaPuntosEvento.fromJson(jsonEncode(factura)))
              .toList();
          rows.clear();
          for (var i = 0; i < listapevento.length - 1; i++) {
            rows.add(
              PlutoRow(
                cells: {
                  'nombre': PlutoCell(value: listapevento[i].nombre),
                  'evento': PlutoCell(value: listapevento[i].idEvento),
                  'descripcion': PlutoCell(value: listapevento[i].descripcion),
                  'puntos': PlutoCell(value: listapevento[i].puntos),
                  'fecha': PlutoCell(value: dateFormat(listapevento[i].fecha)),
                },
              ),
            );
          }
          break;
        default:
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      // log(e);
    }
    notifyListeners();
  }

  Future<bool> excelTablaPuntos() async {
    //Crear excel
    Excel excel = Excel.createExcel();
    String name = '';
    switch (condiciontabla) {
      case 0:
        name = 'Ganados';
        break;
      case 1:
        name = 'Sin Validar';
        break;
      case 2:
        name = 'Rechazados';
        break;
      default:
    }
    Sheet? sheet = excel[name];

    //Agregar primera linea
    sheet.appendRow([
      'Título',
      'Historial de Puntos $name',
      '',
      'Usuario',
      '${currentUser?.nombre} ${currentUser?.apellidos}',
      '',
      'Fecha',
      dateFormat(DateTime.now()),
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'Evento',
      'Id Evento',
      'Descripcion',
      'Puntos',
      'Fecha',
    ]);

    //Agregar datos
    for (var factura in listapevento) {
      final List<dynamic> row = [
        factura.nombre,
        factura.idEvento,
        factura.descripcion,
        factura.puntos,
        dateFormat(factura.fecha),
      ];
      sheet.appendRow(row);
    }
    excel.delete('Sheet1');

    //Descargar
    switch (condiciontabla) {
      case 0:
        final List<int>? fileBytes =
            excel.save(fileName: "Historial_Puntos_Ganados.xlsx");
        if (fileBytes == null) return false;
        break;
      case 1:
        final List<int>? fileBytes =
            excel.save(fileName: "Historial_Puntos_Sin_Validar.xlsx");
        if (fileBytes == null) return false;
        break;
      case 2:
        final List<int>? fileBytes =
            excel.save(fileName: "Historial_Puntos_Rechazados.xlsx");
        if (fileBytes == null) return false;
        break;
      default:
    }

    return true;
  }

  Future<void> tablaCompras() async {
    try {
      final response = await supabase.rpc('tabla_compras', params: {
        'fechaini': fechainiTabla.toString(),
        'fechafin': fechafinTabla.toString(),
        'usuario': currentUser?.id
      });
      listcompras.clear();
      listcompras = (response as List<dynamic>)
          .map((factura) => TablaCompras.fromJson(jsonEncode(factura)))
          .toList();
      rowsv2.clear();
      for (var i = 0; i < listcompras.length - 1; i++) {
        rowsv2.add(
          PlutoRow(
            cells: {
              'idTicket': PlutoCell(value: listcompras[i].idTicket),
              'idProducto': PlutoCell(value: listcompras[i].idProducto),
              'descripcion': PlutoCell(value: listcompras[i].descripcion),
              'costo': PlutoCell(value: listcompras[i].costo),
              'fecha': PlutoCell(value: dateFormat(listcompras[i].fecha)),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      // log(e);
    }
    notifyListeners();
  }

  Future<bool> excelTablaCompras() async {
    //Crear excel
    Excel excel = Excel.createExcel();

    Sheet? sheet = excel['Compras'];

    //Agregar primera linea
    sheet.appendRow([
      'Título',
      'Historial Compras',
      '',
      'Usuario',
      '${currentUser?.nombre} ${currentUser?.apellidos}',
      '',
      'Fecha',
      dateFormat(DateTime.now()),
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'Id Ticket',
      'Id Producto',
      'Descripcion',
      'Costo',
      'Fecha',
    ]);

    //Agregar datos
    for (var factura in listcompras) {
      final List<dynamic> row = [
        factura.idTicket,
        factura.idProducto,
        factura.descripcion,
        factura.costo,
        dateFormat(factura.fecha),
      ];
      sheet.appendRow(row);
    }
    excel.delete('Sheet1');

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Historial_Compras.xlsx");
    if (fileBytes == null) return false;

    return true;
  }

//////////////////////////////////////////////
//Grafica Ahorro Beneficio

  Future<void> graficaPuntosTotales(DateTime date1) async {
    try {
      getTotales.clear();
      int mesReinicio = 1;
      GraficaPuntosTotales lineasAhorro;
      for (var i = 0; i < 12; i++) {
        if (i == 0) {
          final response = await supabase.rpc('grafico_puntos_totales',
              params: {
                'month': date1.month,
                'year': date1.year,
                'usuario': currentUser?.id
              });
          lineasAhorro = GraficaPuntosTotales.fromMap(response);
          getTotales.add(lineasAhorro);
        } else {
          if (date1.month + i <= 12) {
            final response = await supabase.rpc('grafico_puntos_totales',
                params: {
                  'month': date1.month + i,
                  'year': date1.year,
                  'usuario': currentUser?.id
                });
            lineasAhorro = GraficaPuntosTotales.fromMap(response);
            getTotales.add(lineasAhorro);
          } else if (date1.month + i > 12) {
            final response = await supabase.rpc('grafico_puntos_totales',
                params: {
                  'month': mesReinicio,
                  'year': date1.year + 1,
                  'usuario': currentUser?.id
                });
            lineasAhorro = GraficaPuntosTotales.fromMap(response);
            getTotales.add(lineasAhorro);
            mesReinicio = mesReinicio + 1;
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<bool> excelPuntosAnuales() async {
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel['Compras'];
    double totalfn = 0, tAhorro = 0, tAPullP = 0, tAPullNc = 0, tAPush = 0;
    //Agregar primera linea
    sheet.appendRow([
      'Título',
      'Grafica Puntos Anuales',
      '',
      'Usuario',
      '${currentUser?.nombre} ${currentUser?.apellidos}',
      '',
      'Fecha',
      dateFormat(DateTime.now()),
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'Mes',
      'Saldo Final',
      'Puntos Ganados',
      'Puntos Gastados',
      'Puntos Sin Validar',
      'Puntos Rechazados',
    ]);
    //Agregar datos
    for (var i = 0; i < getTotales.length; i++) {
      List<dynamic> row = [
        getTotales[i].mes,
        getTotales[i].totalPuntos,
        getTotales[i].puntosGanados,
        getTotales[i].puntosGastados,
        getTotales[i].puntosSinValidar,
        getTotales[i].puntosRechazados
      ];
      totalfn = totalfn + getTotales[i].totalPuntos;
      tAhorro = tAhorro + getTotales[i].puntosGanados;
      tAPullNc = tAPullNc + getTotales[i].puntosGastados;
      tAPullP = tAPullP + getTotales[i].puntosSinValidar;
      tAPush = tAPush + getTotales[i].puntosRechazados;
      sheet.appendRow(row);
    }
    sheet.appendRow(['Total:', totalfn, tAhorro, tAPullNc, tAPullP, tAPush]);
    excel.delete('Sheet1');
    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Puntos_Anuales.xlsx");
    if (fileBytes == null) return false;

    return true;
  }

  LineChartBarData totalPuntos() {
    return LineChartBarData(
      spots: [
        FlSpot(0, getTotales[0].totalPuntos),
        FlSpot(1, getTotales[1].totalPuntos),
        FlSpot(2, getTotales[2].totalPuntos),
        FlSpot(3, getTotales[3].totalPuntos),
        FlSpot(4, getTotales[4].totalPuntos),
        FlSpot(5, getTotales[5].totalPuntos),
        FlSpot(6, getTotales[6].totalPuntos),
        FlSpot(7, getTotales[7].totalPuntos),
        FlSpot(8, getTotales[8].totalPuntos),
        FlSpot(9, getTotales[9].totalPuntos),
        FlSpot(10, getTotales[10].totalPuntos),
        FlSpot(11, getTotales[11].totalPuntos),
      ],
      isCurved: false,
      barWidth: 5,
      color: facturacionNormal,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData puntosGanados() {
    return LineChartBarData(
      spots: [
        FlSpot(0, getTotales[0].puntosGanados),
        FlSpot(1, getTotales[1].puntosGanados),
        FlSpot(2, getTotales[2].puntosGanados),
        FlSpot(3, getTotales[3].puntosGanados),
        FlSpot(4, getTotales[4].puntosGanados),
        FlSpot(5, getTotales[5].puntosGanados),
        FlSpot(6, getTotales[6].puntosGanados),
        FlSpot(7, getTotales[7].puntosGanados),
        FlSpot(8, getTotales[8].puntosGanados),
        FlSpot(9, getTotales[9].puntosGanados),
        FlSpot(10, getTotales[10].puntosGanados),
        FlSpot(11, getTotales[11].puntosGanados),
      ],
      isCurved: false,
      barWidth: 5,
      color: cAhorro,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData puntosGastados() {
    return LineChartBarData(
      spots: [
        FlSpot(0, getTotales[0].puntosGastados),
        FlSpot(1, getTotales[1].puntosGastados),
        FlSpot(2, getTotales[2].puntosGastados),
        FlSpot(3, getTotales[3].puntosGastados),
        FlSpot(4, getTotales[4].puntosGastados),
        FlSpot(5, getTotales[5].puntosGastados),
        FlSpot(6, getTotales[6].puntosGastados),
        FlSpot(7, getTotales[7].puntosGastados),
        FlSpot(8, getTotales[8].puntosGastados),
        FlSpot(9, getTotales[9].puntosGastados),
        FlSpot(10, getTotales[10].puntosGastados),
        FlSpot(11, getTotales[11].puntosGastados),
      ],
      isCurved: false,
      barWidth: 5,
      color: ahorroPullNp,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData puntosSinValidar() {
    return LineChartBarData(
      spots: [
        FlSpot(0, getTotales[0].puntosSinValidar),
        FlSpot(1, getTotales[1].puntosSinValidar),
        FlSpot(2, getTotales[2].puntosSinValidar),
        FlSpot(3, getTotales[3].puntosSinValidar),
        FlSpot(4, getTotales[4].puntosSinValidar),
        FlSpot(5, getTotales[5].puntosSinValidar),
        FlSpot(6, getTotales[6].puntosSinValidar),
        FlSpot(7, getTotales[7].puntosSinValidar),
        FlSpot(8, getTotales[8].puntosSinValidar),
        FlSpot(9, getTotales[9].puntosSinValidar),
        FlSpot(10, getTotales[10].puntosSinValidar),
        FlSpot(11, getTotales[11].puntosSinValidar),
      ],
      isCurved: false,
      barWidth: 5,
      color: ahorroPullPn,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData puntosRechazadosL() {
    return LineChartBarData(
      spots: [
        FlSpot(0, getTotales[0].puntosRechazados),
        FlSpot(1, getTotales[1].puntosRechazados),
        FlSpot(2, getTotales[2].puntosRechazados),
        FlSpot(3, getTotales[3].puntosRechazados),
        FlSpot(4, getTotales[4].puntosRechazados),
        FlSpot(5, getTotales[5].puntosRechazados),
        FlSpot(6, getTotales[6].puntosRechazados),
        FlSpot(7, getTotales[7].puntosRechazados),
        FlSpot(8, getTotales[8].puntosRechazados),
        FlSpot(9, getTotales[9].puntosRechazados),
        FlSpot(10, getTotales[10].puntosRechazados),
        FlSpot(11, getTotales[11].puntosRechazados),
      ],
      isCurved: false,
      barWidth: 5,
      color: ahorroPushNP,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  void pickFacturacionNormal(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color Para Facturacion Normal',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: facturacionNormal,
                onColorChanged: (facturacionNormal) {
                  temp = facturacionNormal;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  facturacionNormal = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickGraphColor(Color color, String texto, BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color Grafica $texto',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: color,
                onColorChanged: (value) {
                  temp = value;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  log(color.toString());
                  color = temp;
                  log(color.toString());
                  notifyListeners();
                  if (context.canPop()) context.pop();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickAhorro(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color Para Ahorro',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: cAhorro,
                onColorChanged: (cAhorro) {
                  temp = cAhorro;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  cAhorro = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickAhorroPullNp(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Ahorro Pull NP',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPullNp,
                onColorChanged: (ahorroPullNp) {
                  temp = ahorroPullNp;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPullNp = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickAhorroPullPN(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Ahorro Pull PN',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPullPn,
                onColorChanged: (ahorroPullPn) {
                  temp = ahorroPullPn;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPullPn = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickAhorroPushNP(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Ahorro Push NP',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPushNP,
                onColorChanged: (ahorroPushNP) {
                  temp = ahorroPushNP;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPushNP = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Grafica Puntos por mes
  Future<void> graficaPuntosMes() async {
    try {
      GraficaPuntosMes puntos;
      pmes.clear();
      final response = await supabase.rpc('grafica_puntos_mes', params: {
        'fechaini': fechainiTabla.toString(),
        'fechafin': fechafinTabla.toString(),
        'usuario': currentUser?.id
      });
      puntos = GraficaPuntosMes.fromMap(response);
      pmes.add(puntos);
    } catch (e) {
      //log(e);
    }
    notifyListeners();
  }

  Future<bool> excelPuntosMensuales() async {
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return false;

    //Agregar primera linea
    sheet.appendRow([
      'Título',
      'Grafica Puntos Mensuales',
      '',
      'Usuario',
      '${currentUser?.nombre} ${currentUser?.apellidos}',
      '',
      'Fecha',
      dateFormat(DateTime.now()),
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'Mes',
      'Saldo Final',
      'Puntos Ganados',
      'Puntos Gastados',
      'Puntos Sin Validar',
      'Puntos Rechazados',
    ]);

    //Agregar datos
    if (mesFinPerdidas == "") {
      for (var factura in pmes) {
        final List<dynamic> row = [
          mes,
          factura.saldoFinal,
          factura.puntosGanados,
          factura.puntosGastado,
          factura.puntosSinValidar,
          factura.puntosRechazados
        ];
        sheet.appendRow(row);
      }
    } else {
      for (var factura in pmes) {
        final List<dynamic> row = [
          '$mes - $mesFinPerdidas',
          factura.saldoFinal,
          factura.puntosGanados,
          factura.puntosGastado,
          factura.puntosSinValidar,
          factura.puntosRechazados,
        ];
        sheet.appendRow(row);
      }
    }

    //Descargar
    final List<int>? fileBytes =
        excel.save(fileName: "Puntos Mensuales.xlsx");
    if (fileBytes == null) return false;

    return true;
  }

  BarChartGroupData faltaFondos(int x, double fondosNu) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: fondosNu,
            color: facturacionNormalPerdidas,
            width: 50,
            borderRadius: BorderRadius.zero),
      ],
    );
  }

  BarChartGroupData ncNoRecididas(int x, double fondosNu) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: fondosNu,
            color: cAhorroPerdidas,
            width: 50,
            borderRadius: BorderRadius.zero),
      ],
    );
  }

  BarChartGroupData adeudosNC(int x, double fondosNu) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: fondosNu,
            color: ahorroPullNpPerdidas,
            width: 50,
            borderRadius: BorderRadius.zero),
      ],
    );
  }

  BarChartGroupData puntosPendientes(int x, double fondosNu) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: fondosNu,
            color: ahorroPullPnPerdidas,
            width: 50,
            borderRadius: BorderRadius.zero),
      ],
    );
  }

  BarChartGroupData puntosRechazados(int x, double fondosNu) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: fondosNu,
            color: ahorroPushNPPerdidas,
            width: 50,
            borderRadius: BorderRadius.zero),
      ],
    );
  }

  void pickFaltaFondos(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color Para Falta de Fondos',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: facturacionNormalPerdidas,
                onColorChanged: (facturacionNormalPerdidas) {
                  temp = facturacionNormalPerdidas;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  facturacionNormalPerdidas = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickNcNoRecibidas(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color Para NC no Recibidas',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: cAhorroPerdidas,
                onColorChanged: (cAhorroPerdidas) {
                  temp = cAhorroPerdidas;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  cAhorroPerdidas = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickAdeudosNC(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Adeudos de NC',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPullNpPerdidas,
                onColorChanged: (ahorroPullNpPerdidas) {
                  temp = ahorroPullNpPerdidas;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPullNpPerdidas = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickPropuestasRechazadas(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Propuestas Rechazadas',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPullPnPerdidas,
                onColorChanged: (ahorroPullPnPerdidas) {
                  temp = ahorroPullPnPerdidas;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPullPnPerdidas = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickPropuestasSinRespuesta(BuildContext context) {
    late Color temp;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar Color para Propuestas sin Respuesta',
          style: AppTheme.of(context).textoResaltado,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
                pickerColor: ahorroPushNPPerdidas,
                onColorChanged: (ahorroPushNPPerdidas) {
                  temp = ahorroPushNPPerdidas;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                  ahorroPushNPPerdidas = temp;
                  notifyListeners();
                },
                child: Text(
                  'Actualizar Color',
                  style: AppTheme.of(context).textoResaltado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerBusqueda.dispose();

    if (stateManager != null) stateManager!.dispose();

    super.dispose();
  }
}
