import 'package:flutter/material.dart';
import 'package:flutter_camera_mlkit/camera_preview.dart';
import 'package:flutter_camera_mlkit/input_image.dart';

import 'flutter_camera_mlkit_platform_interface.dart';

class FlutterCameraMlkit {
  Future<String?> getPlatformVersion() {
    return FlutterCameraMlkitPlatform.instance.getPlatformVersion();
  }


  Future<String?> processImage(InputImage inputImage){
    return FlutterCameraMlkitPlatform.instance.processImage(inputImage);
  }

  Widget getCameraPreview(){
    return FaceView(this);
  }
}
