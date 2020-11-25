import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';
import 'package:flutter_firestore/data/activity.dart';

class AdminHomeListTile extends StatefulWidget {
  final Activity activity;
  AdminHomeListTile({this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminHomeListTile> {


  passData(Activity activity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDetailsPage(activity)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        passData(widget.activity);
      },
      title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2),
      subtitle: Text(widget.activity.desc, maxLines: 3,),
    );
  }
}
