import 'package:flutter_camera_mlkit/input_image.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_camera_mlkit_method_channel.dart';

abstract class FlutterCameraMlkitPlatform extends PlatformInterface {
  /// Constructs a FlutterCameraMlkitPlatform.
  FlutterCameraMlkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCameraMlkitPlatform _instance = MethodChannelFlutterCameraMlkit();

  /// The default instance of [FlutterCameraMlkitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCameraMlkit].
  static FlutterCameraMlkitPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCameraMlkitPlatform] when
  /// they register themselves.
  static set instance(FlutterCameraMlkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }



  Future<String?>processImage(InputImage inputImage){
    throw UnimplementedError('processImage() has not been implemented.');
  }
}
