import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/activities/activity_details.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firestore/data/admin.dart'as admin;
import 'package:flutter_firestore/utils/colorizer.dart';

class ActivityListTile extends StatefulWidget {
  final Activity activity;
  ActivityListTile({this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<ActivityListTile> {


  passData(Activity activity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityDetails(activity)));
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

  offVisibility(){
    if(widget.activity.visible){
      widget.activity.visible=false;
      ActivityService().updateActivity(widget.activity);
    }
  }

  switchVisibility(){
    if(widget.activity.visible) widget.activity.visible=false;
    else widget.activity.visible=true;
    ActivityService().updateActivity(widget.activity);
  }

  Icon visibilityIcon(){
    if(widget.activity.visible) return Icon(Icons.visibility);
    else return Icon(Icons.visibility_off);
  }

  void showVisibilityMessage(bool expired)
  {
    if(widget.activity.visible && !expired){
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
    }
    else if (!widget.activity.visible && !expired){
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
    }
    else{
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
    }
  }


  @override
  Widget build(BuildContext context) {
    var now= new DateTime.now();
    bool expired= widget.activity.visibleDate.isBefore(now);
    if(expired) offVisibility();
      if (widget.activity.prime) {
        return Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(1.0),
            ),
            border: Border.all(
              color: Colors.blueGrey,
              width: 0.3,
            ),
          ),
          child: ListTile(
            tileColor: Colorizer.typecolor(widget.activity.type),
            leading: Colorizer.showAvatarPrime(widget.activity),
            onTap: () {
              passData(widget.activity);
            },
            trailing: admin.isLoggedIn?IconButton(
              icon: visibilityIcon(),
              onPressed: (){
                if (!expired) switchVisibility();
                showVisibilityMessage(expired);
              },
            ):Padding(padding: EdgeInsets.all(0.0)),
            //isThreeLine: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  //maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.campaign_outlined,
                          size: 22,
                        ),
                      ),
                      TextSpan(text:"Destacat: ",
                        style: TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RichText(
                  //maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      WidgetSpan(child: modeicon(widget.activity.mode)),
                      TextSpan(text:" " + widget.activity.title,
                        style: TextStyle(fontSize: 18.0,color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Text(widget.activity.desc,
                maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
        );
      } else {
        print("ANDREEEEEEEEEEEEEEEEEEEEEEEEEEEEEU");
        return Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(1.0),
            ),
            border: Border.all(
              color: Colors.blueGrey,
              width: 0.3,
            ),
          ),
          child: ListTile(
            tileColor: Color(0xFFF5F6F9),
            leading: Colorizer.showAvatar(widget.activity),
            onTap: () {
              passData(widget.activity);
            },
            trailing: admin.isLoggedIn?IconButton(
              icon: visibilityIcon(),
              onPressed: (){
                if (!expired) switchVisibility();
                showVisibilityMessage(expired);
              },
            ):Padding(padding: EdgeInsets.all(0.0)),
            //isThreeLine: true,
            title: RichText(
              //maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  WidgetSpan(child: modeicon(widget.activity.mode)),
                  TextSpan(text:" " + widget.activity.title,
                    style: TextStyle(fontSize: 18.0,color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            subtitle: Text(widget.activity.desc,
                maxLines: 3, overflow: TextOverflow.ellipsis),
            //trailing: getPrimeIcon(),
          ),
        );
    }
  }
}







