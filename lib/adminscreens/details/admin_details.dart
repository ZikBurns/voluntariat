import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/data/activity.dart';

class AdminDetailsPage extends StatefulWidget {
  Activity activity;
  AdminDetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<AdminDetailsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.activity.title),

        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.activity.desc),
            )
          ],
        ),
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "editactivitybutton",
          onPressed: () {

          },
          child: Icon(Icons.edit),
          foregroundColor: Colors.white,
        ),
        SizedBox(height: 20),
        FloatingActionButton(
          heroTag: "deleteactivitybutton",
          onPressed: () {

          },
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ],
    ),
    );
  }
}