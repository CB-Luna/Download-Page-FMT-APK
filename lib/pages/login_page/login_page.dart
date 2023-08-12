import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

import 'package:dowload_page_apk/helpers/supabase/queries.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/configuration.dart';
import 'package:dowload_page_apk/pages/login_page/reset_password_popup.dart';
import 'package:dowload_page_apk/services/api_error_handler.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/pages/widgets/custom_button.dart';
import 'package:dowload_page_apk/pages/widgets/toggle_icon.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sf;
import 'package:rive/rive.dart' as rive;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.of(context).primaryBackground,
          child: Stack(
            children: [
              Theme.of(context).brightness == Brightness.dark
                  ? const rive.RiveAnimation.asset(
                      'assets/rive_animations/squaresdark.riv',
                      fit: BoxFit.cover,
                    )
                  : const rive.RiveAnimation.asset(
                      'assets/rive_animations/squares.riv',
                      fit: BoxFit.cover,
                    ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(100, 50, 0, 0),
                        // child: Image.network(
                        //   assets.logoBlanco,
                        //   height: 50,
                        //   fit: BoxFit.cover,
                        // ),
                        child: AppTheme.themeMode == ThemeMode.dark
                            ? Image.network(
                                assets.logoBlanco,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                assets.logoColor,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 800,
                          height: 800,
                          child: CustomPaint(
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 50),
                                    child: Text(
                                      'Inicio de sesión',
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Bicyclette-Light',
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                            fontSize: 60,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: false,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: TextFormField(
                                      controller: userState.emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'El correo es requerido';
                                        } else if (!EmailValidator.validate(
                                            value)) {
                                          return 'Por favor ingresa un correo válido';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Usuario',
                                        hintText: 'Usuario',
                                        labelStyle: AppTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintStyle: AppTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .secondaryColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AppTheme.of(context)
                                                .secondaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 60, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextFormField(
                                        controller:
                                            userState.passwordController,
                                        obscureText: !passwordVisibility,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'La contraseña es requerida';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Contraseña',
                                          hintText: 'Contraseña',
                                          hintStyle: AppTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          labelStyle: AppTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => passwordVisibility =
                                                  !passwordVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .secondaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 40, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 5, 0),
                                          child: ToggleIcon(
                                            onPressed: () async {
                                              userState.updateRecuerdame();
                                            },
                                            value: userState.recuerdame,
                                            onIcon: Icon(
                                              Icons.check_circle_outline_sharp,
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              size: 36,
                                            ),
                                            offIcon: FaIcon(
                                              FontAwesomeIcons.circle,
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 5, 0, 0),
                                          child: Text(
                                            'Recordarme',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 40, 5, 0),
                                    child: InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (_) =>
                                            const ResetPasswordPopup(),
                                      ),
                                      child: Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 40, 0, 0),
                                    child: CustomButton(
                                      onPressed: () async {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }

                                        //Login
                                        try {
                                          await supabase.auth
                                              .signInWithPassword(
                                            email:
                                                userState.emailController.text,
                                            password: userState
                                                .passwordController.text,
                                          );

                                          if (userState.recuerdame == true) {
                                            await userState.setEmail();
                                            await userState.setPassword();
                                          } else {
                                            userState.emailController.text = '';
                                            userState.passwordController.text =
                                                '';
                                            await prefs.remove('email');
                                            await prefs.remove('password');
                                          }

                                          if (supabase.auth.currentUser ==
                                              null) {
                                            await ApiErrorHandler.callToast();
                                            return;
                                          }

                                          currentUser = await SupabaseQueries
                                              .getCurrentUserData();
                                          print(currentUser!.rol);
                                          Configuration? config =
                                              await SupabaseQueries
                                                  .getUserTheme();
                                          AppTheme.initConfiguration(config);
                                          if (config != null) {
                                            assets.logoBlanco =
                                                config.logos.logoBlanco;
                                            assets.logoColor =
                                                config.logos.logoColor;
                                          }

                                          if (currentUser == null) {
                                            await ApiErrorHandler.callToast();
                                            return;
                                          }

                                          if (!mounted) return;
                                          if (currentUser!.esEmpleado) {
                                            context.pushReplacement('/saldo');
                                          } else if (currentUser!
                                              .esJefeDeArea) {
                                            context
                                                .pushReplacement('/empleados');
                                          } else if (currentUser!
                                              .esAdministrador) {
                                            context.pushReplacement('/home');
                                          }
                                        } catch (e) {
                                          if (e is sf.AuthException) {
                                            await ApiErrorHandler.callToast(
                                                'Credenciales inválidas');
                                            return;
                                          }
                                          log('Error al iniciar sesion - $e');
                                        }
                                      },
                                      text: 'Ingresar',
                                      options: ButtonOptions(
                                        width: 200,
                                        height: 50,
                                        color:
                                            AppTheme.of(context).primaryColor,
                                        textStyle: AppTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 40, 15, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                              child: FaIcon(
                                                FontAwesomeIcons.shieldHalved,
                                                color: AppTheme.of(context)
                                                    .primaryColor,
                                                size: 40,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                              child: Text(
                                                'Acceso\nseguro',
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      fontSize: 15,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 2,
                                          height: 70,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE7E7E7),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 2),
                                          child: Text(
                                            'La seguridad es nuestra prioridad, por\neso usamos los estándares mas altos.',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: AppTheme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPaint extends StatefulWidget {
  const LoginPaint({Key? key}) : super(key: key);

  @override
  State<LoginPaint> createState() => _LoginPaintState();
}

class _LoginPaintState extends State<LoginPaint> {
  @override
  Widget build(BuildContext context) {
    //Make the particles be inside

    return CustomPaint(
      painter: ContainerLogin(),
      foregroundPainter: ContainerLogin(),
    );
  }
}

class ContainerLogin extends CustomPainter {
  final Gradient gradient = const LinearGradient(
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 240, 240, 240)
    ],
  );
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
//Number 0
/*     Path path0 = Path();
    path0.moveTo(size.width * 1, size.height * 1);
    path0.lineTo(size.width * 0, size.height * 1);
    path0.lineTo(size.width * 0, size.height * 0);
    path0.lineTo(size.width * 1, size.height * 0);
    path0.lineTo(size.width * 1, size.height * 1);
    Paint linea0 = Paint();
    linea0.color = Color.fromRGBO(242, 105, 37, 1);
    canvas.drawPath(path0, linea0); */

//Number 1
    Path path1 = Path();
    path1.moveTo(size.width * 0.9681, size.height * 0.8159);
    path1.lineTo(size.width * 0.8243, size.height * 0.8159);
    path1.quadraticBezierTo(size.width * 0.7561, size.height * 0.8846,
        size.width * 0.6789, size.height * 0.9346);
    path1.quadraticBezierTo(size.width * 0.58, size.height * 0.9988,
        size.width * 0.5492, size.height * 0.9988);
    path1.quadraticBezierTo(size.width * 0.6, size.height * 0.9525,
        size.width * 0.598, size.height * 0.8913);
    path1.cubicTo(
        size.width * 0.5975,
        size.height * 0.8746,
        size.width * 0.6145,
        size.height * 0.786,
        size.width * 0.495,
        size.height * 0.7838);
    path1.cubicTo(size.width * 0.3755, size.height * 0.7815, size.width * 0.392,
        size.height * 0.8675, size.width * 0.393, size.height * 0.8975);
    path1.cubicTo(size.width * 0.395, size.height * 0.9588, size.width * 0.445,
        size.height * 1, size.width * 0.443, size.height * 0.9988);
    path1.cubicTo(size.width * 0.441, size.height * 0.9975, size.width * 0.4298,
        size.height * 1.0108, size.width * 0.3376, size.height * 0.9587);
    path1.quadraticBezierTo(size.width * 0.2455, size.height * 0.9065,
        size.width * 0.2065, size.height * 0.8159);
    path1.lineTo(size.width * 0.0319, size.height * 0.8159);
    path1.cubicTo(size.width * 0.0143, size.height * 0.8159, size.width * 0,
        size.height * 0.7981, size.width * 0, size.height * 0.7761);
    path1.lineTo(size.width * 0, size.height * 0.0398);
    path1.cubicTo(size.width * 0, size.height * 0.0178, size.width * 0.0143,
        size.height * 0, size.width * 0.0319, size.height * 0);
    path1.lineTo(size.width * 0.9681, size.height * 0);
    path1.cubicTo(size.width * 0.9857, size.height * 0, size.width * 1,
        size.height * 0.0178, size.width * 1, size.height * 0.0398);
    path1.lineTo(size.width * 1, size.height * 0.7761);
    path1.cubicTo(size.width * 1, size.height * 0.7981, size.width * 0.9857,
        size.height * 0.8159, size.width * 0.9681, size.height * 0.8159);
    Paint linea1 = Paint();
    //use graident
    linea1.shader = gradient.createShader(rect);
    linea1.color = const Color.fromRGBO(245, 245, 245, 1);
    canvas.drawShadow(path1.shift(const Offset(5, 5).scale(0.1, 0.1)),
        const Color.fromARGB(255, 0, 0, 0).withAlpha(80), 7, false); //shadow
    canvas.drawShadow(path1.shift(const Offset(-15, -15).scale(0, 0)),
        const Color.fromARGB(255, 255, 255, 255), 7, false); //shadow
    canvas.drawPath(path1, linea1);
//Number 2
    Path path2 = Path();
    path2.moveTo(size.width * 0.43, size.height * 0.9938);
    path2.quadraticBezierTo(size.width * 0.391, size.height * 0.9725,
        size.width * 0.332, size.height * 0.8975);
    path2.quadraticBezierTo(size.width * 0.2797, size.height * 0.831,
        size.width * 0.266, size.height * 0.7663);
    path2.lineTo(size.width * 0.089, size.height * 0.7675);
    path2.lineTo(size.width * 0.33, size.height * 0.6108);
    path2.lineTo(size.width * 0.1582, size.height * 0.3759);
    path2.lineTo(size.width * 0.3896, size.height * 0.4771);
    path2.lineTo(size.width * 0.3133, size.height * 0.1807);
    path2.lineTo(size.width * 0.4564, size.height * 0.3903);
    path2.lineTo(size.width * 0.52, size.height * 0.0613);
    path2.lineTo(size.width * 0.5662, size.height * 0.3903);
    path2.lineTo(size.width * 0.6879, size.height * 0.1698);
    path2.lineTo(size.width * 0.633, size.height * 0.4771);
    path2.lineTo(size.width * 0.8406, size.height * 0.3723);
    path2.lineTo(size.width * 0.6999, size.height * 0.6108);
    path2.lineTo(size.width * 0.931, size.height * 0.7663);
    path2.lineTo(size.width * 0.775, size.height * 0.7663);
    path2.quadraticBezierTo(size.width * 0.723, size.height * 0.8525,
        size.width * 0.677, size.height * 0.8975);
    path2.quadraticBezierTo(size.width * 0.6114, size.height * 0.9616,
        size.width * 0.549, size.height * 0.9988);
    path2.quadraticBezierTo(size.width * 0.584, size.height * 0.9738,
        size.width * 0.585, size.height * 0.9113);
    path2.cubicTo(size.width * 0.5861, size.height * 0.8426, size.width * 0.543,
        size.height * 0.8088, size.width * 0.505, size.height * 0.81);
    path2.cubicTo(
        size.width * 0.4196,
        size.height * 0.8128,
        size.width * 0.4153,
        size.height * 0.8824,
        size.width * 0.414,
        size.height * 0.9038);
    path2.cubicTo(
        size.width * 0.4092,
        size.height * 0.9824,
        size.width * 0.4685,
        size.height * 1.0135,
        size.width * 0.43,
        size.height * 0.9938);
    Paint linea2 = Paint();
    linea2.color = const Color.fromRGBO(255, 255, 255, 1);
    canvas.drawPath(path2, linea2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
