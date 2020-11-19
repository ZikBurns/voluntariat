


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';

class AdminHomeListTile extends StatefulWidget {
  DocumentSnapshot snapshot;
  AdminHomeListTile({this.snapshot});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminHomeListTile> {


  passData(DocumentSnapshot snap){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDetailsPage(snap)));
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
