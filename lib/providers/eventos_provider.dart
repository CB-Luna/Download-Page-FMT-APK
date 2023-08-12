import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/modelos_pantallas/eventos_tabla.dart';

class EventosProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  //ALTA USUARIO
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController areaTrabajoController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController nombreProveedorController = TextEditingController();
  TextEditingController cuentaProveedorController = TextEditingController();
  TextEditingController puntosController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  String altaDropValue = 'Por definir';
  int areaTrabajoId = 7; //por definir

  String? cuentasDropValue = '';
  late int rolParaRegistro;
  String headerText = 'Nuevo usuario';
  String? imageName;
  Uint8List? webImage;

  List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];

  List<EventoTabla> evento = [];
  List<EventoTabla> eventoTesoreros = [];

  List<RolApi> rolesSeleccionados = [];

  bool isProveedor = false;
  bool isTesoreroLocal = false;
  String? selectedRadio;
  int? proveedorId;
  String? responsableId;
  String? estatusFiltrado;
  bool botonTransferir = false;
  //Variables usadas para el popup confirmar trnsaccion
  String? jefeOld;
  String? avatarNew;
  String? nombreNew;
//------------------------------------------
  //PANTALLA evento
  final busquedaController = TextEditingController();
  late final TextEditingController filasController;
  int countF = 20;
  String orden = "usuario_id_secuencial";
  bool asc = true;
  bool filtroSimple = false;
  final AutoSizeGroup tableTopGroup = AutoSizeGroup();
  final AutoSizeGroup tableContentGroup = AutoSizeGroup();

  //----------------------------------------------Paginador variables

  int seccionActual = 1;
  int totalSecciones = 1;
  int totalFilas = 0;
  int from = 0;
  int hasta = 20;
  //----------------------------------------------

  EventosProvider() {
    getEventoTabla();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------

  Future<void> getEventoTabla() async {
    try {
      final String query = busquedaController.text;

      final res = await supabase.from('evento').select();
      evento = (res as List<dynamic>)
          .map((evento) => EventoTabla.fromJson(jsonEncode(evento)))
          .toList();

      rows.clear();

      for (EventoTabla evento in evento) {
        if (query.isEmpty ||
            evento.nombre.toLowerCase().contains(query.toLowerCase()) ||
            evento.descripcion!.toLowerCase().contains(query.toLowerCase()) ||
            evento.puntos
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          // Formatear la fecha utilizando la clase DateFormat
          final DateFormat formatter = DateFormat('MM-dd-yyyy hh:mm a');
          final String formattedDate = formatter.format(evento.fecha);

          rows.add(
            PlutoRow(
              cells: {
                'evento_id': PlutoCell(value: evento.id),
                'nombre': PlutoCell(value: evento.nombre),
                'descripcion': PlutoCell(value: evento.descripcion),
                'fecha': PlutoCell(value: formattedDate),
                'imagen': PlutoCell(value: evento.imagenEventoTabla),
                'puntaje_asistencia': PlutoCell(value: evento.puntos),
                'acciones': PlutoCell(value: evento.id),
              },
            ),
          );
        }
      }

      if (stateManager != null) {
        stateManager!.notifyListeners();
      } else {
        notifyListeners();
        return;
      }
    } catch (e) {
      print("erro en: EventosProvider: getEventoTabla() $e");
    }
  }

  Future<void> getProveedor() async {
    final res = await supabase
        .from('proveedores')
        .select('id_proveedor_pk, nombre_fiscal, contacto')
        .eq('codigo_acreedor', proveedorController.text);

    if (res == null) return;

    if ((res as List<dynamic>).length != 1) {
      proveedorId = null;
      nombreProveedorController.text = 'No se encontró';
      cuentaProveedorController.text = 'No se encontró';
    } else {
      final infoProveedor = res[0];
      proveedorId = infoProveedor['id_proveedor_pk'];
      nombreProveedorController.text = infoProveedor['nombre_fiscal'];
      cuentaProveedorController.text = infoProveedor['contacto'];
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

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (webImage != null && imageName != null) {
      final storageResponse =
          await supabase.storage.from('eventos').uploadBinary(
                imageName!,
                webImage!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      if (storageResponse == null) return null;
      dynamic res = supabase.storage.from('eventos').getPublicUrl(imageName!);
      imageName = res;
      return imageName;
    }
    return null;
  }

  Future<bool> crearEvento() async {
    final res = await supabase.from('evento').insert(
      {
        'nombre': nombreController.text,
        'descripcion': descripcionController.text,
        'puntaje_asistencia': puntosController.text.toLowerCase(),
        'fecha': fechaController.text.toLowerCase(),
        'imagen': imageName ??
            'https://bxqcblafqmopibdjzmoh.supabase.co/storage/v1/object/public/productos/default-producto.png',
      },
    ).select();
    if (res == null) {
      print("Error al intentar insertar nuevo evento en la tabla de evento");
      print(res.error!.message);
      return false;
    }

    return true;
  }

//TODO: Crear el ticket
  Future<bool> guardarTicket(String userId) async {
    print(puntosController.text);
    print(userId);
    /*   final res = await supabase.from('usuario_evento').insert(
      {
        'usuario_fk': userId,
        'puntos_solicitados': descripcionController.text,
        'imagen_evidencia': imageName ??
            'https://xpbhozetzdxldzcbhcei.supabase.co/storage/v1/object/public/avatars/avatar-e42c5bd0-9110-11ed-98e7-3f1db831fd3c.png',
      },
    ).select();
    if (res == null) {
      print(
          "Error al intentar insertar nuevo usuario en la tabla de perfil_usuario");
      print(res.error!.message);
      return false;
    }
 */
    return true;
  }

  Future<bool> editarPerfilDeEmpleado(String userId) async {
    final res = await supabase
        .from('perfil_usuario')
        .update(
          {
            'perfil_usuario_id': userId,
            'nombre': nombreController.text,
            'apellidos': descripcionController.text,
            'email': correoController.text,
            'telefono': telefonoController.text,
            'id_area_fk': areaTrabajoId,
            'avatar': imageName ??
                'https://xpbhozetzdxldzcbhcei.supabase.co/storage/v1/object/public/avatars/avatar-e42c5bd0-9110-11ed-98e7-3f1db831fd3c.png',
          },
        )
        .eq('perfil_usuario_id', userId)
        .select();

    if (res == null) {
      print(res.error!.message);
      return false;
    }
    return true;
  }

  void initEditarUsuario(EventoTabla usuario) {
    nombreController.text = usuario.nombre;
    descripcionController.text = usuario.descripcion!;

    webImage = null;
    //TODO: revisar roles e inicializar
    isProveedor = false;
    isTesoreroLocal = false;
    proveedorId = null;
    responsableId = null;
  }
//----------------------------------------------

  void clearControllers() {
    nombreController.clear();
    puntosController.clear();
    descripcionController.clear();
    fechaController.clear();
    telefonoController.clear();
    correoController.clear();
    extController.clear();
    proveedorController.clear();
    nombreProveedorController.clear();
    cuentaProveedorController.clear();

    rolesSeleccionados = [];
    isProveedor = false;
    isTesoreroLocal = false;

/*     notifyListeners(); */
  }

  void clearImage() {
    webImage = null;
    imageName = null;
/*     notifyListeners(); */
  }

  void initImage() {
    webImage = null;
    imageName = null;
    notifyListeners();
  }

  @override
  void dispose() {
    busquedaController.dispose();
    nombreController.dispose();
    correoController.dispose();
    descripcionController.dispose();
    puntosController.dispose();
    telefonoController.dispose();
    extController.dispose();
    proveedorController.dispose();
    nombreProveedorController.dispose();
    cuentaProveedorController.dispose();
    super.dispose();
  }
}
