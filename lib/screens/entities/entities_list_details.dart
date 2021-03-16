import 'package:flutter/material.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/colors/colorizer.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/entities/socialnetworks.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/entities/video_screen.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/entities/entities_list_sublist_results.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';



class EntitiesListSubActivites extends StatefulWidget {
  Entity entity;

  EntitiesListSubActivites(this.entity);

  @override
  _EntitiesListSubActivitesState createState() => _EntitiesListSubActivitesState();
}

class _EntitiesListSubActivitesState extends State<EntitiesListSubActivites> {
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
                            child: VideoScreen(widget.entity.ytlink),
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
              );
    }



  }
}
