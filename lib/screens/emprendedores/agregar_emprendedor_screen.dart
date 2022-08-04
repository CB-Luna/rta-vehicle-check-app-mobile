import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/providers/sync_provider.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';

import 'package:bizpro_app/screens/emprendedores/emprendedor_creado.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

class AgregarEmprendedorScreen extends StatefulWidget {
  final int idEmprendimiento;
  final String nombreEmprendimiento;

  const AgregarEmprendedorScreen(
      {Key? key,
      required this.idEmprendimiento,
      required this.nombreEmprendimiento})
      : super(key: key);

  @override
  _AgregarEmprendedorScreenState createState() =>
      _AgregarEmprendedorScreenState();
}

class _AgregarEmprendedorScreenState extends State<AgregarEmprendedorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emprendedorKey = GlobalKey<FormState>();
  XFile? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emprendedorProvider = Provider.of<EmprendedorController>(context);
    final syncProvider = Provider.of<SyncProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        title: Text(
          'Registrar Emprendedor',
          style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: emprendedorKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro de Emprendedores',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  ),
                  FormField(
                    builder: (state) {
                       return  Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                String? option = await showModalBottomSheet(
                                  context: context,
                                  builder: (_) => const CustomBottomSheet(),
                                );
                    
                                if (option == null) return;
                    
                                final picker = ImagePicker();
                    
                                late final XFile? pickedFile;
                    
                                if (option == 'camera') {
                                  pickedFile = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 100,
                                  );
                                } else {
                                  pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100,
                                  );
                                }
                    
                                if (pickedFile == null) {
                                  return;
                                }
                    
                                setState(() {
                                  image = pickedFile;
                                  emprendedorProvider.imagen = image!.path;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/animation_500_l3ur8tqa.gif',
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF2CC3F4),
                                    width: 2,
                                  ),
                                ),
                                child: getImage(image?.path),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    validator: (val) {
                    if (emprendedorProvider.imagen == null ||
                        emprendedorProvider.imagen.isEmpty) {
                      return 'Para continuar, cargue una imagen';
                    }
                    return null;
                  }
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5, 10, 5, 10),
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            initialValue: widget.nombreEmprendimiento,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Emprendimiento',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.nombre = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nombre(s)*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa nombre..',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (value) {
                              return nombreCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese el nombre';
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.apellidos = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Apellidos*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa los apellidos',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (value) {
                              return nombreCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese los apellidos';
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.curp = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'CURP*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa el CURP..',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (value) {
                              return curpCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese un CURP';
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.integrantesFamilia = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Integrantes de familia*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingrese los integrantes...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            keyboardType: TextInputType.number,
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF060606),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (value) {
                              return familiaCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese un número de integrantes [0-99]';
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        //   child: TextFormField(
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       labelText: 'Comunidad',
                        //       labelStyle:
                        //           AppTheme.of(context).title3.override(
                        //                 fontFamily: 'Montserrat',
                        //                 color: AppTheme.of(context)
                        //                     .secondaryText,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //       hintText: 'Ingrese comunidad...',
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Color(0xFF060606),
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Color(0xFF060606),
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Color(0xFFF3F2F2),
                        //     ),
                        //     style: AppTheme.of(context).title3.override(
                        //           fontFamily: 'Poppins',
                        //           color: Color(0xFF060606),
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.telefono = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Numero telefónico*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingrese número telefónico...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            keyboardType: TextInputType.number,
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12),
                              telefonoFormat
                            ],
                            validator: (value) {
                              return (telefonoCharacters
                                          .hasMatch(value ?? '') &&
                                      value?.length == 12)
                                  ? null
                                  : 'Para continuar, ingrese un número telefónico';
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        //   child: TextFormField(
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       labelText: 'Emprendimiento',
                        //       labelStyle:
                        //           AppTheme.of(context).title3.override(
                        //                 fontFamily: 'Montserrat',
                        //                 color: AppTheme.of(context)
                        //                     .secondaryText,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //       hintText: 'Ingresa el emprendimiento...',
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Color(0xFF060606),
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Color(0xFF060606),
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Color(0xFFF3F2F2),
                        //     ),
                        //     style: AppTheme.of(context).title3.override(
                        //           fontFamily: 'Poppins',
                        //           color: Color(0xFF050000),
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //   ),
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9EEF9),
                            boxShadow: [
                              const BoxShadow(
                                color: Color(0xFFDBE2E7),
                                offset: Offset(0, 0),
                              )
                            ],
                            border: Border.all(
                              color: const Color(0x0025232E),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendedorProvider.comentarios = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Comentarios*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresar comentarios...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF131515),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            maxLines: 5,
                            validator: (value) {
                              return cualquierCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese un comentario';
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  if (emprendedorProvider.validateForm(emprendedorKey)) {
                                    emprendedorProvider.add(widget.idEmprendimiento);
                                    final updateVariableUser = dataBase.VariablesUsuarioBox.get(prefs.getInt("idVariablesUser")!);
                                    if (updateVariableUser != null) {
                                      updateVariableUser.emprendedores = false;
                                      dataBase.VariablesUsuarioBox.put(updateVariableUser);
                                    }
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EmprendedorCreado(),
                                      ),
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: const Text('Campos vacíos'),
                                          content: const Text(
                                              'Para continuar, debe llenar todos los campos e incluír una imagen.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Bien'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                },
                                text: 'Agregar Emprendedor',
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 290,
                                  height: 50,
                                  color: const Color(0xFF2CC3F4),
                                  textStyle:
                                      AppTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2CC3F4),
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
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
    );
  }
}
