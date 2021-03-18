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
  YoutubePlayerController _ytController;

  @override
  void initState() {
    _ytController = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.videolink),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _ytController.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _ytController.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _ytController.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      log('Exited Fullscreen');
    };
    super.initState();
  }

  void dispose() {
    _ytController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: YoutubePlayerControllerProvider(
          controller: _ytController,
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

