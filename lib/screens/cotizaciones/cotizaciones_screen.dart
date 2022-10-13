import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/sync_provider_pocketbase.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class CotizacionesScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Inversiones inversion;
  final InversionesXProdCotizados inversionesXProdCotizados;
  const CotizacionesScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.inversion, 
    required this.inversionesXProdCotizados
    }) : super(key: key);

  @override
  State<CotizacionesScreen> createState() => _CotizacionesScreenState();
}

class _CotizacionesScreenState extends State<CotizacionesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      context.read<SyncProviderPocketbase>().getCotizacion(
        widget.emprendimiento, 
        widget.inversion,
        widget.inversionesXProdCotizados);
    });
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderPocketbase = Provider.of<SyncProviderPocketbase>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFDDEEF8),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bglogin2.png',
                    ).image,
                  ),
                ),
              ),
              Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                '¡Obteniendo Cotización!',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 30,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'Las cotizaciones se\nestán descargando, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.',
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            syncProviderPocketbase.procesocargando
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: getProgressIndicatorAnimated(
                                        "Descargando..."),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: Lottie.asset(
                                      'assets/lottie_animations/elemento-creado.json',
                                      width: 250,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      repeat: false,
                                      animate: true,
                                    ),
                                  ),
                            Visibility(
                              visible: syncProviderPocketbase.procesoterminado,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InversionesScreen(idEmprendimiento: widget.emprendimiento.id,),
                                      ),
                                    );
                                    syncProviderPocketbase.procesoTerminado(false);
                                  },
                                  text: 'Listo',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 45,
                                    color: AppTheme.of(context).secondaryText,
                                    textStyle:
                                        AppTheme.of(context).subtitle2.override(
                                              fontFamily: AppTheme.of(context)
                                                  .subtitle2Family,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}