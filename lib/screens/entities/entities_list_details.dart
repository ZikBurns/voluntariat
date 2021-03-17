import 'package:flutter/material.dart';
import 'package:flutter_firestore/commons/colors/colorizer.dart';
import 'package:flutter_firestore/commons/commonfunctions.dart';
import 'package:flutter_firestore/commons/entities/socialnetworks.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/commons/entities/video_screen.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/commons/entities/entities_list_sublist_results.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EntityDetails extends StatefulWidget {
  Entity entity;

  EntityDetails(this.entity);

  @override
  _EntityDetailsState createState() =>
      _EntityDetailsState();
}

class _EntityDetailsState extends State<EntityDetails> {


  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: StreamProvider<List<Entity>>.value(
        value: EntityService().entities,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(widget.entity.color),
            title: new Text(
              widget.entity.name,
              style: TextStyle(
                  color: Color(widget.entity.color).computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
                color: Color(widget.entity.color).computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white),
          ),
          body: Container(
            color: Colors.black12,
            child: ListView(
              children: [
                CommonFunctions.showMedia(widget.entity.ytlink,widget.entity.image),
                SizedBox(height: 20),
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
