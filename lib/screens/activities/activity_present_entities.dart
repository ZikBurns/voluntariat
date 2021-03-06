import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/entities/entity_list_tile.dart';
import 'package:provider/provider.dart';

class PresentEntities extends StatelessWidget {
  @override
  Activity activity;
  PresentEntities(this.activity);

  List<Entity> presentEntities(List<Entity> entities) {
    List<Entity> newlist=[];
    if ((entities != null) && (entities.length > 0)) {
      for (var i = 0; i < entities.length; i++) {
        for (var j = 0; j < this.activity.entities.length; j++) {
          if (entities[i].id == this.activity.entities[j])
            newlist.add(new Entity(entities[i].id,entities[i].name,entities[i].desc,entities[i].image,entities[i].ytlink,entities[i].twitter,entities[i].facebook,entities[i].instagram,entities[i].website,entities[i].maps,entities[i].contact,entities[i].tasks,entities[i].color));
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
                    child: EntityListTile(listfinal[index]),
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
