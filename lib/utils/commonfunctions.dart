

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screens/entities/video_screen.dart';

class CommonFunctions{

  static Container showMedia(String ytlink, String image) {
    if (ytlink == "" && image != "") {
      return Container(
        color: Colors.black,
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        child: OverflowBox(
            minWidth: 0.0,
            minHeight: 0.0,
            maxWidth: double.infinity,
            child: Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: image,
              ),
            )),
      );
    } else if (ytlink != "") {
      return Container(
        child: VideoScreen(ytlink),
      );
    } else
      return Container();
  }

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

  static List<Activity> applyTypeFilter(List<Activity> activities,String filter)
  {
    if (filter != "") {
      activities = activities
          .where((activity) => activity.type == filter)
          .toList();
    }
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
  static List<Activity> selectNewActivities(List<Activity> activities)
  {
    var now= new DateTime.now();
    activities=activities
        .where((activity) {
          var duration = new Duration(days : activity.releasedays);
          var checknewdate= activity.launchDate.add(duration);
          return checknewdate.isAfter(now);
    })
        .toList();
    return activities;
  }

}