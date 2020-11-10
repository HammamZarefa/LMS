import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/video/bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoScreenArgs {
    final String title;
    final String videoLink;

    VideoScreenArgs(this.title, this.videoLink);
}

class VideoScreen extends StatelessWidget {
    static const routeName = 'videoScreen';
    final VideoBloc _bloc;

    const VideoScreen(this._bloc) : super();

    @override
    Widget build(BuildContext context) {
        final VideoScreenArgs args = ModalRoute.of(context).settings.arguments;

        return BlocProvider<VideoBloc>(
            create: (c) => _bloc, child: _VideoScreenWidget(args.title, args.videoLink)
        );
    }
}

class _VideoScreenWidget extends StatefulWidget {
    final String videoLink;
    final String title;

    const _VideoScreenWidget(this.title, this.videoLink);

    @override
    State<StatefulWidget> createState() {
        return _VideoScreenState();
    }
}

class _VideoScreenState extends State<_VideoScreenWidget> {
    VideoBloc _bloc;
    VideoPlayerController _controller;
    YoutubePlayerController _youtubePlayerController;

    bool video = false;
    bool videoPlayed = false;
    bool videoLoaded = false;

    @override
    void initState() {
        super.initState();
        _bloc = BlocProvider.of<VideoBloc>(context)..add(FetchEvent(widget.title, widget.videoLink));

        var format = widget.videoLink.split(".");
        if(format.last == 'mp4') {
            //http://motors.stylemixthemes.com/landing/motors-landing.mp4

            setState(() {
                video = true;
            });
            _controller = VideoPlayerController.network(widget.videoLink)
                ..setLooping(true)
                ..play()
                ..initialize().then((_) {
                    setState(() {
                        videoLoaded = true;
                    });
                });
        } else if(video == false) {
            //https://www.youtube.com/watch?v=wGtDvLkVvaQ
            String videoId = YoutubePlayer.convertUrlToId(widget.videoLink);
            if(videoId != "") {
                _youtubePlayerController = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: YoutubePlayerFlags(
                        autoPlay: true,
                    ),
                );
            }
        }
    }

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<VideoBloc, VideoState>(
            bloc: _bloc,
            builder: (context, state) {
                return Scaffold(
                    backgroundColor: HexColor.fromHex("#000000"),
                    appBar: AppBar(
                        backgroundColor: HexColor.fromHex("#000000"),
                        automaticallyImplyLeading: false,
                        title: Text(
                            widget.title,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                            )
                        ),
                        actions: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top:8.0, bottom: 8.0, right: 15.0),
                                child: SizedBox(
                                    width: 42,
                                    height: 30,
                                    child: FlatButton(
                                        onPressed: () {
                                            Navigator.of(context).pop(true);
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                        ),
                                    ),
                                ),
                            )
                        ]
                    ),
                    body: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: _buildBody(state),
                    ),
                );
            },
        );
    }

    _buildBody(state) {
        if (state is LoadedVideoState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    loadPlayer(),
                ]
            );
        }

        if (state is InitialVideoState) {
            return Center(
                child: CircularProgressIndicator(),
            );
        }
    }

    loadPlayer() {
        if(video) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Center(
                        child: _controller.value.initialized
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                    ),
                                    SizedBox(
                                        width: 42,
                                        height: 30,
                                        child: FlatButton(
                                            onPressed: () {
                                                setState(() {
                                                    _controller.value.isPlaying
                                                        ? _controller.pause()
                                                        : _controller.play();
                                                });
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            color: HexColor.fromHex("#000000"),
                                            child: Icon(
                                                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                                    color: HexColor.fromHex("#FFFFFF"),
                                                    size: 24.0,
                                            ),
                                        )
                                    )
                                ]
                            )
                            : SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                        ),
                    ),
                ],
            );
        } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Center(
                        child: YoutubePlayer(
                            controller: _youtubePlayerController,
                            showVideoProgressIndicator: true,
                            actionsPadding: EdgeInsets.only(left: 16.0),
                            bottomActions: [
                                CurrentPosition(),
                                SizedBox(width: 10.0),
                                ProgressBar(isExpanded: true),
                                SizedBox(width: 10.0),
                                RemainingDuration(),
                                FullScreenButton(),
                            ],
                            onReady: () {
                            }
                        ),
                    )
                ],
            );
        }
    }

    @override
    void dispose() {
        super.dispose();
        _controller.dispose();
        _youtubePlayerController.dispose();
    }
}