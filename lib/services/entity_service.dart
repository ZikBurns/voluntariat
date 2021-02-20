import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/entity.dart';

class EntityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Entities");
  EntityService();

  List<Entity> _EntitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Entity(doc.id,doc.get('name')?? '',doc.get('desc')??'',doc.get('image')??'',doc.get('ytlink')??'');
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
  
  void addEntity(Entity entity){
    ref.add({'name': entity.name,'desc':entity.name,'image':entity.image,'ytlink':entity.ytlink});
  }

  void updateEntity(Entity entity) {
    try {
      ref.doc(entity.id)
          .update({'name': entity.name,'desc':entity.desc,'image':entity.image,'ytlink':entity.ytlink});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> listOfNamesEntity() async {
    List<String> endlist = new List();
    final QuerySnapshot result = await ref.get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data){
        endlist.add(data['name']);
    });
    return endlist;
  }



}