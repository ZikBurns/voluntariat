import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';

import 'entities_list.dart';


class Entities extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<Entities> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Entity>>.value(
        value: EntityService().entities,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Entities"),
          ),
          body: Container(
            color: Colors.black12,
            child: Column(
              children: [
                Flexible(
                  child: EntitiesList(),
                )
              ],
            ),
          ),
        )
    );



  }
}
