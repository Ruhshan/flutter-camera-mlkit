import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit_platform_interface.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCameraMlkitPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterCameraMlkitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCameraMlkitPlatform initialPlatform = FlutterCameraMlkitPlatform.instance;

  test('$MethodChannelFlutterCameraMlkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCameraMlkit>());
  });

  test('getPlatformVersion', () async {
    FlutterCameraMlkit flutterCameraMlkitPlugin = FlutterCameraMlkit();
    MockFlutterCameraMlkitPlatform fakePlatform = MockFlutterCameraMlkitPlatform();
    FlutterCameraMlkitPlatform.instance = fakePlatform;
  
    expect(await flutterCameraMlkitPlugin.getPlatformVersion(), '42');
  });
}
