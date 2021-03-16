import 'package:flutter/foundation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';

class VideoScreen extends StatefulWidget {
  String videolink;
  VideoScreen(this.videolink);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _YTcontroller;

  @override
  void initState() {
    _YTcontroller = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.videolink),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _YTcontroller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _YTcontroller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _YTcontroller.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      log('Exited Fullscreen');
    };
    super.initState();
  }

  void dispose() {
    _YTcontroller.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: YoutubePlayerControllerProvider(
          controller: _YTcontroller,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return player;
            },
          ),
        ),
      ),
    );
  }
}

