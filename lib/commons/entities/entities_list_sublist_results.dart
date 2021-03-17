import 'package:flutter/material.dart';
import 'package:flutter_firestore/commons/colors/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/main/admin_home_list_tile.dart';

class EntitiesListSubActivitiesResults extends StatefulWidget {
  Entity entity;
  EntitiesListSubActivitiesResults(this.entity);

  @override
  _State createState() => _State();
}

class _State extends State<EntitiesListSubActivitiesResults> {
  List<Entity> entitylist;

  List<String> IDsToNames(List<String> idlist){
    List<String> namelist=[];
    for (var i=0; i<entitylist.length; i++) {
      for (var j=0; j<idlist.length; j++) {
        if (idlist[j] == entitylist[i].id) namelist.add(entitylist[i].name);
      }
    }
    return namelist;
  }


  @override
  Widget build(BuildContext context) {
    entitylist= Provider.of<List<Entity>>(context) ?? [];
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    List<Activity> _resultsList=null;
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});

    _resultsList=[];
    for(var activity in list_activities){
      List<String> entitiesinactivity=IDsToNames(activity.entities);
      for(var entity in entitiesinactivity) {
        if (entity == widget.entity.name) {
          _resultsList.add(activity);
        }
      }
    }
    list_activities=_resultsList;
    if(list_activities.isEmpty){
      return ListTile(
        title: Text("Aquesta entitat encara no té activitats programades."),
      );
    }
    else{
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: list_activities.length+1,
          itemBuilder: (context,index){
            if(index==0){
              return ListTile(
                title: Text("Activitats de l'entitat:"),
              );
            }
            else{
              var now= new DateTime.now();
              bool expired= list_activities[index-1].visibleDate.isBefore(now);
              if((!admin.isLoggedIn)&&(!list_activities[index-1].visible)) return Container();
              else if((!admin.isLoggedIn)&&(list_activities[index-1].visible)){
                if((!expired)&&(list_activities[index-1].prime)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(color: Colorizer.typecolor(list_activities[index-1].type), width: 4.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: AdminHomeListTile(activity: list_activities[index-1])
                    ),
                  );
                }
                else if((!expired)&&(!list_activities[index-1].prime)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(child: AdminHomeListTile(activity: list_activities[index-1])),
                  );
                }
                else return Container();
              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      child: AdminHomeListTile(activity: list_activities[index-1])
                  ),
                );
              }
            }

          }
      );
    }
  }
}
