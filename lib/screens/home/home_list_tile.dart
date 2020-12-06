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
  Widget getPrimeIcon() {
    if(widget.activity.prime) return Icon(Icons.error_outline);
  }

  CircleAvatar showAvatar(String type){
    switch(type) {
      case 'Èxit educatiu': {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.amber,
          child: Icon(Icons.local_library_rounded, color: Colors.white),
          //backgroundImage: AssetImage("assets/icon_image.png"),
        );
      }break;
      case 'Joves': {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.red,
          child: Icon(Icons.face_rounded, color: Colors.white),
        );
      }break;
      case 'Famílies': {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.family_restroom, color: Colors.white),
        );
      }break;
      case 'Igualtat d\'oportunitats': {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.green,
          child: Icon(Icons.all_inclusive_rounded, color: Colors.white),
        );
      }break;
      case 'Participació comunitària': {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.group, color: Colors.white),
        );
      }break;
      default: {
        return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.white,
        );
      }break;
    }
  }


  @override
  Widget build(BuildContext context) {
      return ListTile(
          leading: showAvatar(widget.activity.type),
          onTap: () {
            passData(widget.activity);
          },
          //isThreeLine: true,
          title:Text(widget.activity.title,style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
          subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
          trailing: getPrimeIcon(),
      );
  }
}