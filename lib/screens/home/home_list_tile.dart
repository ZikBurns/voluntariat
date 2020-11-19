


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/details_view.dart';

class HomeListTile extends StatefulWidget {
  DocumentSnapshot snapshot;
  HomeListTile({this.snapshot});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {


  passData(DocumentSnapshot snap){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(snap)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        passData(widget.snapshot);
      },
      title:Text(widget.snapshot["title"],style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
      subtitle: Text(widget.snapshot["desc"], maxLines: 3,),
    );
  }
}
