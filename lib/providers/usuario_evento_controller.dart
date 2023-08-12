import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/eventos.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class UsuarioEventoController with ChangeNotifier {
  TextEditingController puntajeAgregadoController =
      TextEditingController(text: "");
  TextEditingController descripcionEventoController =
      TextEditingController(text: "");
  TextEditingController notaEventoController = TextEditingController(text: "");
  Eventos? objectEventos;
  List<String> listEventos = [];
  String evento = "";
  String idEvento = "";
  Uint8List? webImage;
  String? imageName;
  Future<void> updateState() async {
    await getEventosSupabase();
  }

  void clearAllProducts() {
    objectEventos = null;
    listEventos.clear();
    notifyListeners();
  }

  /*Función Usuario Evento 1: Se Recupera la información de los Eventos
  */
  Future<bool> getEventosSupabase() async {
/*     print("Recuperando Información"); */
    String queryGetEventos = """
      query Query {
        eventoCollection (filter: {}){
          edges {
            node {
              evento_id
              nombre
              descripcion
              created_at
              puntaje_asistencia
            }
          }
        }
      }
      """;
    try {
      //Se recupera la información del Saldo del Empleado en Supabase
      final record = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetEventos),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      if (record.data != null) {
        evento = "";
        idEvento = "";

        descripcionEventoController.clear();
        notaEventoController.clear();
        listEventos.clear();
        //Existen datos del Saldo del Empleado en Supabase
        print("***Eventos: ${jsonEncode(record.data).toString()}");
        objectEventos = Eventos.fromJson(jsonEncode(record.data).toString());
        print("Fue True");
        if (objectEventos?.eventoCollection.edges != null) {
          for (var element in objectEventos!.eventoCollection.edges) {
            listEventos.add(element!.node.nombre);
          }
        }
        notifyListeners();
        return true;
      } else {
        //No existen Eventos en Supabase
        return false;
      }
    } catch (e) {
      print("Error en GetEventos: $e");
      return false;
    }
  }

  bool seleccionarEvento(String value) {
    if (listEventos.isEmpty) {
      return false;
    } else {
      evento = value;
      for (var element in objectEventos!.eventoCollection.edges) {
        if (element!.node.nombre == value) {
          descripcionEventoController.text = element.node.descripcion ?? "";
          puntajeAgregadoController.text =
              element.node.puntajeAsistencia.toString();

          idEvento = element.node.eventoId;
        }
      }
      notifyListeners();
      return true;
    }
  }

  /*Función Usuario Evento 2: Se envía el nuevo registro al backend de usuario evento
  */
  Future<bool> addUsuarioEventoSupabase(String userId, int monto) async {
    print("Recuperando Información");
    String queryGetSaldoEmpleadoByID = """
      query Query {
        saldoCollection (filter: { id_usuario_fk: { eq: "$userId"} }){
          edges {
            node {
              id
              saldo
              created_at
            }
          }
        }
      }
      """;
    try {
      // //Se recupera la información del Saldo del Empleado en Supabase
      // final record = await sbGQL.query(
      //   QueryOptions(
      //     document: gql(queryGetSaldoEmpleadoByID),
      //     fetchPolicy: FetchPolicy.noCache,
      //     onError: (error) {
      //       return null;
      //     },
      //   ),
      // );
      // if (record.data != null) {
      //   //Existen datos del Saldo del Empleado en Supabase
      //   print("***Saldo: ${jsonEncode(record.data).toString()}");
      //   //Se valida que el registro del Saldo exista en Supabase
      //   objectSaldoEmpleado =
      //       SaldoEmpleado.fromJson(jsonEncode(record.data).toString());
      //   if (objectSaldoEmpleado != null) {
      //     final newSaldo = monto +
      //         objectSaldoEmpleado!.saldoCollection.edges.first.node.saldo;
      //     //Se inserta un nuevo registro en la tabla Puntaje Ganado en Supabase
      //     await supabase.from('puntaje_ganado').insert([
      //       {
      //         'monto': monto,
      //         'id_saldo_fk':
      //             objectSaldoEmpleado!.saldoCollection.edges.first.node.id,
      //       },
      //     ]);
      //     //Se actualiza el Saldo del Cliente en Supabase
      //     await supabase.from('saldo').update({'saldo': newSaldo}).eq(
      //         'id', objectSaldoEmpleado!.saldoCollection.edges.first.node.id);
      //     //Se actualiza el Saldo Localmente
      //     objectSaldoEmpleado!.saldoCollection.edges.first.node.saldo =
      //         newSaldo;
      //     notifyListeners();
      //     return true;
      //   } else {
      //     //No se pudo recuperar en éxito el Saldo del Empleado en Supabase
      //     return false;
      //   }
      // } else {
      //   //No existen Saldo del Empleado en Supabase
      //   return false;
      // }
      return true;
    } catch (e) {
      print("Error en GetSaldoEmpleado: $e");
      return false;
    }
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final String fileExtension = p.extension(pickedImage.name);
    const uuid = Uuid();
    final String fileName = uuid.v1();
    imageName = 'avatar-$fileName$fileExtension';

    webImage = await pickedImage.readAsBytes();
  }

  Future<String?> uploadImage() async {
    if (webImage != null && imageName != null) {
      final storageResponse =
          await supabase.storage.from('evidencia').uploadBinary(
                imageName!,
                webImage!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
      if (storageResponse.isEmpty) return null;
      dynamic res = supabase.storage.from('evidencia').getPublicUrl(imageName!);
      imageName = res;
      return imageName;
    }
    return null;
  }

  Future<bool> guardarTicket(String userId) async {
    final res = await supabase.from('usuario_evento').insert(
      {
        'usuario_fk': userId,
        'evento_fk': idEvento,
        'imagen_evidencia': imageName,
        'estatus_fk': 1,
      },
    ).select();
    if (res == null) {
      print("Error al guardar ticket en guardarTicket()");
      print(res.error!.message);
      return false;
    }

    return true;
  }

  void clearImage() {
    webImage = null;
    imageName = null;
  }

  void clearControllers() {
    descripcionEventoController.clear();
    puntajeAgregadoController.clear();
    listEventos.clear();
  }
}
