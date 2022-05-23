import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';

class CameraPreview extends StatefulWidget{
  final FlutterCameraMlkit flutterCameraMlkit;

  const CameraPreview(this.flutterCameraMlkit);

  @override
  _CameraPreviewState createState() => _CameraPreviewState();

}

class _CameraPreviewState extends State<CameraPreview>{
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await widget.flutterCameraMlkit.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Running on fuel with state '+_platformVersion);
  }
  
}