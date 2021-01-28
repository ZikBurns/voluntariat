import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:provider/provider.dart';
import 'admin_home_list_tile.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';


class AdminHomeList extends StatefulWidget {
  String filter;
  AdminHomeList(this.filter);
  @override
  _State createState() => _State();
}

class _State extends State<AdminHomeList> {

  @override
  Widget build(BuildContext context) {
    var list_activities = Provider.of<List<Activity>>(context) ?? [];
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    if(widget.filter!="") {
      list_activities = list_activities.where((activity) => activity.type==widget.filter).toList();
    }
    return ListView.builder(
        itemCount: list_activities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
              child: Card(
                  shape: list_activities[index].prime
                      ?new RoundedRectangleBorder(
                      side: new BorderSide(color: Colorizer.typecolor(list_activities[index].type), width: 4.0),
                      borderRadius: BorderRadius.circular(4.0))
                      : new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: AdminHomeListTile(activity: list_activities[index])
              ),
          );
        }
    );
  }
}