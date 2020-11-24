import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/entity.dart';

class EntityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Entities");
  EntityService();

  List<Entity> _EntitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      print(doc.data);
      return Entity(doc.id,doc.get('name')?? '');
    }).toList();
  }

  // get brews stream
  Stream<List<Entity>> get entities {
    return ref.snapshots()
        .map(_EntitiesFromSnapshot);
  }

  Stream<QuerySnapshot> getsnapshots(){
    return ref.snapshots();
  }

  deleteEntity(Entity entity) async {
    await FirebaseFirestore.instance.collection('Entities').doc(entity.id).delete();
  }
  
  void addEntity(String entityname){
    ref.doc(entityname).set({'name':entityname});
  }

  void updateEntity(Entity entity) {
    try {
      ref.doc(entity.id)
          .update({'name': entity.name});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> listOfNamesEntity() async {
    List<String> endlist = new List();
    final QuerySnapshot result = await ref.get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data){
        print(data['name']);
        endlist.add(data['name']);
    });
    print(endlist);
    return endlist;
  }



}