import 'package:flutter/material.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';

class EntitiesListSubActivites extends StatefulWidget {
  Entity entity;

  EntitiesListSubActivites(this.entity);

  @override
  _EntitiesListSubActivitesState createState() => _EntitiesListSubActivitesState();
}

class _EntitiesListSubActivitesState extends State<EntitiesListSubActivites> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
        value: ActivityService().activities,
        child: StreamProvider<List<Entity>>.value(
          value: EntityService().entities,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colorizer.typecolor(""),
                title: new Text(widget.entity.name),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    Flexible(
                      child: EntitiesListSubActivitiesResults(widget.entity),
                    )
                  ],
                ),
              ),
          ),
        )
    );
  }
}
