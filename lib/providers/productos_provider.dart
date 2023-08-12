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

class ProductosProvider extends ChangeNotifier {
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

  TextEditingController eventosController = TextEditingController();
  TextEditingController cuentaProveedorController = TextEditingController();
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

  List<Productos> productos = [];
  List<Productos> productosTesoreros = [];

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
  //PANTALLA productos
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

  ProductosProvider() {
    getProductos();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------
  Future<void> setSeccionActual(int value) async {
    seccionActual = value;
    await getProductos();
  }

  updaterolParaRegistro(int valor, String header) {
    rolParaRegistro = valor;
    headerText = header;
    /*  notifyListeners(); */
    clearControllers();
    return;
  }

  Future<void> getRoles() async {
    final res =
        await supabase.from('rol').select('nombre_rol, rol_id, permisos');
    roles = (res as List<dynamic>)
        .map((rol) => RolApi.fromJson(jsonEncode(rol)))
        .toList();

    notifyListeners();
  }

  Future<void> getProductos() async {
    try {
      final String query = busquedaController.text;

      final res = await supabase.from('producto').select('*');

      productos = (res as List<dynamic>)
          .map((usuario) => Productos.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();

      for (Productos producto in productos) {
        if (query.isEmpty ||
            producto.nombre.toLowerCase().contains(query.toLowerCase()) ||
            producto.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            producto.costo
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          rows.add(
            PlutoRow(
              cells: {
                'producto_id': PlutoCell(value: producto.productoId),
                'nombre': PlutoCell(value: producto.nombre),
                'descripcion': PlutoCell(value: producto.descripcion),
                'imagen': PlutoCell(value: producto.imagen),
                'costo': PlutoCell(value: producto.costo),
                'acciones': PlutoCell(value: producto.productoId),
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
      print("erro en: ProductosProvider: getProductos() $e");
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

  getProductossDelJefe(String idJefe) async {
    jefeOld = idJefe;
    try {
      final res = await supabase.rpc('get_empleados_todos_por_jefe', params: {
        'id': idJefe,
      }).select("*");

      return res['empleados_todos'];
    } catch (e) {
      print("ERROR en getProductoss: " + e.toString());
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
      print("ERROR en getProductoss: " + e.toString());
    }
    notifyListeners();
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

    /*    notifyListeners(); */
  }

  Future<String?> uploadImage() async {
    if (webImage != null && imageName != null) {
      final storageResponse =
          await supabase.storage.from('avatars').uploadBinary(
                imageName!,
                webImage!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
      if (storageResponse == null) return null;
      dynamic res = supabase.storage.from('avatars').getPublicUrl(imageName!);
      imageName = res;
      return imageName;
    }
    return null;
  }

  Future<String?> registrarEmpleado() async {
    try {
      //Registrar al usuario con una contraseña temporal
      final response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/signup'),
        headers: {'Content-Type': 'application/json', 'apiKey': anonKey},
        body: json.encode(
          {
            "email": correoController.text.toLowerCase(),
            "password": 'default',
          },
        ),
      );
      if (response.statusCode > 204) return 'El usuario ya existe';

      final String? userId = jsonDecode(response.body)['user']['id'];

      if (userId != null) return userId;

      return 'Error al registrar usuario';
    } catch (e) {
      print('Error en registrarUsuario() - $e');
      return 'Error al registrar usuario';
    }
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

/*   Future<bool> editarPerfilDeEmpleado(String userId) async {
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
 */
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
