

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/feed.dart';

class FeedbackService{
  CollectionReference ref = FirebaseFirestore.instance.collection("Feedback");

  List<Feed> _feedFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      print(doc.id);
      print(doc.get('title'));
      print(doc.get('desc'));
      return Feed(
        doc.id,
          doc.get('title')?? '',
          doc.get('desc')?? '');
    }).toList();
  }

  // get brews stream
  Stream<List<Feed>> get feedback {
    return ref.snapshots()
        .map(_feedFromSnapshot);
  }
  deleteFeed(Feed feed) async {
    await ref.doc(feed.id).delete();
  }

}