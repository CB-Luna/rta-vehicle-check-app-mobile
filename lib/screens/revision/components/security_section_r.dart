import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class SecuritySectionR extends StatefulWidget {
  
  const SecuritySectionR({super.key});

  @override
  State<SecuritySectionR> createState() => _SecuritySectionRState();
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

class _SecuritySectionRState extends State<SecuritySectionR> {
  @override
  Widget build(BuildContext context) {
    final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
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
                  images: checkOutFormProvider.rtaMagnetImages,
                  addImage: (image) {
                    checkOutFormProvider.addRTAMagnetImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateRTAMagnetImage(image);
                  },
                  comments: checkOutFormProvider.rtaMagnetComments,
                  report: checkOutFormProvider.rtaMagnet,
                  updateReport: (report) {
                    checkOutFormProvider.updateRTAMagnet(report);
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
                  images: checkOutFormProvider.triangleReflectorsImages,
                  addImage: (image) {
                    checkOutFormProvider.addTriangleReflectorsImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateTriangleReflectorsImage(image);
                  },
                  comments: checkOutFormProvider.triangleReflectorsComments,
                  report: checkOutFormProvider.triangleReflectors,
                  updateReport: (report) {
                    checkOutFormProvider.updateTriangleReflectors(report);
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
                  images: checkOutFormProvider.wheelChocksImages,
                  addImage: (image) {
                    checkOutFormProvider.addWheelChocksImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateWheelChocksImage(image);
                  },
                  comments: checkOutFormProvider.wheelChocksComments,
                  report: checkOutFormProvider.wheelChocks,
                  updateReport: (report) {
                    checkOutFormProvider.updateWheelChocks(report);
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
                  images: checkOutFormProvider.fireExtinguisherImages,
                  addImage: (image) {
                    checkOutFormProvider.addFireExtinguisherImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateFireExtinguisherImage(image);
                  },
                  comments: checkOutFormProvider.fireExtinguisherComments,
                  report: checkOutFormProvider.fireExtinguisher,
                  updateReport: (report) {
                    checkOutFormProvider.updateFireExtinguisher(report);
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
                  images: checkOutFormProvider.firstAidKitSafetyVestImages,
                  addImage: (image) {
                    checkOutFormProvider.addFirstAidKitSafetyVestImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateFirstAidKitSafetyVestImage(image);
                  },
                  comments: checkOutFormProvider.firstAidKitSafetyVestComments,
                  report: checkOutFormProvider.firstAidKitSafetyVest,
                  updateReport: (report) {
                    checkOutFormProvider.updateFirstAidKitSafetyVest(report);
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
                  images: checkOutFormProvider.backUpAlarmImages,
                  addImage: (image) {
                    checkOutFormProvider.addBackUpAlarmImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateBackUpAlarmImage(image);
                  },
                  comments: checkOutFormProvider.backUpAlarmComments,
                  report: checkOutFormProvider.backUpAlarm,
                  updateReport: (report) {
                    checkOutFormProvider.updateBackUpAlarm(report);
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
                  images: checkOutFormProvider.ladderImages,
                  addImage: (image) {
                    checkOutFormProvider.addLadderImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateLadderImage(image);
                  },
                  comments: checkOutFormProvider.ladderComments,
                  report: checkOutFormProvider.ladder,
                  updateReport: (report) {
                    checkOutFormProvider.updateLadder(report);
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
                  images: checkOutFormProvider.stepLadderImages,
                  addImage: (image) {
                    checkOutFormProvider.addStepLadderImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateStepLadderImage(image);
                  },
                  comments: checkOutFormProvider.stepLadderComments,
                  report: checkOutFormProvider.stepLadder,
                  updateReport: (report) {
                    checkOutFormProvider.updateStepLadder(report);
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
                  images: checkOutFormProvider.ladderStrapsImages,
                  addImage: (image) {
                    checkOutFormProvider.addLadderStrapsImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateLadderStrapsImage(image);
                  },
                  comments: checkOutFormProvider.ladderStrapsComments,
                  report: checkOutFormProvider.ladderStraps,
                  updateReport: (report) {
                    checkOutFormProvider.updateLadderStraps(report);
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
                  images: checkOutFormProvider.hydraulicFluidForBucketImages,
                  addImage: (image) {
                    checkOutFormProvider.addHydraulicFluidForBucketImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateHydraulicFluidForBucketImage(image);
                  },
                  comments: checkOutFormProvider.hydraulicFluidForBucketComments,
                  report: checkOutFormProvider.hydraulicFluidForBucket,
                  updateReport: (report) {
                    checkOutFormProvider.updateHydraulicFluidForBucket(report);
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
                  images: checkOutFormProvider.fiberReelRackImages,
                  addImage: (image) {
                    checkOutFormProvider.addFiberReelRackImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateFiberReelRackImage(image);
                  },
                  comments: checkOutFormProvider.fiberReelRackComments,
                  report: checkOutFormProvider.fiberReelRack,
                  updateReport: (report) {
                    checkOutFormProvider.updateFiberReelRack(report);
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
                  images: checkOutFormProvider.binsLockedAndSecureImages,
                  addImage: (image) {
                    checkOutFormProvider.addBinsLockedAndSecureImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateBinsLockedAndSecureImage(image);
                  },
                  comments: checkOutFormProvider.binsLockedAndSecureComments,
                  report: checkOutFormProvider.binsLockedAndSecure,
                  updateReport: (report) {
                    checkOutFormProvider.updateBinsLockedAndSecure(report);
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
                  images: checkOutFormProvider.safetyHarnessImages,
                  addImage: (image) {
                    checkOutFormProvider.addSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateSafetyHarnessImage(image);
                  },
                  comments: checkOutFormProvider.safetyHarnessComments,
                  report: checkOutFormProvider.safetyHarness,
                  updateReport: (report) {
                    checkOutFormProvider.updateSafetyHarness(report);
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
                  images: checkOutFormProvider.lanyardSafetyHarnessImages,
                  addImage: (image) {
                    checkOutFormProvider.addLanyardSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateLanyardSafetyHarnessImage(image);
                  },
                  comments: checkOutFormProvider.lanyardSafetyHarnessComments,
                  report: checkOutFormProvider.lanyardSafetyHarness,
                  updateReport: (report) {
                    checkOutFormProvider.updateLanyardSafetyHarness(report);
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
