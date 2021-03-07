

import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';

class CommonFunctions{

  static List<String> IDsToNames(List<String> idlist,List<Entity> entitylist) {
    List<String> namelist = [];
    for (var i = 0; i < entitylist.length; i++) {
      for (var j = 0; j < idlist.length; j++) {
        if (idlist[j] == entitylist[i].id) namelist.add(entitylist[i].name);
      }
    }
    return namelist;
  }

  static String toStringLowerCaseNoEntities(Activity act){
    return act.title.toLowerCase() +
        act.desc.toLowerCase() +
        act.place.toLowerCase() +
        act.schedule.toLowerCase() +
        act.type.toString().toLowerCase();
  }
  static String toStringLowerCaseComplete(Activity act,List<Entity> entitylist){
    List<String> entitiesinactivity =
    CommonFunctions.IDsToNames(act.entities,entitylist);
    return act.title.toLowerCase() +
        act.desc.toLowerCase() +
        act.place.toLowerCase() +
        act.schedule.toLowerCase() +
        entitiesinactivity.toString().toLowerCase() +
        act.type.toString().toLowerCase();
  }


  static List<Activity> sortActivityPrimes(List<Activity> activities)
  {
    activities.sort((a, b) {
      if (b.prime)
        return 1;
      else
        return -1;
    });
    activities.sort((a, b) {
      if (b.prime)
        return 1;
      else
        return -1;
    });
    return activities;
  }

  static List<Activity> applyActivityFilters(List<Activity> activities,String filter, String filtermode)
  {
    if (filter != "") {
      activities = activities
          .where((activity) => activity.type == filter)
          .toList();
    }
    if (filtermode != "") {
      activities = activities
          .where((activity) => activity.mode == filtermode)
          .toList();
    }
    return activities;
  }
  static List<Activity> deleteHiddenActivities(List<Activity> activities)
  {
    activities=activities
        .where((activity) => activity.visible)
        .toList();
    var now = new DateTime.now();
    activities=activities
        .where((activity) => activity.visibleDate.isAfter(now))
        .toList();
    return activities;
  }
}