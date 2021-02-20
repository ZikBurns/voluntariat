import 'package:flutter/material.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class EntitiesListSubActivites extends StatefulWidget {
  Entity entity;

  EntitiesListSubActivites(this.entity);

  @override
  _EntitiesListSubActivitesState createState() => _EntitiesListSubActivitesState();
}

class _EntitiesListSubActivitesState extends State<EntitiesListSubActivites> {
  YoutubePlayerController _controller= YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=-FTNbqxCfhA"),
    flags: YoutubePlayerFlags(
      enableCaption: false,
      autoPlay: false,
      isLive: false,
    ),
  );

  void runYoutubePlayer(){
    _controller= YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.entity.ytlink),
      flags: YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: false,
        isLive: false,
      ),
    );
  }

  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  void deactivate(){
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.entity.ytlink=="") {
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
                    child: ListView(
                      children: [
                        Container(
                          child: widget.entity.image!=""
                              ?
                              Center(child: FadeInImage.memoryNetwork  (
                                placeholder: kTransparentImage,
                                image:widget.entity.image,
                              ), )
                            :
                          Container(),
                        ),
                        SizedBox(height:20),
                        ListTile(
                          title: Text(widget.entity.name),
                          subtitle: Text(widget.entity.desc),
                        ),
                        ListTile(
                          title: Text("Activitats de l'entitat:"),
                        ),
                        EntitiesListSubActivitiesResults(widget.entity),
                      ],
                    ),
                  ),
                ),
              ),
            );
    }
    else{
      runYoutubePlayer();
      return YoutubePlayerBuilder(
          player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator:true,
              progressIndicatorColor: Colors.blue,
              progressColors: ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              )
          ),
          builder: (context,player) {
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
                    child: ListView(
                      children: [
                        Container(
                          child: player,
                        ),
                        SizedBox(height:20),
                        ListTile(
                          title: Text(widget.entity.name),
                          subtitle: Text(widget.entity.desc),
                        ),
                        ListTile(
                          title: Text("Activitats de l'entitat:"),
                        ),
                        EntitiesListSubActivitiesResults(widget.entity),

                      ],
                    ),
                  ),
                ),
              ),
            );}
      );
    }



  }
}
