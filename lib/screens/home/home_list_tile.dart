import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../details/details_view.dart';
import 'package:flutter_firestore/data/activity.dart';

class HomeListTile extends StatefulWidget {
  final Activity activity;
  HomeListTile({this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {

  passData(Activity act){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(act)));
  }

  @override
  Widget build(BuildContext context) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/icon_image.png"),
          ),
          onTap: () {
            passData(widget.activity);
          },
          title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
          subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
        ),
      );
  }
}