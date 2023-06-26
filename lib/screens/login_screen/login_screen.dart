import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/providers.dart';
import 'package:taller_alex_app_asesor/providers/roles_supabase_provider.dart';
import 'package:taller_alex_app_asesor/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';
import 'package:taller_alex_app_asesor/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool contrasenaVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final rolesSupabaseProvider = Provider.of<RolesSupabaseProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiaryColor,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'assets/images/bgFleet@2x.png',
              ).image,
            ),
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 50),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/rta_logo.png',
                            width: 180,
                            height: 180,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Control System Vehicle',
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).alternate,
                              fontSize: 36,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                            child: Text(
                              'Car Check Up',
                              style: FlutterFlowTheme.of(context).title3.override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context).alternate,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: userState.emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: FlutterFlowTheme.of(context).bodyText2,
                                hintText: 'Input your email...',
                                hintStyle: FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                errorStyle: TextStyle(
                                  color: FlutterFlowTheme.of(context).white,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Outfit',
                                    color:
                                        FlutterFlowTheme.of(context).tertiaryColor,
                                  ),
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Please input a valid email';
                              }
                              return null;
                            },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLength: 50,
                              controller: userState.passwordController,
                              obscureText: !contrasenaVisibility,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: FlutterFlowTheme.of(context).bodyText2,
                                hintText: 'Input your password...',
                                hintStyle: FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: TextStyle(
                                  color: FlutterFlowTheme.of(context).white,
                                ),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => contrasenaVisibility =
                                        !contrasenaVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    contrasenaVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color:
                                        FlutterFlowTheme.of(context).tertiaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Container(
                        width: 160,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            userState.updateRecuerdame();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Remember Me',
                                style:
                                    FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).alternate,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                              ),
                              ToggleIcon(
                                onPressed: () async {
                                  userState.updateRecuerdame();
                                },
                                value: userState.recuerdame,
                                onIcon: Icon(
                                  Icons.check_box,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 25,
                                ),
                                offIcon: Icon(
                                  Icons.check_box_outline_blank,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              // await Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CreateAccountWidget(),
                              //   ),
                              // );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Have you an account, yet?',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Text(
                                  'Create Account',
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              //Se revisa el estatus de la Red
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult == ConnectivityResult.none) {
                                //print("Proceso offline");
                                //Proceso Offline
                                final usuarioActual =
                                    usuarioProvider.validateUserOffline(
                                        userState.emailController.text,
                                        userState.passwordController.text);
                                if (usuarioActual != null) {
                                  //print('Usuario ya existente');
                                  //Se guarda el ID DEL USUARIO (correo electrónico)
                                  prefs.setString(
                                      "userId", userState.emailController.text);
                                  //Se guarda el Password encriptado
                                  prefs.setString(
                                      "passEncrypted", userState.passwordController.text);
                                  usuarioProvider
                                      .getUser(prefs.getString("userId")!);
              
                                  if (userState.recuerdame == true) {
                                    await userState.setEmail();
                                    await userState.setPassword();
                                  } else {
                                    userState.emailController.text = '';
                                    userState.passwordController.text = '';
                                    await prefs.remove('email');
                                    await prefs.remove('password');
                                  }
                  
                                  if (!mounted) return;
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ControlDailyVehicleScreen(),
                                    ),
                                  );
                                } else {
                                  //print('Usuario no existente localmente');
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Wrong credentials! Invalid email or password."),
                                  ));
                                }
                              } else {
                                // print("Proceso online");
                                //Login a Supabase
                                final loginResponseSupabase =
                                    await AuthService.loginSupabase(
                                  userState.emailController.text,
                                  userState.passwordController.text,
                                );
                                if (loginResponseSupabase != null) {
                                  final getUsuarioSupabase =
                                    await AuthService.getUserByUserIDSupabase(
                                    loginResponseSupabase.user.id
                                  );
                                  if (getUsuarioSupabase != null) {
                                     //Se descargan los roles desde Supabase
                                    rolesSupabaseProvider.exitoso = true;
                                    rolesSupabaseProvider.procesoCargando(true);
                                    rolesSupabaseProvider.procesoTerminado(false);
                                    rolesSupabaseProvider.procesoExitoso(false);
                                    Future<bool> booleanoSupabase =
                                        rolesSupabaseProvider.getRolesSupabase(getUsuarioSupabase.idPerfilUsuario);
                                    if (await booleanoSupabase) {
                                      await userState.setTokenPocketbase(
                                          loginResponseSupabase.accessToken);
                                      final userId =
                                          loginResponseSupabase.user.email;
                                      //Se guarda el ID DEL USUARIO (correo)
                                      prefs.setString("userId", userId);
                                      //Se guarda el Password encriptado
                                      prefs.setString(
                                          "passEncrypted", userState.passwordController.text);
                                      //Se válida que el Usuario exista localmente
                                      if (usuarioProvider
                                          .validateUsuario(userId)) {
                                        //print('Usuario ya existente');
                                        usuarioProvider.getUser(userId);
                                        usuarioProvider.update(
                                          userState.emailController.text,
                                          getUsuarioSupabase.name,
                                          getUsuarioSupabase.lastName,
                                          getUsuarioSupabase.middleName,
                                          getUsuarioSupabase.homephoneNumber,
                                          getUsuarioSupabase.telephoneNumber,
                                          getUsuarioSupabase.address,
                                          userState.passwordController.text,
                                          getUsuarioSupabase.image,
                                          [getUsuarioSupabase.role.id.toString()],
                                          getUsuarioSupabase.birthdate,
                                          getUsuarioSupabase.company.companyId.toString(),
                                          getUsuarioSupabase.idVehicleFk.toString(),
                                          rolesSupabaseProvider.recordsMonthCurrentR!.length,
                                          rolesSupabaseProvider.recordsMonthSecondR!.length,
                                          rolesSupabaseProvider.recordsMonthThirdR!.length,
                                          rolesSupabaseProvider.recordsMonthCurrentD!.length,
                                          rolesSupabaseProvider.recordsMonthSecondD!.length,
                                          rolesSupabaseProvider.recordsMonthThirdD!.length,
                                        );
                                      } else {
                                        usuarioProvider.add(
                                          getUsuarioSupabase.name,
                                          getUsuarioSupabase.lastName,
                                          getUsuarioSupabase.middleName,
                                          getUsuarioSupabase.homephoneNumber,
                                          getUsuarioSupabase.telephoneNumber,
                                          getUsuarioSupabase.address,
                                          loginResponseSupabase.user.email,
                                          userState.passwordController.text,
                                          getUsuarioSupabase.image,
                                          [getUsuarioSupabase.role.id.toString()],
                                          getUsuarioSupabase.id,
                                          getUsuarioSupabase.birthdate,
                                          getUsuarioSupabase.company.companyId.toString(),
                                          getUsuarioSupabase.idVehicleFk.toString(),
                                          rolesSupabaseProvider.recordsMonthCurrentR!.length,
                                          rolesSupabaseProvider.recordsMonthSecondR!.length,
                                          rolesSupabaseProvider.recordsMonthThirdR!.length,
                                          rolesSupabaseProvider.recordsMonthCurrentD!.length,
                                          rolesSupabaseProvider.recordsMonthSecondD!.length,
                                          rolesSupabaseProvider.recordsMonthThirdD!.length,
                                        );
                                        usuarioProvider.getUser(loginResponseSupabase.user.email);
                                      }
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
                                      // //Se descargan los proyectos por cada tipo de Usuario
                                      // bool procesoExistoso = false;
                                      // switch (usuarioProvider.usuarioCurrent!.role.target!.role) {
                                      //   case "Asesor":
                                      //     break;
                                      //   case "Técnico-Mecánico":
                                      //     break;
                                      //   case "Cliente":
                                      //     break;
                                      //   default:
                                      //     break;
                                      // }
                  
                                      // if (!procesoExistoso) {
                                      //     snackbarKey.currentState
                                      //       ?.showSnackBar(const SnackBar(
                                      //     content: Text(
                                      //         "'Attempting Inspection Reports Data Recovery for Current User from Server' Failed."),
                                      //   ));
                                      // }
                                      if (!mounted) return;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ControlDailyVehicleScreen(),
                                        ),
                                      );
                                    } else {
                                      snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                        content: Text(
                                            "'Attempting Rol Data Recovery from Server' Failed ."),
                                      ));
                                    }
                                  } else {
                                    snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "'Attempting User Data Recovery from Server' Failed."),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Invalid Credentials! Invalid email or password."),
                                    ));
                                }
                              }
                            },
                            text: 'Log In',
                            options: FFButtonOptions(
                              width: 130,
                              height: 50,
                              color: FlutterFlowTheme.of(context).alternate,
                              textStyle:
                                  FlutterFlowTheme.of(context).subtitle1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                              elevation: 3,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 24),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        // await Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         ForgotPasswordWidget(),
                                        //   ),
                                        // );
                                      },
                                      text: 'Forget your password?',
                                      options: FFButtonOptions(
                                        width: 170,
                                        height: 30,
                                        color: const Color(0x00FFFFFF),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        elevation: 0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        ),
      ),
    );
  }
}
