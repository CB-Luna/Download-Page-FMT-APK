import 'dart:developer';
import 'dart:typed_data';

import 'package:dowload_page_apk/router/router.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:dowload_page_apk/helpers/globals.dart';

class UserState extends ChangeNotifier {
  //EMAIL
  String _email = '';

  String get email => _email;
  Future<void> setEmail() async {
    _email = emailController.text;
    await prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD
  String _password = '';

  String get password => _password;
  Future<void> setPassword() async {
    _password = passwordController.text;
    await prefs.setString('password', passwordController.text);
  }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  //Variables para editar perfil
  TextEditingController nombrePerfil = TextEditingController();
  TextEditingController apellidosPerfil = TextEditingController();
  TextEditingController telefonoPerfil = TextEditingController();
  TextEditingController extensionPerfil = TextEditingController();
  TextEditingController emailPerfil = TextEditingController();
  TextEditingController contrasenaAnteriorPerfil = TextEditingController();
  TextEditingController confirmarContrasenaPerfil = TextEditingController();
  TextEditingController contrasenaPerfil = TextEditingController();

  String? imageName;
  Uint8List? webImage;

  //Constructor de provider
  UserState() {
    recuerdame = prefs.getBool('recuerdame') ?? false;

    if (recuerdame == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

  Future<bool> actualizarContrasena() async {
    try {
      final res = await supabase.rpc('change_user_password', params: {
        'current_plain_password': contrasenaAnteriorPerfil.text,
        'new_plain_password': contrasenaPerfil.text,
      });
      if (res == null) {
        log('Error en actualizarContrasena()');
        return false;
      }
      return true;
    } catch (e) {
      log('Error en actualizarContrasena() - $e');
      return false;
    }
  }

  void initPerfilUsuario() {
    if (currentUser == null) return;
    nombrePerfil.text = currentUser!.nombre;
    apellidosPerfil.text = currentUser!.apellidos;
    emailPerfil.text = currentUser!.email;
    imageName = currentUser!.imagen;
    webImage = null;
    contrasenaPerfil.clear();
    contrasenaAnteriorPerfil.clear();
    confirmarContrasenaPerfil.clear();
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

      return imageName;
    }
    return null;
  }

  Future<bool> editarPerfilDeUsuario() async {
    final res = await supabase.from('perfil_usuario').update(
      {
        'nombre': nombrePerfil.text,
        'apellidos': apellidosPerfil.text,
        'telefono': telefonoPerfil.text,
        'imagen': imageName,
      },
    ).eq('perfil_usuario_id', currentUser!.id);
    if (res == null) return false;
    return true;
  }

  Future<void> updateRecuerdame() async {
    recuerdame = !recuerdame;
    await prefs.setBool('recuerdame', recuerdame);
    notifyListeners();
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    currentUser = null;
    await prefs.remove('currentPais');
    await prefs.remove('currentRol');
    router.pushReplacement('/');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    nombrePerfil.dispose();
    emailPerfil.dispose();
    contrasenaPerfil.dispose();
    super.dispose();
  }
}
