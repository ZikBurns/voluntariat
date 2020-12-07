import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:transparent_image/transparent_image.dart';


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
    var now= new DateTime.now();
    bool expired= widget.activity.visibleDate.isBefore(now);
    if((widget.activity.visible)&&(!expired)){
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        leading: showAvatar(widget.activity),
        title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
        trailing: IconButton(
          icon: Icon(Icons.visibility),
          onPressed: (){
            widget.activity.visible=false;
            ActivityService().updateActivity(widget.activity);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Row(
                    children: [
                      Icon(Icons.visibility_off),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text('L\'activitat ja no es visible'),
                      )
                    ],
                  ),
                )
            );
          },
        ),
      );
    }
    else if((!widget.activity.visible)&&(!expired)){
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        leading: showAvatar(widget.activity),
        title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
        trailing: IconButton(
          icon: Icon(Icons.visibility_off),
          onPressed: (){
            widget.activity.visible=true;
            ActivityService().updateActivity(widget.activity);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Row(
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text('L\'activitat ara es visible per tothom'),
                      )
                    ],
                  ),
                )
            );
          },
        ),
      );
    }
    else{
      widget.activity.visible=false;
      ActivityService().updateActivity(widget.activity);
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        leading: showAvatar(widget.activity),
        title:Text(widget.activity.title,style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,),
        trailing: IconButton(
          icon: Icon(Icons.visibility_off),
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 5),
                  content: Row(
                    children: [
                      Icon(Icons.visibility_off),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text('L\'activitat esta configurada per ser visible fins el '+widget.activity.visibleDate.day.toString()+"/"+widget.activity.visibleDate.month.toString()+"/"+widget.activity.visibleDate.year.toString()+"\n"+"Actualitza les dates de l\'activitat per poder fer-la visible."),
                      )
                    ],
                  ),
                )
            );
          },
        ),
      );
    }
  }
}







