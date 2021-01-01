import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';

import 'admin_entities_list_tile.dart';


class AdminEntitiesList extends StatefulWidget {
  @override
  _AdminEntitiesListState createState() => _AdminEntitiesListState();
}

class _AdminEntitiesListState extends State<AdminEntitiesList> {
  @override
  Widget build(BuildContext context) {
    final list_entities=Provider.of<List<Entity>>(context) ?? [];
    return ListView.builder(
        itemCount: list_entities.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: AdminEntitiesListTile(entity: list_entities[index]),
            ),
          );
        }
    );
  }
}
