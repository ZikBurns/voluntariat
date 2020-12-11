import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../details/details_view.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  Color typecolor(String type){
    switch(type) {
      case 'Èxit educatiu': {
        return Colors.amber;
      }break;
      case 'Joves': {
        return Colors.red;
      }break;
      case 'Famílies': {
        return Colors.lightBlue;
      }break;
      case 'Igualtat d\'oportunitats': {
        return Colors.green;
      }break;
      case 'Participació comunitària': {
        return Colors.deepOrange;
      }break;
      default: {
        return Colors.white;

      }break;
    }
  }


  Widget getPrimeIcon() {
    if(widget.activity.prime){
      return IconButton(
        tooltip: 'Destacat',
        color: Colors.white,
        highlightColor: typecolor(widget.activity.type),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Es necessiten voluntaris urgentment:"),
                  content: Text("Les activitats destacades tenen el triangle amb exclamació."),
                  actions: <Widget>[
                    TextButton(
                      child: Text('D\'acord'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
                //Navigator.of(context, rootNavigator: true).pop();
              }
          );
        },
        icon: Icon(
          Icons.alarm,
          color: typecolor(widget.activity.type),
          size: kIsWeb?26.0:30.0,
        ),
      );
    }
  }

  CircleAvatar showAvatar(Activity act){
    if(act.image==""){
      switch(act.type) {
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
    else{
      switch(act.type) {
        case 'Èxit educatiu': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.amber,
            child: AspectRatio(
                aspectRatio: 1/1,
              child: ClipOval(
                child: FadeInImage.memoryNetwork  (
                  placeholder: kTransparentImage,
                  image:widget.activity.image,
                ),
              )
            )
          );
        }break;
        case 'Joves': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
              child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:widget.activity.image,
                    ),
                  )
              )
          );
        }break;
        case 'Famílies': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightBlue,
              child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:widget.activity.image,
                    ),
                  )
              )
          );
        }break;
        case 'Igualtat d\'oportunitats': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green,
              child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:widget.activity.image,
                    ),
                  )
              )
          );
        }break;
        case 'Participació comunitària': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepOrange,
              child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:widget.activity.image,
                    ),
                  )
              )
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
  }


  @override
  Widget build(BuildContext context) {
      return ListTile(
          leading: showAvatar(widget.activity),
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