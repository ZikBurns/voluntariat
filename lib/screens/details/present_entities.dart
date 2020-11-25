

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';

class PresentEntities extends StatefulWidget {
  @override
  Activity activity;
  PresentEntities(this.activity);
  _PresentEntitiesState createState() => _PresentEntitiesState();
}

class _PresentEntitiesState extends State<PresentEntities> {

  String presentEntities(List<Entity> entities){
    if ((entities!=null)&&(entities.length>0)){
      String text="";
      for (var i=0; i<entities.length; i++) {
        for (var j = 0; j < widget.activity.entities.length; j++) {
          if(entities[i].id==widget.activity.entities[j])text = text +entities[i].name+ "\n";
        }
      }
        return text.substring(0,text.length-1);
      }
    else if(entities.length==0)return "";
    else return "No hi ha entitats assignades";
  }


  @override
  Widget build(BuildContext context) {
    List<Entity> entitylist=Provider.of<List<Entity>>(context) ?? [];
    return ListTile(
        title: Text("Entitats",style: Theme.of(context).textTheme.headline5),
        subtitle: SelectableText(presentEntities(entitylist)),
    );
  }
}
