import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;
import 'package:flutter_firestore/adminscreens/home/admin_home_list_tile.dart';

class SearchResultList extends StatefulWidget {
  final String searchtext;
  final String filter;

  SearchResultList(this.searchtext,this.filter);

  @override
  _State createState() => _State();
}

class _State extends State<SearchResultList> {
  List<Entity> entitylist=[];

  List<String> IDsToNames(List<String> idlist){
    List<String> namelist=[];
    for (var i=0; i<entitylist.length; i++) {
      for (var j=0; j<idlist.length; j++) {
        if (idlist[j] == entitylist[i].id) namelist.add(entitylist[i].name);
      }
    }
    return namelist;
  }

  Color typecolor(String type){
    switch(type) {
      case 'Èxit educatiu': {
        return Colors.amber;
      }break;
      case 'Joves': {
        return Colors.red;
      }break;
      case 'Famílies': {
        return Colors.lightBlue;
      }break;
      case 'Igualtat d\'oportunitats': {
        return Colors.green;
      }break;
      case 'Participació comunitària': {
        return Colors.deepOrange;
      }break;
      default: {
        return Colors.black38;
      }break;
    }
  }

  @override
  Widget build(BuildContext context) {
    entitylist= Provider.of<List<Entity>>(context) ?? [];
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    List<Activity> _resultsList=[];
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    if(widget.filter!="") {
      list_activities = list_activities.where((activity) => activity.type==widget.filter).toList();
    }

    if((widget.searchtext!=null)&&(widget.searchtext != "")) {
      _resultsList=[];
      for(var activity in list_activities){
        List<String> entitiesinactivity=IDsToNames(activity.entities);
        var act=activity.title.toLowerCase()+
            activity.desc.toLowerCase()+
            activity.place.toLowerCase()+
            activity.schedule.toLowerCase()+
            entitiesinactivity.toString().toLowerCase()+
            activity.type.toString().toLowerCase();
        if(act.contains(widget.searchtext.toLowerCase())) {
          _resultsList.add(activity);
        }
      }
      list_activities=_resultsList;
    }
    return ListView.builder(
        itemCount: list_activities.length,
        itemBuilder: (context,index){
          var now= new DateTime.now();
          bool expired= list_activities[index].visibleDate.isBefore(now);
          if((!admin.isLoggedIn)&&(!list_activities[index].visible)) return Container();
          else if((!admin.isLoggedIn)&&(list_activities[index].visible)){
            if((!expired)&&(list_activities[index].prime)){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                    shape: new RoundedRectangleBorder(
                        side: new BorderSide(color: typecolor(list_activities[index].type), width: 4.0),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: HomeListTile(activity: list_activities[index])
                ),
              );
            }
            else if((!expired)&&(!list_activities[index].prime)){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(child: HomeListTile(activity: list_activities[index])),
              );
            }
            else return Container();
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                  shape: list_activities[index].prime
                      ?new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.red, width: 4.0),
                      borderRadius: BorderRadius.circular(4.0))
                      : new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: AdminHomeListTile(activity: list_activities[index])
              ),
            );
          }
        }
    );


  }
}
