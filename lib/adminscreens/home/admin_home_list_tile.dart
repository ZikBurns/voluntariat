import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


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

  Widget getPrimeIcon()
  {
    if (widget.activity.prime) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              tooltip: 'Destacat',
              color: Colorizer.typecolor(widget.activity.type),
              highlightColor: Colorizer.typecolor(widget.activity.type),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Es necessiten voluntaris urgentment:"),
                        content:
                        Text("Les activitats destacades tenen un megàfon."),
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
                    });
              },
              icon: new Icon(
                Icons.campaign_outlined,
                color: Colorizer.typecolor(widget.activity.type),
                size: kIsWeb ? 26.0 : 26.0,
              ),
            ),
          ],
        ),
      );
    }
  }

  Icon modeicon(String mode){
    if (mode=="Presencial"){
      return new Icon(
        Icons.accessibility_new_rounded,
        size: 20,
      );
    }
    else if(mode=="Virtual"){
      return new Icon(
        Icons.desktop_windows,
        size: 20,
      );
    }
    else{
      return new Icon(
        Icons.shuffle,
        size: 20,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    var now= new DateTime.now();
    bool expired= widget.activity.visibleDate.isBefore(now);
    if((widget.activity.visible)&&(!expired)){
      if (widget.activity.prime) {
        return ListTile(
          tileColor: Colorizer.typecolor(widget.activity.type),
          leading: Colorizer.showAvatarPrime(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
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
          //isThreeLine: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Icon(
                  Icons.campaign_outlined,
                  size: 22,
                ),
                new Text(
                  "Destacat: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ]),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  modeicon(widget.activity.mode),
                  new Text(" " + widget.activity.title + " ",
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      } else {
        return ListTile(
          leading: Colorizer.showAvatar(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
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
          //isThreeLine: true,
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              modeicon(widget.activity.mode),
              new Text(" " + widget.activity.title + " ",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      }
    }
    else if((!widget.activity.visible)&&(!expired)){
      if (widget.activity.prime) {
        return ListTile(
          tileColor: Colorizer.typecolor(widget.activity.type),
          leading: Colorizer.showAvatarPrime(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
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
          //isThreeLine: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Icon(
                  Icons.campaign_outlined,
                  size: 22,
                ),
                new Text(
                  "Destacat: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ]),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  modeicon(widget.activity.mode),
                  new Text(" " + widget.activity.title + " ",
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      } else {
        return ListTile(
          leading: Colorizer.showAvatar(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
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
          //isThreeLine: true,
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              modeicon(widget.activity.mode),
              new Text(" " + widget.activity.title + " ",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      }
    }
    else{
      if (widget.activity.prime) {
        return ListTile(
          tileColor: Colorizer.typecolor(widget.activity.type),
          leading: Colorizer.showAvatarPrime(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
          //isThreeLine: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Icon(
                  Icons.campaign_outlined,
                  size: 22,
                ),
                new Text(
                  "Destacat: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ]),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  modeicon(widget.activity.mode),
                  new Text(" " + widget.activity.title + " ",
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      } else {
        widget.activity.visible=false;
        ActivityService().updateActivity(widget.activity);
        return ListTile(
          leading: Colorizer.showAvatar(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
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
          //isThreeLine: true,
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              modeicon(widget.activity.mode),
              new Text(" " + widget.activity.title + " ",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          /*Text(widget.activity.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis),*/
          subtitle: Text(widget.activity.desc,
              maxLines: 3, overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
        );
      }

    }
  }
}







