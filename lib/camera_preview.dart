import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/camera/camera_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_bloc.dart';
import 'package:flutter_camera_mlkit/blocs/face/face_event.dart';
import 'package:flutter_camera_mlkit/flutter_camera_mlkit.dart';
import 'package:flutter_camera_mlkit/util.dart';
import 'package:flutter_camera_mlkit/utils/camera_utils.dart';

import 'blocs/camera/camera_event.dart';
import 'blocs/camera/camera_state.dart';


class FaceView extends StatefulWidget{
  final FlutterCameraMlkit flutterCameraMlkit;

  const FaceView(this.flutterCameraMlkit);

  @override
  _FaceViewState createState() => _FaceViewState();

}

class _FaceViewState extends State<FaceView>{
  late FaceBloc faceBloc;

  @override
  void initState() {
    super.initState();
    final cameraBloc = BlocProvider.of<CameraBloc>(context);
    cameraBloc.add(CameraInitialized());

    faceBloc = FaceBloc(cameraBloc: cameraBloc, flutterCameraMlkit: widget.flutterCameraMlkit);
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
      return BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state){
          if(state is CameraReady){
            faceBloc.add(FaceAnalysisStart());
          }
        },
        builder: (context, state){
          if(state is CameraReady){
            return ClipOval(
              clipper: CameraPreviewClipper(context, 150.0),
              child: CameraPreview(BlocProvider.of<CameraBloc>(context).getController()),
            );
          }
          else if(state is CameraInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is CameraFailure){
            return Text(state.error, textAlign: TextAlign.center);
          }else{
            return Text("Something went wrong", textAlign: TextAlign.center);
          }
        },
      );

  }
  
}

