import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/screens/details_view.dart';
import 'package:flutter_firestore/data/activity.dart';

class HomeListTile extends StatefulWidget {
  final Activity activity;


  HomeListTile({this.activity});
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
        //passData(widget.snapshot);
      },
      title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
      subtitle: Text(widget.activity.desc, maxLines: 3,),
    );
  }
}
