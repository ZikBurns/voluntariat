import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'admin_entities_list_tile.dart';


class AdminEntitiesList extends StatefulWidget {
  @override
  _AdminEntitiesListState createState() => _AdminEntitiesListState();
}

class _AdminEntitiesListState extends State<AdminEntitiesList> {
  @override
  Widget build(BuildContext context) {
    var list_entities=Provider.of<List<Entity>>(context) ?? [];
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: StreamProvider<List<Entity>>.value(
          value: EntityService().entities,
          child:ListView.builder(
          itemCount: list_entities.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: AdminEntitiesListTile(list_entities[index]),
              ),
            );
          }
      ),
      ),
    );
  }
}
