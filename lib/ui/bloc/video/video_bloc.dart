import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';

import './bloc.dart';

@provide
class VideoBloc extends Bloc<VideoEvent, VideoState> {

    VideoBloc();

    @override
    VideoState get initialState => InitialVideoState();

    @override
    Stream<VideoState> mapEventToState(
        VideoEvent event,
        ) async* { yield LoadedVideoState(); }
}
