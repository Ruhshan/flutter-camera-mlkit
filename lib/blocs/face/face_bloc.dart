

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_event.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_state.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';

class FaceBloc extends Bloc<FaceEvent, FaceState>{
  final CameraController cameraController;
  final FlutterCameraMlkit flutterCameraMlkit;

  FaceBloc({required this.cameraController, required this.flutterCameraMlkit}):
        super(FaceInial());

}