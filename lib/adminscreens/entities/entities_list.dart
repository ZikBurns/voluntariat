import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';

import 'entities_list_tile.dart';


class EntitiesList extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<EntitiesList> {
  @override
  Widget build(BuildContext context) {
    final list_entities=Provider.of<List<Entity>>(context) ?? [];
    return ListView.builder(
        itemCount: list_entities.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: EntitiesListTile(entity: list_entities[index]),
            ),
          );
        }
    );
  }
}
