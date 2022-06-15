import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/camera/camera_bloc.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';
import 'package:flutter_camera_mlkit/util.dart';
import 'package:flutter_camera_mlkit/utils/camera_utils.dart';


class FaceView extends StatefulWidget{
  final FlutterCameraMlkit flutterCameraMlkit;

  const FaceView(this.flutterCameraMlkit);

  @override
  _FaceViewState createState() => _FaceViewState();

}

class _FaceViewState extends State<FaceView>{
  @override
  void initState() {
    super.initState();
  }



  // void processCameraImage(CameraImage image, List<CameraDescription> cameras) async {
  //
  //   final inputImage = convertImage(image, cameras);
  //
  //   String res = await widget.flutterCameraMlkit.processImage(inputImage) ?? "";
  //   _inSide = this.isInside(res, _circleRect);
  //
  //   setState((){
  //     _result = "Face:"+res+"\n"+"Circle: "+_circleRect.toString();
  //
  //   });
  //
  // }


  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => CameraBloc(cameraUtils: CameraUtils()),
        child: ,

      );
  }
  
}

