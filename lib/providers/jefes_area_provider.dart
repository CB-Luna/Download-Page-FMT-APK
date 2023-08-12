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

class JefesAreaProvider extends ChangeNotifier {
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
  String altaDropValue = "";
  int areaTrabajoId = 7; //por definir

  String? cuentasDropValue = '';
  late int rolParaRegistro;
  String headerText = 'Nuevo usuario';
  String? imageName;
  Uint8List? webImage;

  List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];

  List<JefeArea> usuarios = [];
  List<JefeArea> usuariosTesoreros = [];

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

  JefesAreaProvider() {
    getJefeArea();
    getAreaNames();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------
  Future<void> setSeccionActual(int value) async {
    seccionActual = value;
    await getJefeArea();
  }

  void handleRadioValueChange(String? value) async {
    selectedRadio = value;
    botonTransferir = true;

    final res = await supabase.rpc('get_perfil_usuario', params: {
      'id': value,
    }).select("*");

    avatarNew = res![0]['avatar'];
    nombreNew = res![0]['nombre'] + ' ' + res![0]['apellidos'];

    notifyListeners();
    return;
  }

  updaterolParaRegistro(int valor, String header) {
    rolParaRegistro = valor;
    headerText = header;
    /*  notifyListeners(); */
    clearControllers();
    return;
  }

  Future<void> setRolesSeleccionados(List<String> roles) async {
    rolesSeleccionados =
        this.roles.where((rol) => roles.contains(rol.nombreRol)).toList();
    roles.contains('Proveedor') ? isProveedor = true : isProveedor = false;
    roles.contains('Tesorero Local')
        ? isTesoreroLocal = true
        : isTesoreroLocal = false;
    if (isTesoreroLocal) {
      /*   await getJefeAreaTesoreria(); */
    }
    notifyListeners();
  }

  Future<void> getRoles() async {
    final res =
        await supabase.from('rol').select('nombre_rol, rol_id, permisos');
    roles = (res as List<dynamic>)
        .map((rol) => RolApi.fromJson(jsonEncode(rol)))
        .toList();

    notifyListeners();
  }

  Future<void> cambioSwitch(bool habilitado, String id) async {
    final res = await supabase.from('jefes_de_area').update(
        {'app_habilitada': habilitado}).match({'id_jefe_area_pk': id}).select();
    /*    getJefeArea(); */
    return;
  }

  Future<void> transferencia(String jefeOld, String jefeNew) async {
    await supabase
        .from('empleados')
        .update({'jefe_area_asignado_fk': jefeNew}).match(
            {'jefe_area_asignado_fk': jefeOld}).select();
    getJefeArea();
  }

  Future<void> getJefeArea() async {
    try {
      final String query = busquedaController.text;

      final res = await supabase.rpc('jefes_area_function').select();

      usuarios = (res as List<dynamic>)
          .map((usuario) => JefeArea.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();

      for (JefeArea usuario in usuarios) {
        if (query.isEmpty ||
            usuario.nombre.toLowerCase().contains(query.toLowerCase()) ||
            usuario.apellidos.toLowerCase().contains(query.toLowerCase()) ||
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
                'acciones': PlutoCell(value: usuario.idSecuencial),
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
      print("erro en: jefes_area_provider: getJefeArea() $e");
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

  getEmpleadosDelJefe(String idJefe) async {
    jefeOld = idJefe;
    try {
      final res = await supabase.rpc('get_empleados_todos_por_jefe', params: {
        'id': idJefe,
      }).select("*");

      return res['empleados_todos'];
    } catch (e) {
      print("ERROR en getJefeAreas: " + e.toString());
    }
    notifyListeners();
  }

  getColumnaDerecha(String id) async {
    try {
      final res = await supabase.rpc('obtener_jefes_area_excepto', params: {
        'id': id,
      }).select("*");

      return res;
    } catch (e) {
      print("ERROR en getJefeAreas: " + e.toString());
    }
    notifyListeners();
  }

  Future<bool> crearPerfilDeEmpleado(String userId) async {
    final res = await supabase.from('perfil_usuario').insert(
      {
        'perfil_usuario_id': userId,
        'nombre': nombreController.text,
        'apellidos': apellidosController.text,
        /* 'cuentas': cuentasDropValue, */
        'email': correoController.text.toLowerCase(),
        'telefono': telefonoController.text,
        'id_area_fk': areaTrabajoId,
        'rol_fk': rolParaRegistro,
        'avatar': imageName ??
            'https://xpbhozetzdxldzcbhcei.supabase.co/storage/v1/object/public/avatars/avatar-e42c5bd0-9110-11ed-98e7-3f1db831fd3c.png',
      },
    ).select();
    if (res == null) {
      print(
          "Error al intentar insertar nuevo usuario en la tabla de perfil_usuario");
      print(res.error!.message);
      return false;
    }

    return true;
  }

  void initEditarUsuario(JefeArea usuario) {
    nombreController.text = usuario.nombre;
    apellidosController.text = usuario.apellidos;
    correoController.text = usuario.email;
    /*   telefonoController.text = usuario.telefono;
    areaTrabajoController.text = usuario.area; */

    /*    paisesSeleccionados = usuario.paises; */
/*     rolesSeleccionados = usuario.roles; */
/*     imageName = usuario.avatar; */
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
