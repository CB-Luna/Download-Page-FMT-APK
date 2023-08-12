import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dowload_page_apk/helpers/constants.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/models.dart';

class UsuariosProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  //ALTA USUARIO
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController areaTrabajoController = TextEditingController();
  //-----Considerar eliminar
  late int rolParaRegistro;
  String altaDropValue = "";
  int areaTrabajoId = 7; //por de
  int rolUsuario = 2;
  //-----------------
  String? imageName;
  Uint8List? webImage;
  List<RolApi> roles = [];
  List<Usuario> usuarios = [];
  List<String> areaNames = [];

  RolApi? rolSeleccionado;

  //EDITAR USUARIOS
  Usuario? usuarioEditado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "id_secuencial";

  UsuariosProvider() {
    getUsuarios();
    getAreaNames();
  }
  Future<void> updateState() async {
    await getUsuarios();
    await getAreaNames();
  }

  void clearControllers({bool clearEmail = true, bool notify = true}) {
    nombreController.clear();
    if (clearEmail) correoController.clear();
    apellidosController.clear();

    rolSeleccionado = null;

    if (notify) notifyListeners();
  }

  Future<void> getRoles({bool notify = true}) async {
    final res =
        await supabase.from('rol').select('nombre, rol_id, permisos').order(
              'nombre',
              ascending: true,
            );

    roles = (res as List<dynamic>)
        .map((rol) => RolApi.fromJson(jsonEncode(rol)))
        .toList();

    if (notify) notifyListeners();
  }

  void setRolSeleccionado(String rol) {
    try {
      rolSeleccionado = roles.firstWhere((element) => element.nombreRol == rol);
      notifyListeners();
    } catch (e) {
      log('Error en setRolSeleccionado - $e');
    }
  }

  Future<void> getUsuarios() async {
    try {
      final res = await supabase
          .from('users')
          .select()
          .like('nombre', '%${busquedaController.text}%')
          .order(orden, ascending: true);

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      usuarios = (res as List<dynamic>)
          .map((usuario) => Usuario.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (Usuario usuario in usuarios) {
        rows.add(
          PlutoRow(
            cells: {
              'id_secuencial': PlutoCell(value: usuario.idSecuencial),
              'nombre':
                  PlutoCell(value: "${usuario.nombre} ${usuario.apellidos}"),
              'rol': PlutoCell(value: usuario.rol.nombreRol),
              'email': PlutoCell(value: usuario.email),
              'acciones': PlutoCell(value: usuario.id),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
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

    notifyListeners();
  }

  void clearImage() {
    webImage = null;
    imageName = null;
    notifyListeners();
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

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------REGISTRO Y ALTAS EN POPUP-----------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
  Future<String?> registrarUsuarioV2() async {
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

      final String? userId = jsonDecode(response.body)['id'];

      if (userId != null) return userId;

      return 'Error al registrar usuario';
    } catch (e) {
      print('Error en registrarUsuarioV2() - $e');
      return 'Error al registrar usuario';
    }
  }

  Future<bool> crearPerfilDeUsuarioV2(String userId, int rol) async {
    try {
      await supabase.from('perfil_usuario').insert(
        {
          'perfil_usuario_id': userId,
          'nombre': nombreController.text,
          'apellidos': apellidosController.text,
          'imagen': imageName,
          'area': areaTrabajoId,
          'rol_fk': rol
        },
      );
      return true;
    } catch (e) {
      print('Error en crearPerfilDeUsuarioV2() - $e');
      return false;
    }
  }

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

  Future<Map<String, String>?> registrarUsuario() async {
    try {
      //Registrar al usuario con una contraseña temporal
      final response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/signup'),
        headers: {'Content-Type': 'application/json', 'apiKey': anonKey},
        body: json.encode(
          {
            "email": correoController.text,
            "password": 'default',
          },
        ),
      );
      if (response.statusCode > 204) return {'Error': 'El usuario ya existe'};

      final String? userId = jsonDecode(response.body)['user']['id'];

      //retornar el id del usuario
      if (userId != null) return {'userId': userId};

      return {'Error': 'Error al registrar usuario'};
    } catch (e) {
      log('Error en registrarUsuario() - $e');
      return {'Error': 'Error al registrar usuario'};
    }
  }

  Future<bool> crearPerfilDeUsuario(String userId) async {
    if (rolSeleccionado == null) return false;
    final res = await supabase.from('perfil_usuario').insert(
      {
        'perfil_usuario_id': userId,
        'nombre': nombreController.text,
        'apellidos': apellidosController.text,
        'imagen': imageName,
        'rol_fk': rolSeleccionado!.rolId,
      },
    );
    return true;
  }

  Future<bool> editarPerfilDeUsuario(String userId) async {
    final res = await supabase.from('perfil_usuario').update(
      {
        'nombre': nombreController.text,
        'apellidos': apellidosController.text,
        'imagen': imageName,
      },
    ).eq('perfil_usuario_id', userId);
    return true;
  }

  Future<int> getidarea(String nombreArea) async {
    try {
      final res = await supabase
          .from('areas')
          .select('id_area_pk')
          .eq('nombre_area', nombreArea);

      areaTrabajoId = res.first['id_area_pk'];

      return res.first['id_area_pk'];
    } catch (e) {
      print("ERROR en getIDarea: " + e.toString());

      return 7;
    }
  }

  getAreaNames() async {
    try {
      final res = await supabase.from('areas').select('nombre_area');

      final areaNames = (res as List<dynamic>)
          .map((area) => area['nombre_area'] as String)
          .toList();
      print(areaNames);
      notifyListeners();
      return areaNames;
    } catch (e) {
      print("ERROR en getAreaNames: " + e.toString());
      rethrow;
    }
  }

  Future<void> initEditarUsuario(Usuario usuario) async {
    usuarioEditado = usuario;
    nombreController.text = usuario.nombre;
    apellidosController.text = usuario.apellidos;
    correoController.text = usuario.email;
    rolSeleccionado = usuario.rol;
    imageName = usuario.imagen;
    webImage = null;
  }

  @override
  void dispose() {
    busquedaController.dispose();
    nombreController.dispose();
    correoController.dispose();
    apellidosController.dispose();
    super.dispose();
  }
}
