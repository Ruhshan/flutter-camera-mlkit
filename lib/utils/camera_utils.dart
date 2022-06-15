import 'package:camera/camera.dart';

class CameraUtils {
  late CameraDescription camera;

  Future<CameraController> getCameraController(
      ResolutionPreset resolutionPreset,
      CameraLensDirection cameraLensDirection) async {
    final cameras = await availableCameras();
    camera = cameras
        .firstWhere((camera) => camera.lensDirection == cameraLensDirection);

    return CameraController(camera, resolutionPreset, enableAudio: false);

  }

  CameraDescription getCamera(){
    return camera;
  }

}