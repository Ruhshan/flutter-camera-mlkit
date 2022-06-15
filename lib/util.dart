
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_camera_mlkit/input_image.dart';

import 'package:flutter/material.dart';

class CameraPreviewClipper extends CustomClipper<Rect> {
  BuildContext _context;
  double circlePos;
  CameraPreviewClipper(this._context, this.circlePos);

  @override
  Rect getClip(Size size) {

    return getCircleRect(_context, circlePos);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

InputImage convertImage(CameraImage image, CameraDescription camera){
  final WriteBuffer allBytes = WriteBuffer();
  for (final Plane plane in image.planes) {
    allBytes.putUint8List(plane.bytes);
  }
  final bytes = allBytes.done().buffer.asUint8List();

  final Size imageSize =
  Size(image.width.toDouble(), image.height.toDouble());

  final imageRotation =
      InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
          InputImageRotation.rotation0deg;

  final inputImageFormat =
      InputImageFormatValue.fromRawValue(image.format.raw) ??
          InputImageFormat.nv21;

  final planeData = image.planes.map(
        (Plane plane) {
      return InputImagePlaneMetadata(
        bytesPerRow: plane.bytesPerRow,
        height: plane.height,
        width: plane.width,
      );
    },
  ).toList();

  final inputImageData = InputImageData(
    size: imageSize,
    imageRotation: imageRotation,
    inputImageFormat: inputImageFormat,
    planeData: planeData,
  );

  return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
}

Rect getCircleRect(BuildContext _context, double circlePos){
  double width = MediaQuery.of(_context).size.width;
  double xPosition = (width/2) ;
  Rect r =  Rect.fromCircle(center: Offset(xPosition, circlePos), radius: 150);
  return r;
}