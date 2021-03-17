import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/commons/activities/details_body.dart';
import 'package:flutter_firestore/commons/colors/colorizer.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/activities/present_entities.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:linkable/linkable.dart';
import 'package:transparent_image/transparent_image.dart';


class DetailsPage extends StatefulWidget {
  Activity activity;
  DetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var foregroundColor;

  Widget primeAppBar(){
    foregroundColor= Colorizer.typecolor(widget.activity.type).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
    if(widget.activity.prime){
      return AppBar(
        iconTheme: IconThemeData(
          color: foregroundColor, //change your color here
        ),
        backgroundColor: Colorizer.typecolor(widget.activity.type),
        title: Text(widget.activity.title,style:TextStyle(color: foregroundColor)),
      );
    }
    else{
      return AppBar(
          iconTheme: IconThemeData(
            color: foregroundColor, //change your color here
          ),
          backgroundColor: Colorizer.typecolor(widget.activity.type),
          title: Text(widget.activity.title,style:TextStyle(color: foregroundColor))
      );
    }
  }

  Widget build(BuildContext context) {

    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: StreamProvider<List<Entity>>.value(
        value: EntityService().entities,
        child: Scaffold(
            appBar:primeAppBar(),
          body: Center(
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                //minWidth: 70,
                //minHeight: 70,
                maxWidth: 1000,
              ),
              child: DetailsBody(widget.activity),
            ),
          ),
        ),
      ),
    );
  }
}
