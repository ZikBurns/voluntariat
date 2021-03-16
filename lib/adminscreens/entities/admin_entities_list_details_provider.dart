import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list_details.dart';
import 'package:flutter_firestore/commonscreeens/entities/entities_list_sublist_results.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';

class AdminEntitiesListSublistProvider extends StatefulWidget {
  Entity entity;
  AdminEntitiesListSublistProvider(this.entity);

  @override
  _AdminEntitiesListSublistProviderState createState() =>
      _AdminEntitiesListSublistProviderState();
}

class _AdminEntitiesListSublistProviderState
    extends State<AdminEntitiesListSublistProvider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<List<Activity>>.value(
        value: ActivityService().activities,
        child: StreamProvider<List<Entity>>.value(
          value: EntityService().entities,
          child: AdminEntitiesListSubActivites(widget.entity),
        ),
      ),
    );
  }
}
