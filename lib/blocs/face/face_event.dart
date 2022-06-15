
import 'package:equatable/equatable.dart';

abstract class FaceEvent extends Equatable{
  const FaceEvent();

  @override
  List<Object> get props => [];
}

class FaceAnalysisStart extends FaceEvent{}

class FaceAnalysisComplete extends FaceEvent{}