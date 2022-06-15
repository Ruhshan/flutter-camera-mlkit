

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_event.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_state.dart';
import 'package:flutter_camera_mlkit/blocs/camera/camera_bloc.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';
import 'package:flutter_camera_mlkit/util.dart';

class FaceBloc extends Bloc<FaceEvent, FaceState>{
  final FlutterCameraMlkit flutterCameraMlkit;
  final CameraBloc cameraBloc;

  FaceBloc({required this.cameraBloc, required this.flutterCameraMlkit}):
        super(FaceInial()){
    on<FaceAnalysisStart>((event, emit)=>handleStartAnalysisEvent(event, emit));
  }


  void handleStartAnalysisEvent(FaceAnalysisStart event, Emitter<FaceState> emitter) async{

      CameraDescription cameraDescription = cameraBloc.getCamera();

      cameraBloc.getController().startImageStream((CameraImage image){
        processCameraImage(image, cameraDescription);
      });
  }


  void processCameraImage(CameraImage image, CameraDescription camera) async {

    final inputImage = convertImage(image, camera);

    String res = await flutterCameraMlkit.processImage(inputImage) ?? "";

    print(res);

  }

}