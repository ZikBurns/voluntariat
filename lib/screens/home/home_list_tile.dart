import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/screens/details/details_view.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firestore/commons/colors/colorizer.dart';

class HomeListTile extends StatefulWidget {
  final Activity activity;
  HomeListTile({this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  passData(Activity act) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsPage(act)));
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
          //trailing: getPrimeIcon(),
        ),
      );
    } else {
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
        ),
      );
    }
  }
}
