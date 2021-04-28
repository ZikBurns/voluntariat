import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminspecific/feedback/feedbacklist.dart';
import 'package:flutter_firestore/data/feed.dart';
import 'package:flutter_firestore/services/feedback_service.dart';
import 'package:provider/provider.dart';

class FeedbackAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FeedbackService fs = FeedbackService();
    return StreamProvider<List<Feed>>.value(
      initialData: [],
      value: fs.feedback,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Feedback"),
            backgroundColor: Colors.amber,
          ),
          body: Feedbacklist()
      ),
    );
  }
}
