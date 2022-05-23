import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_camera_mlkit_platform_interface.dart';

/// An implementation of [FlutterCameraMlkitPlatform] that uses method channels.
class MethodChannelFlutterCameraMlkit extends FlutterCameraMlkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_camera_mlkit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
