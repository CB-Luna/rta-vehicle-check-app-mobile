import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/jornadas/detalle_jornada_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class ProductoJornadaEliminado extends StatefulWidget {
  final Jornadas jornada;
  
  const ProductoJornadaEliminado({
    Key? key, 
    required this.jornada
    }) : super(key: key);

  @override
  State<ProductoJornadaEliminado> createState() =>
      _ProductoJornadaEliminadoState();
}

class _ProductoJornadaEliminadoState
    extends State<ProductoJornadaEliminado> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFDDEEF8),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text(
                        '¡Producto de Jornada\nEliminado!',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Listo, el producto se eliminará de tu\nlista de productos.',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: Lottie.asset(
                        'assets/lottie_animations/elemento-creado.json',
                        width: 250,
                        height: 180,
                        fit: BoxFit.cover,
                        repeat: false,
                        animate: true,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalleJornadaScreen(
                                    jornada: widget.jornada
                                  ,),
                            ),
                          );
                        },
                        text: 'Listo',
                        options: FFButtonOptions(
                          width: 200,
                          height: 45,
                          color: const Color(0xFF28BFFA),
                          textStyle: AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
