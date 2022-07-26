import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrarJornada extends StatefulWidget {
  const RegistrarJornada({Key? key}) : super(key: key);

  @override
  _RegistrarJornadaState createState() => _RegistrarJornadaState();
}

class _RegistrarJornadaState extends State<RegistrarJornada> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        title: Text(
          'Registrar Jornada',
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
      backgroundColor: Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Jornada',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF0D0E0F),
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(

                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Emprendedor',
                            labelStyle:
                                AppTheme.of(context).title3.override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            hintText: 'Ingresa emprendedor...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
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
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Emprendimiento',
                            labelStyle:
                                AppTheme.of(context).title3.override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            hintText: 'Ingresa emprendimiento...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
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
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Fecha registro',
                            labelStyle:
                                AppTheme.of(context).title3.override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            hintText: 'Ingresa fecha..',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
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
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Registrar Tarea',
                            labelStyle:
                                AppTheme.of(context).title3.override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            hintText: 'Registro de tarea...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00060606),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00060606),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: AppTheme.of(context).title3.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF060606),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {
                                value = value;
                              },
                              activeColor:
                                  AppTheme.of(context).primaryColor,
                              checkColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Fecha de revisión',
                        labelStyle: AppTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color:
                                  AppTheme.of(context).secondaryText,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingresa fecha..',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
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
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Crear',
                  options: FFButtonOptions(
                    width: 150,
                    height: 40,
                    color: AppTheme.of(context).primaryColor,
                    textStyle: AppTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 15,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}