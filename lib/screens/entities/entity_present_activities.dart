import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/utils/commonfunctions.dart';
import 'package:flutter_firestore/utils/colorizer.dart';
import 'package:flutter_firestore/screens/activities/activity_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;

class EntityPresentActivities extends StatefulWidget {
  Entity entity;
  EntityPresentActivities(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<EntityPresentActivities> {

  @override
  Widget build(BuildContext context) {
    List<Entity> entitylist= Provider.of<List<Entity>>(context) ?? [];
    var listActivities=Provider.of<List<Activity>>(context) ?? [];
    List<Activity> _resultsList=null;
    listActivities.sort((a, b) {if(b.prime) return 1; else return -1;});
    listActivities.sort((a, b) {if(b.prime) return 1; else return -1;});

    _resultsList=[];
    for(var activity in listActivities){
      List<String> entitiesinactivity=CommonFunctions.iDsToNames(activity.entities,entitylist);
      for(var entity in entitiesinactivity) {
        if (entity == widget.entity.name) {
          _resultsList.add(activity);
        }
      }
    }
    listActivities=_resultsList;
    if(listActivities.isEmpty){
      return ListTile(
        title: Text("Aquesta entitat encara no té activitats programades."),
      );
    }
    else{
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: listActivities.length+1,
          itemBuilder: (context,index){
            if(index==0){
              return ListTile(
                title: Text("Activitats de l'entitat:"),
              );
            }
            else{
              var now= new DateTime.now();
              bool expired= listActivities[index-1].visibleDate.isBefore(now);
              if((!admin.isLoggedIn)&&(!listActivities[index-1].visible)) return Container();
              else if((!admin.isLoggedIn)&&(listActivities[index-1].visible)){
                if((!expired)&&(listActivities[index-1].prime)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(color: Colorizer.typecolor(listActivities[index-1].type), width: 4.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: ActivityListTile(activity: listActivities[index-1])
                    ),
                  );
                }
                else if((!expired)&&(!listActivities[index-1].prime)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(child: ActivityListTile(activity: listActivities[index-1])),
                  );
                }
                else return Container();
              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      child: ActivityListTile(activity: listActivities[index-1])
                  ),
                );
              }
            }

          }
      );
    }
  }
}
