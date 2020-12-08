import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';

class HomeList extends StatefulWidget {
  String filter;
  HomeList(this.filter);
  @override
  _State createState() => _State();
}

class _State extends State<HomeList> {

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
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    if(widget.filter!="") {
      list_activities = list_activities.where((activity) => activity.type==widget.filter).toList();
    }
      return ListView.builder(
          itemCount: list_activities.length,
          itemBuilder: (context,index){
            var now= new DateTime.now();
            bool expired= list_activities[index].visibleDate.isBefore(now);
            if((list_activities[index].visible)&&(!expired)&&(list_activities[index].prime)){
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
            else if((list_activities[index].visible)&&(!expired)&&(!list_activities[index].prime)){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(child: HomeListTile(activity: list_activities[index])),
              );
            }
            else return Container();
          }
      );
    }


  }

