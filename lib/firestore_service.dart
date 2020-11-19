import 'package:cloud_firestore/cloud_firestore.dart';

class FireService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Activities");
  String id;


  FireService();

  Future updateActivity(String id, String title, String desc) async{
    return await ref.doc(id).set({
      'title': title,
      'desc': desc,
    });
  }

  Stream<QuerySnapshot> get activities {
    return ref.snapshots();
  }
  
}