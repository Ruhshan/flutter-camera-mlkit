

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_camera_mlkit/utils/camera_utils.dart';

import 'camera_event.dart';
import 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraUtils cameraUtils;
  final ResolutionPreset resolutionPreset;
  final CameraLensDirection cameraLensDirection;

  late CameraController _controller;

  CameraBloc({
    required this.cameraUtils,
    this.resolutionPreset = ResolutionPreset.low,
    this.cameraLensDirection = CameraLensDirection.front,
  }) : super(CameraInitial()){
    on<CameraInitialized>((event, emit)=>_mapCameraInitializedToState(event, emit));
  }

  CameraController getController() => _controller;

  bool isInitialized() => _controller.value.isInitialized ?? false;



  void _mapCameraInitializedToState(CameraInitialized event, Emitter<CameraState> emit) async {
    try {
      _controller = await cameraUtils
          .getCameraController(resolutionPreset, cameraLensDirection);
      await _controller.initialize();
      emit(CameraReady());
    } on CameraException catch (error) {
      _controller.dispose();
      emit(CameraFailure(error: error.description.toString()));
    } catch (error) {
      emit(CameraFailure(error: error.toString()));
    }
  }

  // Stream<CameraState> _mapCameraCapturedToState(CameraCaptured event) async* {
  //   if(state is CameraReady){
  //     yield CameraCaptureInProgress();
  //     try {
  //       final path = await cameraUtils.getPath();
  //       await _controller.takePicture(path);
  //       yield CameraCaptureSuccess(path);
  //     } on CameraException catch (error) {
  //       yield CameraCaptureFailure(error: error.description);
  //     }
  //   }
  // }

  Stream<CameraState> _mapCameraStoppedToState(CameraStopped event) async* {
    _controller.dispose();
    yield CameraInitial();
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}