import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/screens/entities/entities_list_tile.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/colors/colorizer.dart';
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
            newlist.add(new Entity(entities[i].id,entities[i].name,entities[i].desc,entities[i].image,entities[i].ytlink,entities[i].twitter,entities[i].facebook,entities[i].instagram,entities[i].website,entities[i].maps,entities[i].color));
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
                    //shape: Border(right: BorderSide(color: Colors.red, width: 5)),
                    /*shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26, width: 0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),*/
                    elevation: 2,
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
