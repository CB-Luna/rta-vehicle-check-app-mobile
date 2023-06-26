import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkin_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class SecuritySectionD extends StatefulWidget {
  
  const SecuritySectionD({super.key});

  @override
  State<SecuritySectionD> createState() => _SecuritySectionDState();
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

class _SecuritySectionDState extends State<SecuritySectionD> {
  @override
  Widget build(BuildContext context) {
    final checkInFormProvider = Provider.of<CheckInFormController>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: [
                // HEADER
                HeaderShimmer(
                  width: MediaQuery.of(context).size.width, 
                  text: "Security",
                ),
                // RTA Magnet
                ItemForm(
                  textItem: "RTA Magnet",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.rtaMagnetImages,
                  addImage: (image) {
                    checkInFormProvider.addRTAMagnetImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateRTAMagnetImage(image);
                  },
                  comments: checkInFormProvider.rtaMagnetComments,
                  report: checkInFormProvider.rtaMagnet,
                  updateReport: (report) {
                    checkInFormProvider.updateRTAMagnet(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Triangle Reflectors
                ItemForm(
                  textItem: "Triangle Reflectors",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.triangleReflectorsImages,
                  addImage: (image) {
                    checkInFormProvider.addTriangleReflectorsImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateTriangleReflectorsImage(image);
                  },
                  comments: checkInFormProvider.triangleReflectorsComments,
                  report: checkInFormProvider.triangleReflectors,
                  updateReport: (report) {
                    checkInFormProvider.updateTriangleReflectors(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Wheel Chocks
                ItemForm(
                  textItem: "Wheel Chocks",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.wheelChocksImages,
                  addImage: (image) {
                    checkInFormProvider.addWheelChocksImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateWheelChocksImage(image);
                  },
                  comments: checkInFormProvider.wheelChocksComments,
                  report: checkInFormProvider.wheelChocks,
                  updateReport: (report) {
                    checkInFormProvider.updateWheelChocks(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fire Extinguisher
                ItemForm(
                  textItem: "Fire Extinguisher",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.fireExtinguisherImages,
                  addImage: (image) {
                    checkInFormProvider.addFireExtinguisherImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateFireExtinguisherImage(image);
                  },
                  comments: checkInFormProvider.fireExtinguisherComments,
                  report: checkInFormProvider.fireExtinguisher,
                  updateReport: (report) {
                    checkInFormProvider.updateFireExtinguisher(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // First Ait Kit Safesty Vest
                ItemForm(
                  textItem: "First Ait Kit Safesty Vest",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.firstAidKitSafetyVestImages,
                  addImage: (image) {
                    checkInFormProvider.addFirstAidKitSafetyVestImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateFirstAidKitSafetyVestImage(image);
                  },
                  comments: checkInFormProvider.firstAidKitSafetyVestComments,
                  report: checkInFormProvider.firstAidKitSafetyVest,
                  updateReport: (report) {
                    checkInFormProvider.updateFirstAidKitSafetyVest(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Back Up Alarm
                ItemForm(
                  textItem: "Back Up Alarm",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.backUpAlarmImages,
                  addImage: (image) {
                    checkInFormProvider.addBackUpAlarmImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateBackUpAlarmImage(image);
                  },
                  comments: checkInFormProvider.backUpAlarmComments,
                  report: checkInFormProvider.backUpAlarm,
                  updateReport: (report) {
                    checkInFormProvider.updateBackUpAlarm(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),
            ]),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: [
                // HEADER
                HeaderShimmer(
                  width: MediaQuery.of(context).size.width, 
                  text: "Extra",
                ),
                // Ladder
                ItemForm(
                  textItem: "Ladder",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.ladderImages,
                  addImage: (image) {
                    checkInFormProvider.addLadderImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateLadderImage(image);
                  },
                  comments: checkInFormProvider.ladderComments,
                  report: checkInFormProvider.ladder,
                  updateReport: (report) {
                    checkInFormProvider.updateLadder(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Step Ladder
                ItemForm(
                  textItem: "Step Ladder",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.stepLadderImages,
                  addImage: (image) {
                    checkInFormProvider.addStepLadderImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateStepLadderImage(image);
                  },
                  comments: checkInFormProvider.stepLadderComments,
                  report: checkInFormProvider.stepLadder,
                  updateReport: (report) {
                    checkInFormProvider.updateStepLadder(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Ladder Straps (J-hook)
                ItemForm(
                  textItem: "Ladder Straps",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.ladderStrapsImages,
                  addImage: (image) {
                    checkInFormProvider.addLadderStrapsImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateLadderStrapsImage(image);
                  },
                  comments: checkInFormProvider.ladderStrapsComments,
                  report: checkInFormProvider.ladderStraps,
                  updateReport: (report) {
                    checkInFormProvider.updateLadderStraps(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Hydraulic Fluid For Bucket
                ItemForm(
                  textItem: "Hydraulic Fluid For Bucket",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.hydraulicFluidForBucketImages,
                  addImage: (image) {
                    checkInFormProvider.addHydraulicFluidForBucketImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateHydraulicFluidForBucketImage(image);
                  },
                  comments: checkInFormProvider.hydraulicFluidForBucketComments,
                  report: checkInFormProvider.hydraulicFluidForBucket,
                  updateReport: (report) {
                    checkInFormProvider.updateHydraulicFluidForBucket(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fiber Reel Rack	
                ItemForm(
                  textItem: "Fiber Reel Rack",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.fiberReelRackImages,
                  addImage: (image) {
                    checkInFormProvider.addFiberReelRackImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateFiberReelRackImage(image);
                  },
                  comments: checkInFormProvider.fiberReelRackComments,
                  report: checkInFormProvider.fiberReelRack,
                  updateReport: (report) {
                    checkInFormProvider.updateFiberReelRack(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                //Bins Locked And Secure
                ItemForm(
                  textItem: "Bins Locked And Secure",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.binsLockedAndSecureImages,
                  addImage: (image) {
                    checkInFormProvider.addBinsLockedAndSecureImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateBinsLockedAndSecureImage(image);
                  },
                  comments: checkInFormProvider.binsLockedAndSecureComments,
                  report: checkInFormProvider.binsLockedAndSecure,
                  updateReport: (report) {
                    checkInFormProvider.updateBinsLockedAndSecure(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Safety Harness
                ItemForm(
                  textItem: "Safety Harness",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.safetyHarnessImages,
                  addImage: (image) {
                    checkInFormProvider.addSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateSafetyHarnessImage(image);
                  },
                  comments: checkInFormProvider.safetyHarnessComments,
                  report: checkInFormProvider.safetyHarness,
                  updateReport: (report) {
                    checkInFormProvider.updateSafetyHarness(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Lanyard Safety Harness
                ItemForm(
                  textItem: "Layard Safety Harness",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.lanyardSafetyHarnessImages,
                  addImage: (image) {
                    checkInFormProvider.addLanyardSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateLanyardSafetyHarnessImage(image);
                  },
                  comments: checkInFormProvider.lanyardSafetyHarnessComments,
                  report: checkInFormProvider.lanyardSafetyHarness,
                  updateReport: (report) {
                    checkInFormProvider.updateLanyardSafetyHarness(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),
            ]),
          ),

        ],
      ),
    );
  }
}
