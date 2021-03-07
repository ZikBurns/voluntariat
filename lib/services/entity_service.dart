import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/entity.dart';

class EntityService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Entities");
  EntityService();

  List<Entity> _EntitiesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Entity(doc.id,doc.get('name')?? '',doc.get('desc')??'',doc.get('image')??'',doc.get('ytlink')??'',doc.get('twitter')??'',doc.get('facebook')??'',doc.get('instagram')??'',doc.get('website')??'',doc.get('maps')??'');
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

  void addEntityMap(Map<String, dynamic> map){
    ref.add(map).then((value){
      ref.doc(value.id).update({'image':null});
    });

  }


  void updateEntity(Entity entity) {
    try {
      ref.doc(entity.id)
          .update({'name': entity.name,'desc':entity.desc,'image':entity.image,'ytlink':entity.ytlink,'twitter':entity.twitter,'facebook':entity.facebook,'instagram':entity.instagram,'website':entity.website,'maps':entity.maps});
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> updateEntityMap(String id,Map<String, dynamic> map, String image) async {
    return await ref.doc(id).set({
      'name': map['name'],
      'desc': map['desc'],
      'ytlink':map['ytlink'],
      'image':image,
      'twitter':map['twitter'],
      'facebook':map['facebook'],
      'instagram':map['instagram'],
      'website':map['website'],
      'maps':map['maps'],
    });
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