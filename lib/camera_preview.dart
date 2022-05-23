import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';

class FaceView extends StatefulWidget{
  final FlutterCameraMlkit flutterCameraMlkit;

  const FaceView(this.flutterCameraMlkit);

  @override
  _FaceViewState createState() => _FaceViewState();

}

class _FaceViewState extends State<FaceView>{
  late CameraController controller;
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    initPlatformState();
    initCamera();
  }

  Future<void> initCamera() async{
    final cameras = await availableCameras();
    final firstCamera = cameras[1];
    controller = CameraController(firstCamera, ResolutionPreset.low);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
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
    if (!controller.value.isInitialized) {
      return Container();
    }
    return ClipOval(
      clipper: CameraPreviewClipper(context),
      child: CameraPreview(controller),
    );
  }
  
}

class CameraPreviewClipper extends CustomClipper<Rect> {
  BuildContext _context;
  CameraPreviewClipper(this._context);

  @override
  Rect getClip(Size size) {
    double width = MediaQuery.of(_context).size.width;
    double xPosition = (width/2) ;
    return Rect.fromCircle(center: Offset(xPosition, 200), radius: 150);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}