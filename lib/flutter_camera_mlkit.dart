import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_mlkit/camera_preview.dart';
import 'package:flutter_camera_mlkit/input_image.dart';
import 'package:flutter_camera_mlkit/utils/camera_utils.dart';

import 'blocs/camera/camera_bloc.dart';
import 'flutter_camera_mlkit_platform_interface.dart';

class FlutterCameraMlkit {
  Future<String?> getPlatformVersion() {
    return FlutterCameraMlkitPlatform.instance.getPlatformVersion();
  }


  Future<String?> processImage(InputImage inputImage){
    return FlutterCameraMlkitPlatform.instance.processImage(inputImage);
  }

  Widget getCameraPreview(){
    return BlocProvider(
        create: (context) => CameraBloc(cameraUtils: CameraUtils()),
        child: FaceView(this)
    );
  }
}
