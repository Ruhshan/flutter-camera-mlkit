import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';
import 'package:flutter_camera_mlkit/util.dart';


class FaceView extends StatefulWidget{
  final FlutterCameraMlkit flutterCameraMlkit;

  const FaceView(this.flutterCameraMlkit);

  @override
  _FaceViewState createState() => _FaceViewState();

}

class _FaceViewState extends State<FaceView>{
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  String _result = '';
  Rect _circleRect = Rect.fromLTRB(0.0, 0.0, 0.0, 0.0);
  double _circlePos = 300.0;
  bool _inSide = false;

  late Future<void> _setupDone;

  @override
  void initState() {
    super.initState();
    _setupDone = initCamera();
  }

  Future<void> initCamera() async{
    final cameras = await availableCameras();
    final firstCamera = cameras[0];
    controller = CameraController(firstCamera, ResolutionPreset.low);

    await controller.initialize();

    controller.startImageStream((CameraImage image){
          processCameraImage(image, cameras);
    });

  }

  void processCameraImage(CameraImage image, List<CameraDescription> cameras) async {

    final inputImage = convertImage(image, cameras);

    String res = await widget.flutterCameraMlkit.processImage(inputImage) ?? "";
    _inSide = this.isInside(res, _circleRect);

    setState((){
      _result = "Face:"+res+"\n"+"Circle: "+_circleRect.toString();

    });

  }

  bool isInside(String faceRect, Rect ovalRect){
    faceRect = faceRect.substring(11,faceRect.length-1);
    List<String> splitted = faceRect.split(",");
    List<double> faceCords = splitted.map(double.parse).toList();

    Rect faceR = Rect.fromLTRB(faceCords[0], faceCords[1], faceCords[2], faceCords[3]);

    return faceR.left>= ovalRect.left && faceR.right<=ovalRect.right && faceR.top>=ovalRect.top && faceR.bottom<=ovalRect.bottom;

  }

  @override
  Widget build(BuildContext context) {
    this._circleRect = getCircleRect(context, this._circlePos);
    return FutureBuilder<void>(
      future: _setupDone,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return ListView(
            children: <Widget>[

              ClipOval(
                clipper: CameraPreviewClipper(context, this._circlePos),
                child: CameraPreview(controller),
              ),
              Text(_result, textAlign: TextAlign.center),
              Text(_inSide ?"IN":"OUT", textAlign: TextAlign.center,
                style: TextStyle(color: _inSide ? Colors.green:Colors.red))
            ],
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  
}

