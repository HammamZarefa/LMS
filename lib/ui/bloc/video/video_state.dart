import 'package:meta/meta.dart';

@immutable
abstract class VideoState {}

class InitialVideoState extends VideoState {}

class LoadedVideoState extends VideoState {
    LoadedVideoState();
}
