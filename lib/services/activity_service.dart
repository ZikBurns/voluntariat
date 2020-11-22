import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firestore/data/activity.dart';

class ActivityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Activities");
  ActivityService();

  Future updateActivity(String id, String title, String desc) async{
    return await ref.doc(id).set({
      'title': title,
      'desc': desc,
    });
  }

  List<Activity> _ActivitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      print(doc.id+doc.get('title')+doc.get('desc'));
      return Activity(doc.id,doc.get('title')?? '', doc.get('desc')?? '');
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