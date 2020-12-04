import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:provider/provider.dart';
import 'admin_home_list_tile.dart';


class AdminHomeList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AdminHomeList> {


  @override
  Widget build(BuildContext context) {
    final list_activities = Provider.of<List<Activity>>(context) ?? [];
    return ListView.builder(
        itemCount: list_activities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
              child: AdminHomeListTile(activity: list_activities[index]),
          );
        }
    );
  }
}