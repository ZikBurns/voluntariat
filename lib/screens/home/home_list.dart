import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';

class HomeList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeList> {

  @override
  Widget build(BuildContext context) {
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
      return ListView.builder(
          itemCount: list_activities.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: HomeListTile(activity: list_activities[index]),
              ),
            );
          }
      );


  }
}
