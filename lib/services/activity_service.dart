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
      'startdate':act.startDate,
      'finaldate':act.finalDate,
      'visible':act.visible
    });
  }

  List<Activity> _ActivitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      var entitylist;
      //Firestore returns a List<Dynamic>, we want to transform it to List<String>
      if (doc.get('entities')==null) entitylist=null;
      else entitylist=List<String>.from(doc.get('entities'));
      DateTime startdate = doc.get('startdate')?.toDate();
      print(startdate);
      DateTime finaldate = doc.get('finaldate')?.toDate();
      print(finaldate);
      print(doc.id+doc.get('title')+doc.get('desc'));
      print(doc.get('visible'));
      return Activity(doc.id,doc.get('title')?? '', doc.get('desc')?? '',doc.get('type')?? '',entitylist,startdate,finaldate, doc.get('visible')??false);
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
    ref.add(map);
  }

  deleteActivity(Activity activity) async {
    await FirebaseFirestore.instance.collection('Activities').doc(activity.id).delete();
  }

}