import 'package:flutter/material.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/commonscreeens/socialnetworks.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


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
                    backgroundColor: Color(widget.entity.color),
                    title: new Text(widget.entity.name,style: TextStyle(color: Color(widget.entity.color).computeLuminance() > 0.5 ? Colors.black : Colors.white),),
                    centerTitle: true,
                    iconTheme: IconThemeData(
                        color: Color(widget.entity.color).computeLuminance() > 0.5 ? Colors.black : Colors.white
                    ),
                  ),
                  body: Container(
                    color: Colors.black12,
                    child: ListView(
                      children: [
                         widget.entity.image!=""
                                ?
                      Container(
                      color: Colors.black,
                      constraints: BoxConstraints(
                        maxHeight: 300,
                      ),
                      child: OverflowBox(
                          minWidth: 0.0,
                          minHeight: 0.0,
                          maxWidth: double.infinity,
                          child:
                          Center(child: FadeInImage.memoryNetwork  (
                                  placeholder: kTransparentImage,
                                  image:widget.entity.image,
                                ), )
                      ),
                    )
                              :
                            Container(),

                        SizedBox(height:20),
                        ListTile(
                          title: Text(widget.entity.name),
                          subtitle: Text(widget.entity.desc),
                        ),
                        SocialNetworks(widget.entity),
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
                    backgroundColor: Color(widget.entity.color),
                    title: new Text(widget.entity.name,style: TextStyle(color: Color(widget.entity.color).computeLuminance() > 0.5 ? Colors.black : Colors.white),),
                    centerTitle: true,
                    iconTheme: IconThemeData(
                        color: Color(widget.entity.color).computeLuminance() > 0.5 ? Colors.black : Colors.white
                    ),
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
                        SocialNetworks(widget.entity),
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
