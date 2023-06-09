import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/menu_form_button.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_r_created.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_r_not_created.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
class ReceivedSchedulerScreen extends StatefulWidget {
  final String hour;
  final String period;
  final DateTime registeredHour;
  const ReceivedSchedulerScreen({
    super.key, 
    required this.hour, 
    required this.period, 
    required this.registeredHour,
    });

  @override
  State<ReceivedSchedulerScreen> createState() => _ReceivedSchedulerScreenState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();
final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };

class _ReceivedSchedulerScreenState extends State<ReceivedSchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    final vehiculoController = Provider.of<VehiculoController>(context);
    final receivingFromProvider = Provider.of<ReceivingFormController>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 5, 0, 0),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x39000000),
                            offset: Offset(-4, 8),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              color: FlutterFlowTheme.of(context).white,
                              size: 16,
                            ),
                            Text(
                              'Back',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context).white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0, 5, 5, 0),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x39000000),
                            offset: Offset(-4, 8),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (receivingFromProvider.validateForm()) {
                            if (receivingFromProvider.addControlForm(userProvider.usuarioCurrent)) {
                              // receivingFromProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormRCreatedScreen(),
                                ),
                              );
                            } else {
                              receivingFromProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormRNotCreatedScreen(),
                                ),
                              );
                            }
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Invalid action'),
                                  content: const Text(
                                      "The value of 'Mileage' and '% Gas/Diesel' are required."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Continue',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context).white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: FlutterFlowTheme.of(context).white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Receiving Form',
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Shimmer(
                  child: ClayContainer(
                    height: 60,
                    depth: 30,
                    spread: 2,
                    customBorderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30), 
                      bottomRight: Radius.circular(30),
                    ),
                    curveType: CurveType.concave,
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              maybeHandleOverflow("${
                                userProvider.usuarioCurrent?.name} ${
                                userProvider.usuarioCurrent?.lastName}", 20, "..."),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              "${userProvider.usuarioCurrent?.company.target?.company}",
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              DateFormat(
                               'hh:mm:ss').
                                format(
                                  widget.registeredHour),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    badge.Badge(
                      badgeContent: Text(
                        "${receivingFromProvider.pendingMeasures}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: receivingFromProvider.pendingMeasures != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.speed_outlined, 
                        onPressed: () {
                          vehiculoController.setTapedOptionReceived(0);
                        },
                        isTaped: vehiculoController.isTapedReceived == 0,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${receivingFromProvider.badStateLights}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: receivingFromProvider.badStateLights != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.flare, 
                        onPressed: () {
                          vehiculoController.setTapedOptionReceived(1);
                        },
                        isTaped: vehiculoController.isTapedReceived == 1,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${receivingFromProvider.badStateFluids}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: receivingFromProvider.badStateFluids != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.invert_colors, 
                        onPressed: () {
                          vehiculoController.setTapedOptionReceived(2);
                        },
                        isTaped: vehiculoController.isTapedReceived == 2,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${receivingFromProvider.badStateSecurity}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: receivingFromProvider.badStateSecurity != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.health_and_safety, 
                        onPressed: () {
                          vehiculoController.setTapedOptionReceived(3);
                        },
                        isTaped: vehiculoController.isTapedReceived == 3,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${receivingFromProvider.badStateEquipment}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: receivingFromProvider.badStateEquipment != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                      icon: Icons.build, 
                        onPressed: () {
                          vehiculoController.setTapedOptionReceived(4);
                        },
                        isTaped: vehiculoController.isTapedReceived == 4,
                      ),
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),

              Builder(
                builder: (context) {
                  return ListView.builder(
                      controller: ScrollController(),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      reverse: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        final section = vehiculoController.menuTapedReceived[
                            vehiculoController.isTapedReceived];
                        return section;
                      });
                },
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}