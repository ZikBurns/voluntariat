import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/activity.dart';

class ActivityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Activities");
  ActivityService();

  Future updateActivity(Activity act) async{
    return await ref.doc(act.id).set({
      'title': act.title,
      'desc': act.desc,
      'type':act.type,
      'entities':act.entities,
      'contact':act.contact,
      'place':act.place,
      'schedule':act.schedule,
      'startdate':act.startDate,
      'finaldate':act.finalDate,
      'visibledate':act.visibleDate,
      'launchdate':act.launchDate,
      'releasedays':act.releasedays,
      'visible':act.visible,
      'prime':act.prime,
      'image':act.image,
      'mode':act.mode
    });
  }
  Future updateActivityMap(String id,Map<String, dynamic> map, String image) async{
    return await ref.doc(id).set({
      'title': map['title'],
      'desc': map['desc'],
      'type':map['type'],
      'contact':map['contact'],
      'place':map['place'],
      'schedule':map['schedule'],
      'entities':map['entities'],
      'startdate':map['startdate'],
      'finaldate':map['finaldate'],
      'visibledate':map['visibledate'],
      'launchdate':map['launchdate'],
      'releasedays':map['releasedays'],
      'visible':map['visible'],
      'prime':map['prime'],
      'image':image,
      'mode':map['mode']
    });
  }

  List<Activity> _ActivitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      var entitylist;
      //Firestore returns a List<Dynamic>, we want to transform it to List<String>
      if (doc.get('entities')==null) entitylist=null;
      else entitylist=List<String>.from(doc.get('entities'));
      DateTime startdate = doc.get('startdate')?.toDate();
      DateTime finaldate = doc.get('finaldate')?.toDate();
      DateTime visibledate = doc.get('visibledate')?.toDate();
      DateTime launchdate = doc.get('launchdate')?.toDate();
      print("hgola"+doc.get('mode').toString()+":");
      print(doc.get('mode').toString());
      Activity act=new Activity(
          doc.id,
          doc.get('title')?? '',
          doc.get('desc')?? '',
          doc.get('type')?? '',
          doc.get('contact')?? '',
          doc.get('place')?? '',
          doc.get('schedule')?? '',
          entitylist,
          startdate,
          finaldate,
          visibledate,
          launchdate,
          doc.get('releasedays')?? '',
          doc.get('visible')??false,
          doc.get('prime')??false,
          doc.get('image')?? '',
          doc.get('mode')??'');
      print(act.title);
      return Activity(
          doc.id,
          doc.get('title')?? '',
          doc.get('desc')?? '',
          doc.get('type')?? '',
          doc.get('contact')?? '',
          doc.get('place')?? '',
          doc.get('schedule')?? '',
          entitylist,
          startdate,
          finaldate,
          visibledate,
          launchdate,
          doc.get('releasedays')?? '',
          doc.get('visible')??false,
          doc.get('prime')??false,
          doc.get('image')?? '',
          doc.get('mode')??'');
    }).toList();
  }

  // get brews stream
  Stream<List<Activity>> get activities {
    return ref.snapshots()
        .map(_ActivitiesFromSnapshot);
  }

  void addActivity(Activity activity){
    ref.add({'tittle':activity.title, 'desc':activity.desc});
  }

  void addActivityMap(Map<String, dynamic> map){
    ref.add(map).then((value){
      ref.doc(value.id).update({'image':null});
      });

  }

  deleteActivity(Activity activity) async {
    await FirebaseFirestore.instance.collection('Activities').doc(activity.id).delete();
  }

}