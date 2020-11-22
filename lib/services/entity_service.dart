import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/entity.dart';

class EntityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Entities");
  String id;


  EntityService();

  Future updateActivity(String id, String name) async{
    return await ref.doc(id).set({
      'name': name,
    });
  }

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

  deleteEntity(Entity entity) async {
    await FirebaseFirestore.instance.collection('Entities').doc(entity.id).delete();
  }
  
  void addEntity(String entityname){
    ref.add({'name':entityname});
  }

  void updateEntity(Entity entity) {
    try {
      ref.doc(entity.id)
          .update({'name': entity.name});
    } catch (e) {
      print(e.toString());
    }
  }

}