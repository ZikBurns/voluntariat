import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/screens/entities/entities_list_tile.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
class PresentEntities extends StatefulWidget {
  @override
  Activity activity;
  PresentEntities(this.activity);
  _PresentEntitiesState createState() => _PresentEntitiesState();
}

class _PresentEntitiesState extends State<PresentEntities> {
  List<Entity> presentEntities(List<Entity> entities) {
    List<Entity> newlist=[];
    if ((entities != null) && (entities.length > 0)) {
      String text = "";
      for (var i = 0; i < entities.length; i++) {
        for (var j = 0; j < widget.activity.entities.length; j++) {
          if (entities[i].id == widget.activity.entities[j])
            newlist.add(new Entity(entities[i].id,entities[i].name));
            //text = text + entities[i].name + "\n";
        }
      }
      return newlist;
    } else if (entities.length == 0)
      return null;
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Entity> entitylist = Provider.of<List<Entity>>(context) ?? [];
    List<Entity> listfinal=presentEntities(entitylist);
    if ((entitylist != null) && (entitylist.length > 0)) {
      return Container(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listfinal.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Card(
                    shape: new RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.black87, width: 2.0),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: EntitiesListTile(entity: listfinal[index]),
                  ),
                );
              })
      );
    }
    else{
      return Container(
        child: Text("")
      );
    }

  }
}
