import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';

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
    var now= new DateTime.now();
    bool expired= widget.activity.visibleDate.isBefore(now);
    if((widget.activity.visible)&&(!expired)){
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/icon_image.png"),
        ),
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
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/icon_image.png"),
        ),
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
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/icon_image.png"),
        ),
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







