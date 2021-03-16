import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:transparent_image/transparent_image.dart';


class EntitiesListSubActivitesWeb extends StatefulWidget {
  Entity entity;

  EntitiesListSubActivitesWeb(this.entity);

  @override
  _EntitiesListSubActivitesWebState createState() => _EntitiesListSubActivitesWebState();
}

class _EntitiesListSubActivitesWebState extends State<EntitiesListSubActivitesWeb> {
  YoutubePlayerController _controller;
  var player = YoutubePlayerIFrame();

  void runYoutubePlayer(){
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId:  YoutubePlayerController.convertUrlToId(widget.entity.ytlink),
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  void initState(){
    runYoutubePlayer();
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        _controller.play();
      });
      Future.delayed(const Duration(seconds: 5), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.entity.ytlink==""){
      return StreamProvider<List<Activity>>.value(
        value: ActivityService().activities,
        child: StreamProvider<List<Entity>>.value(
          value: EntityService().entities,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colorizer.typecolor(""),
              title: new Text(widget.entity.name),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        widget.entity.image!=""
                            ? Stack(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            Center(child: FadeInImage.memoryNetwork  (
                              placeholder: kTransparentImage,
                              image:widget.entity.image,
                            ), )
                          ],
                        ):
                        Container(),
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  ListTile(
                    title: Text(widget.entity.name),
                    subtitle: Text(widget.entity.desc),
                  ),
                  ListTile(
                    title: Text("Activitats de l'entitat:"),
                  ),
                  Flexible(
                    child: EntitiesListSubActivitiesResults(widget.entity),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    else{
      return YoutubePlayerControllerProvider(
        controller: _controller,
        child: StreamProvider<List<Activity>>.value(
          value: ActivityService().activities,
          child: StreamProvider<List<Entity>>.value(
            value: EntityService().entities,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colorizer.typecolor(""),
                title: new Text(widget.entity.name),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          widget.entity.image!=""
                              ? Stack(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(child: CircularProgressIndicator()),
                              ),
                              Center(child: FadeInImage.memoryNetwork  (
                                placeholder: kTransparentImage,
                                image:widget.entity.image,
                              ), )
                            ],
                          ):
                          player,
                        ],
                      ),
                    ),
                    SizedBox(height:20),
                    ListTile(
                      title: Text(widget.entity.name),
                      subtitle: Text(widget.entity.desc),
                    ),
                    ListTile(
                      title: Text("Activitats de l'entitat:"),
                    ),
                    Flexible(
                      child: EntitiesListSubActivitiesResults(widget.entity),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }


  }
}
