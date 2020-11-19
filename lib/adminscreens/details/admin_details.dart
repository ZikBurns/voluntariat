import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminDetailsPage extends StatefulWidget {
  DocumentSnapshot snapshot;
  AdminDetailsPage(this.snapshot);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<AdminDetailsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.snapshot.data()["title"]),

        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(""),
                ),
                IconButton(icon: Icon(Icons.edit),
                  onPressed: (){
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Editar(widget.activity)));
                  },
                ),
                IconButton(icon: Icon(Icons.delete),
                  onPressed: (){
                    //widget.activityService.deleteActivity(widget.activity);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.snapshot.data()["desc"]),
            )
          ],
        )
    );
  }
}