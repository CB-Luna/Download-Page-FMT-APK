import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dowload_page_apk/helpers/constants.dart';

import '../models/modelos_pantallas/empleados.dart';

class EmpleadosProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  //ALTA USUARIO
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController areaTrabajoController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController nombreProveedorController = TextEditingController();
  TextEditingController cuentaProveedorController = TextEditingController();
  TextEditingController puntosController = TextEditingController();
  String altaDropValue = "";
  int areaTrabajoId = 7; //por definir

  String? cuentasDropValue = '';
  late int rolParaRegistro;
  String headerText = 'Nuevo usuario';
  String? imageName;
  Uint8List? webImage;

  List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];

  List<Empleados> usuarios = [];
  List<Empleados> usuariosTesoreros = [];

  List<RolApi> rolesSeleccionados = [];
  List<String> areaNames = [];
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
  //PANTALLA USUARIOS
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

  EmpleadosProvider() {
    getEmpleado();
    getAreaNames();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------
  Future<void> setSeccionActual(int value) async {
    seccionActual = value;
    await getEmpleado();
  }

  updaterolParaRegistro(int valor, String header) {
    rolParaRegistro = valor;
    headerText = header;
    /*  notifyListeners(); */
    clearControllers();
    return;
  }

  Future<void> getEmpleado() async {
    try {
      final String query = busquedaController.text;

      if (currentUser!.rol.rolId == 1) {
        final res = await supabase.from('empleados_view').select();
        usuarios = (res as List<dynamic>)
            .map((usuario) => Empleados.fromJson(jsonEncode(usuario)))
            .toList();
      } else if (currentUser!.rol.rolId == 3) {
        final res = await supabase
            .from('empleados_view')
            .select()
            .eq('jefe_area_fk', currentUser!.id);
        usuarios = (res as List<dynamic>)
            .map((usuario) => Empleados.fromJson(jsonEncode(usuario)))
            .toList();
      }

      rows.clear();

      for (Empleados usuario in usuarios) {
        if (query.isEmpty ||
            usuario.nombre.toLowerCase().contains(query.toLowerCase()) ||
            usuario.apellidos.toLowerCase().contains(query.toLowerCase()) ||
            usuario.nombreArea.toLowerCase().contains(query.toLowerCase()) ||
            usuario.email.toLowerCase().contains(query.toLowerCase())) {
          rows.add(
            PlutoRow(
              cells: {
                'perfil_usuario_id': PlutoCell(value: usuario.perfilUsuarioId),
                'id_secuencial': PlutoCell(value: usuario.idSecuencial),
                'nombre':
                    PlutoCell(value: "${usuario.nombre} ${usuario.apellidos}"),
                'email': PlutoCell(value: usuario.email),
                'imagen': PlutoCell(value: usuario.imagen),
                'nombre_area': PlutoCell(value: usuario.nombreArea),
                'nombre_jefe_asignado':
                    PlutoCell(value: usuario.nombreJefeAsignado),
                'acciones': PlutoCell(value: usuario.idSecuencial),
              },
            ),
          );
        }
      }
      if (stateManager != null) {
        stateManager!.sortAscending(PlutoColumn(
            title: '#',
            field: 'id_secuencial',
            type: PlutoColumnType.number()));
        stateManager!.notifyListeners();
      } else {
        notifyListeners();
        return;
      }
    } catch (e) {
      print("erro en: empleadosProvider: getEmpleado() $e");
    }
  }

  Future<int> getidarea(String nombreArea) async {
    try {
      final res = await supabase.rpc('get_id_area', params: {
        'nombrearea': nombreArea,
      }).select("*");

      areaTrabajoId = res.first['id'];

      return res.first['id'];
    } catch (e) {
      print("ERROR en getidarea: " + e.toString());
      notifyListeners();
      return 7;
    }
  }

  getAreaNames() async {
    try {
      final res = await supabase.from('areas').select('nombre_area');

      areaNames = (res as List<dynamic>)
          .map((area) => area['nombre_area'] as String)
          .toList();

      notifyListeners();
      return areaNames;
    } catch (e) {
      print("ERROR en getAreaNames: " + e.toString());
      rethrow;
    }
  }

  Future<bool> editarPerfilDeEmpleado(String userId) async {
    final res = await supabase
        .from('perfil_usuario')
        .update(
          {
            'perfil_usuario_id': userId,
            'nombre': nombreController.text,
            'apellidos': apellidosController.text,
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

  void initEditarUsuario(Empleados usuario) {
    nombreController.text = usuario.nombre;
    apellidosController.text = usuario.apellidos;
    correoController.text = usuario.email;
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
    correoController.clear();
    apellidosController.clear();
    telefonoController.clear();
    extController.clear();
    proveedorController.clear();
    nombreProveedorController.clear();
    cuentaProveedorController.clear();

/*     paisesSeleccionados = []; */
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

  @override
  void dispose() {
    busquedaController.dispose();
    nombreController.dispose();
    correoController.dispose();
    apellidosController.dispose();
    telefonoController.dispose();
    extController.dispose();
    proveedorController.dispose();
    nombreProveedorController.dispose();
    cuentaProveedorController.dispose();
    super.dispose();
  }
}
