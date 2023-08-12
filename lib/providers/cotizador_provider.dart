import 'dart:convert';
import 'dart:html';

import 'package:excel/excel.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/Cotizador/cotizador.dart';
import 'package:dowload_page_apk/models/Factoraje/cotizador/get_oc_products_model.dart';
import 'package:dowload_page_apk/models/Factoraje/unidades_medida.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../functions/date_format.dart';

class CotizadorProvider extends ChangeNotifier {
  CotizadorProvider() {
    if (stateManager != null) stateManager!.notifyListeners();
  }

  String? dropDownValue;
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textControllerRango = TextEditingController();
  final textController5 = TextEditingController();
  final textController10 = TextEditingController();

  final textControllerItemID = TextEditingController();
  final textControllerDescription = TextEditingController();
  final textControllerQuantity = TextEditingController();
  final textControllerPoints = TextEditingController();
  final textControllerTotal = TextEditingController();

  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  List<String> ddProveedores = [];
  List<String> ddProveedoresId = [];
  String ddProveedor = 'Proveedores';

  late UnidadesMedidaDD unidadesMedida;

  QueriesCotizador queries = QueriesCotizador();
  String ddValue = '';
  List<String> ddValues = [];
  List<String> ddValuesPK = [];

  PlutoGridStateManager? stateManager;

  double piezas = 0;
  double subtotal = 0;
  double comision = 0;
  double total = 0;

  DateTime fechaIni = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime fechaFin = DateTime(DateTime.now().year, DateTime.now().month, 28);

  List<PlutoRow> listCarrito = [];
  List<Map<String, Object?>> listCarrito1 = [];

  late GetOcProductsModel ocProducts;

  Future<void> clearAll() async {
    ddProveedores = [];
    ddProveedoresId = [];
    listCarrito = [];
    subtotal = 0;
    comision = 0;
    total = 0;
    await getPedidos();
    notifyListeners();
  }

  Future<void> getPedidos() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }

    var response = await supabase.rpc(
      'pedidos_sin_solicitar',
      params: {
        "ini": '${fechaIni.year}-${fechaIni.month}-${fechaIni.day}',
        "fin": '${fechaFin.year}-${fechaFin.month}-${fechaFin.day}',
      },
    );

    listCarrito = [];
    subtotal = 0;
    total = 0;
    piezas = 0;

    if (response != null) {
      print(jsonEncode(response));
      var list = (response as List<dynamic>).map((factura) => PedidosSinSolicitar.fromJson(jsonEncode(factura))).toList();

      for (var pedido in list) {
        listCarrito.add(
          PlutoRow(
            cells: {
              'itemID': PlutoCell(value: pedido.idProducto.toString()),
              'nombre': PlutoCell(value: pedido.nombreProducto.toString()),
              'description': PlutoCell(value: pedido.descripcionProducto.toString()),
              'quantity': PlutoCell(value: pedido.cantidad.toString()),
              'points': PlutoCell(value: pedido.costoProducto.toString()),
              'total': PlutoCell(value: pedido.costoProducto.toString()),
              'acciones': PlutoCell(value: ''),
            },
          ),
        );
      }

      for (var row in listCarrito) {
        piezas = piezas + double.parse(row.cells['quantity']?.value);
        subtotal = subtotal + (double.parse(row.cells['points']?.value) * double.parse(row.cells['quantity']?.value));
        total = total + (double.parse(row.cells['points']?.value) * double.parse(row.cells['quantity']?.value));
      }
    }

    stateManager!.setShowLoading(false);
    notifyListeners();
  }

  Future<void> addCarrito() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    piezas = 0;
    subtotal = 0;
    // comision = 0;
    total = 0;

    listCarrito.add(
      PlutoRow(
        cells: {
          'itemID': PlutoCell(value: textControllerItemID.text),
          'nombre': PlutoCell(value: textControllerDescription.text),
          'quantity': PlutoCell(value: textControllerQuantity.text),
          'points': PlutoCell(value: textControllerPoints.text),
          'total': PlutoCell(value: textControllerTotal.text),
          'acciones': PlutoCell(value: ''),
        },
      ),
    );

    listCarrito1 = [];
    for (PlutoRow rows in listCarrito) {
      listCarrito1.add({
        "id_documento_fk": 1,
        "id_item": int.parse(textControllerItemID.text),
        "nombre": rows.cells["nombre"]?.value,
        "cantidad": int.parse(rows.cells["quantity"]?.value),
        "puntos": double.parse(rows.cells["points"]?.value),
        "total": double.parse(rows.cells["total"]?.value)
      });
    }

    for (var row in listCarrito) {
      piezas = piezas + double.parse(row.cells['quantity']?.value);
      subtotal = subtotal + (double.parse(row.cells['points']?.value) * double.parse(row.cells['quantity']?.value));

      total = total + (double.parse(row.cells['points']?.value) * double.parse(row.cells['quantity']?.value));
    }

    subtotal = double.parse(subtotal.toStringAsFixed(2));
    total = double.parse(total.toStringAsFixed(2));

    textControllerItemID.text = '';
    textControllerDescription.text = '';
    textControllerQuantity.text = '';
    textControllerPoints.text = '';
    textControllerTotal.text = '';

    notifyListeners();
  }

  Future<void> removeCarrito() async {
    piezas = 0;
    subtotal = 0;
    total = 0;

    listCarrito1 = [];
    for (PlutoRow rows in listCarrito) {
      listCarrito1.add({
        "id_documento_fk": 1,
        "id_item": 1,
        "nombre": rows.cells["description"]?.value,
        "cantidad": int.parse(rows.cells["quantity"]?.value),
        "puntos": double.parse(rows.cells["points"]?.value),
        "total": double.parse(rows.cells["total"]?.value)
      });
    }

    for (var row in listCarrito) {
      piezas = piezas + double.parse(row.cells['quantity']?.value);
      subtotal = subtotal + double.parse(row.cells['points']?.value);
      total = total + double.parse(row.cells['total']?.value);
    }

    subtotal = double.parse(subtotal.toStringAsFixed(2));
    total = double.parse(total.toStringAsFixed(2));

    textControllerItemID.text = '';
    textControllerDescription.text = '';
    textControllerQuantity.text = '';
    textControllerPoints.text = '';
    textControllerTotal.text = '';

    notifyListeners();
  }

  /* Future<void> getOC(int idOC) async {
    var result = await sbGQL.query(
      QueryOptions(
        document: gql(queries.getOC),
        fetchPolicy: FetchPolicy.noCache,
        onError: (error) {
          log(error.toString());
        },
        variables: {
          "filter": {
            "id_documento_pk": {"eq": idOC}
          }
        },
      ),
    );
    ocProducts = GetOcProductsModel.fromRawJson(jsonEncode(result.data));
    GetOcProductsModel getOcProductsModel = GetOcProductsModel.fromRawJson(jsonEncode(result.data));
    subtotal = getOcProductsModel.documentosCollection.edges[0].node.importe;
    comision = getOcProductsModel.documentosCollection.edges[0].node.comision;
    total = getOcProductsModel.documentosCollection.edges[0].node.total;

    listCarrito = [];
    listCarrito1 = [];

    for (var product in getOcProductsModel.documentosCollection.edges[0].node.productosCollection.edges) {
      listCarrito.add(
        PlutoRow(
          cells: {
            'itemID': PlutoCell(value: product.node.idItem),
            'description': PlutoCell(value: product.node.descripcion),
            'quantity': PlutoCell(value: product.node.cantidad.toString()),
            'unit': PlutoCell(value: product.node.unidadesMedida.nombreUnidad.toString()),
            'unitPrice': PlutoCell(value: product.node.precioUnitario.toString()),
            'tax': PlutoCell(value: product.node.impuestos.toString()),
            'total': PlutoCell(value: product.node.total.toString()),
            'acciones': PlutoCell(value: ''),
          },
        ),
      );
      listCarrito1.add({
        "id_documento_fk": 0,
        "id_item": 1,
        "nombre": product.node.descripcion,
        "cantidad": product.node.cantidad,
        "id_unidad_fk": product.node.unidadesMedida.idUnidadPk,
        "precio_unitario": product.node.precioUnitario,
        "impuestos": product.node.impuestos,
        "total": product.node.total
      });
    }
  }

  Future<void> getProveedores() async {
    var result = await sbGQL.query(
      QueryOptions(
        document: gql(queries.getProveedores),
        fetchPolicy: FetchPolicy.noCache,
        onError: (error) {
          log(error.toString());
        },
        variables: {
          "filter": {
            "id_compania_pk": {"neq": currentUser!.compania.idCompaniaPk}
          }
        },
      ),
    );
    // print(jsonEncode(result.data!["companiasCollection"]));

    ProveedoresModel proveedoresModel = ProveedoresModel.fromRawJson(jsonEncode(result.data!["companiasCollection"]));

    ddProveedores = [];
    ddProveedoresId = [];
    for (var proveedor in proveedoresModel.edges) {
      ddProveedores.add(proveedor.node.nombreFiscal);
      ddProveedoresId.add(proveedor.node.idCompaniaPk);
    }

    notifyListeners();
  }

  Future<void> insertOC(BuildContext context, int idProv) async {
    try {
      var indice = ddProveedores.indexOf(ddProveedor);

      var resultDoc = await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.queryInsertDoc),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            print(error);
          },
          variables: {
            "objects": [
              {
                "id_tipo_archivo_fk": 1,
                "id_moneda_fk": 1,
                "fecha_documento": "${DateTime.now().year.toString().padLeft(4, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                "id_estatusDoc_fk": 4,
                "id_compProv_fk": ddProveedoresId[indice],
                "id_compCli_fk": currentUser!.compania.idCompaniaPk,
                "importe": subtotal,
                "comision": comision,
                "total": total,
                "mensaje": 'Mensaje OC'
              }
            ]
          },
        ),
      );
      //print(jsonEncode(resultDoc.data));

      InsertDocModel insertDocModel = InsertDocModel.fromRawJson(jsonEncode(resultDoc.data));

      for (var rows in listCarrito1) {
        rows["id_documento_fk"] = insertDocModel.insertIntoDocumentosCollection.records[0].idDocumentoPk;
      }

      var resultProds = await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.queryInsertProd),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"objects": listCarrito1},
        ),
      );
      //print(jsonEncode(resultProds.data));

      clearAll();
    } catch (e) {
      log('Error en UpdatePartidasSolicitadas() - $e');
    }
  }

  Future<void> insertFA(BuildContext context) async {
    try {
      var resultDoc = await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.queryInsertDoc),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            print(error);
          },
          variables: {
            "objects": [
              {
                "id_tipo_archivo_fk": 2,
                "id_moneda_fk": 1,
                "fecha_documento": "${DateTime.now().year.toString().padLeft(4, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                "id_estatusDoc_fk": 4,
                "id_compProv_fk": currentUser!.compania.idCompaniaPk,
                "id_compCli_fk": ocProducts.documentosCollection.edges[0].node.idCompCliFk,
                "importe": subtotal,
                "comision": comision,
                "total": total,
                "mensaje": 'Mensaje FA'
              }
            ]
          },
        ),
      );
      //print(jsonEncode(resultDoc.data));

      InsertDocModel insertDocModel = InsertDocModel.fromRawJson(jsonEncode(resultDoc.data));

      for (var rows in listCarrito1) {
        rows["id_documento_fk"] = insertDocModel.insertIntoDocumentosCollection.records[0].idDocumentoPk;
      }

      await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.queryInsertProd),
          fetchPolicy: FetchPolicy.noCache,
          variables: {"objects": listCarrito1},
        ),
      );

      var resultUpdate = await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.updateDoc),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            log(error.toString());
          },
          variables: {
            "set": const {"id_estatusDoc_fk": 6},
            "filter": {
              "id_documento_pk": {"eq": ocProducts.documentosCollection.edges[0].node.idDocFk}
            }
          },
        ),
      );

      var resultInsertOCFA = await sbGQL.mutate(
        MutationOptions(
          document: gql(queries.insertOCFA),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            log(error.toString());
          },
          variables: {
            "objects": [
              {
                "id_FA_fk": int.parse(insertDocModel.insertIntoDocumentosCollection.records[0].idDocumentoPk),
                "id_OC_fk": ocProducts.documentosCollection.edges[0].node.idDocFk,
              }
            ]
          },
        ),
      );

      //print(jsonEncode(resultProds.data));

      clearAll();
    } catch (e) {
      log('Error en UpdatePartidasSolicitadas() - $e');
    }
  }
 */
//------------------------------------------------
  FilePickerResult? docProveedor;
  File? pdfResult;
  PdfController? pdfController;

  bool popupVisorPdfVisible = true;

  void verPdf(bool visible) {
    popupVisorPdfVisible = visible;
    notifyListeners();
  }

  Future<void> pickProveedorDoc() async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'xml']);

    //get and load pdf
    if (picker != null) {
      docProveedor = picker;
      pdfController = PdfController(
        document: PdfDocument.openData(picker.files.single.bytes!),
      );
    } else {
      pdfController = null;
    }

    notifyListeners();
    return;
  }

  void clearDoc() async {
    if (docProveedor != null) {
      docProveedor = null;
      popupVisorPdfVisible = true;
    }
    return notifyListeners();
  }
//------------------------------------------------

  Future<bool> descargarCotizacion() async {
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return false;

    //Agregar primera linea
    sheet.appendRow([
      'Título:',
      'Cotización',
      '',
      'Usuario:',
      '${currentUser?.nombre} ${currentUser?.apellidos}',
      '',
      'Fecha:',
      dateFormat(DateTime.now()),
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Indicadores Principales
    sheet.appendRow([
      'PRODUCTOS',
      listCarrito.length.toString(),
      'PIEZAS',
      piezas,
    ]);

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'ID Producto',
      'Nombre',
      //'Descripción',
      'Cantidad',
    ]);

    //Agregar datos
    for (var producto in listCarrito) {
      List<dynamic> row = [
        producto.cells["itemID"]?.value,
        producto.cells["nombre"]?.value,
        //producto.cells["description"]?.value,
        producto.cells["quantity"]?.value,
      ];
      sheet.appendRow(row);
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Cotización.xlsx");
    if (fileBytes == null) return false;

    return true;
  }
}

class QueriesCotizador {
  String queryDDUnidades = r'''
query UnidadesMedida {
  unidades_MedidaCollection {
    edges {
      node {
        id_unidad_pk
        nombre_unidad
      }
    }
  }
}
''';
  String queryInsertDoc = r'''
mutation InsertIntoDocumentosCollection($objects: [DocumentosInsertInput!]!) {
  insertIntoDocumentosCollection(objects: $objects) {
    records {
      id_documento_pk
      id_tipo_archivo_fk
      id_moneda_fk
      fecha_documento
      id_estatusDoc_fk
      id_compProv_fk
      id_compCli_fk
      importe
      comision
      total
      mensaje
      total
    }
  }
}
''';
  String queryInsertProd = r'''
mutation InsertIntoProductosCollection($objects: [ProductosInsertInput!]!) {
  insertIntoProductosCollection(objects: $objects) {
    records {
      id_documento_fk
      id_item
      descripcion
      cantidad
      id_unidad_fk
      precio_unitario
      impuestos
      total
    }
  }
}
''';
  String getOC = r'''
query GetOC($filter: DocumentosFilter) {
  documentosCollection(filter: $filter) {
    edges {
      node {
        id_documento_pk
        productosCollection {
          edges {
            node {
              id_item
              descripcion
              cantidad
              unidades_Medida {
                id_unidad_pk
                nombre_unidad
              }
              precio_unitario
              impuestos
              total
            }
          }
        }
        mensaje
        importe
        monedas {
          id_moneda_pk
          nombre_moneda
        }
        comision
        total
        id_compCli_fk
      }
    }
  }
}
''';

  String insertOCFA = r'''
mutation InsertIntoOC_FACollection($objects: [OC_FAInsertInput!]!) {
  insertIntoOC_FACollection(objects: $objects) {
    records {
      id
      id_FA_fk
      id_OC_fk
    }
  }
}
''';

  String updateDoc = r'''
mutation UpdateDocumentosCollection($set: DocumentosUpdateInput!, $filter: DocumentosFilter) {
  updateDocumentosCollection(set: $set, filter: $filter) {
    records {
      id_documento_pk
      id_estatusDoc_fk
    }
  }
}
''';
  String getProveedores = r'''
query ExampleQuery($filter: CompaniasFilter) {
  companiasCollection(filter: $filter) {
    edges {
      node {
        id_compania_pk
        logo_compania
        nombre_fiscal
        fecha_actualizacion
        created_at
        codigo
      }
    }
  }
}

''';
}
