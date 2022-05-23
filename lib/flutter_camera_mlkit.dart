import 'package:flutter/material.dart';
import 'package:flutter_camera_mlkit/camera_preview.dart';

import 'flutter_camera_mlkit_platform_interface.dart';

class FlutterCameraMlkit {
  Future<String?> getPlatformVersion() {
    return FlutterCameraMlkitPlatform.instance.getPlatformVersion();
  }

  Widget getCameraPreview(){
    return CameraPreview(this);
  }
}
