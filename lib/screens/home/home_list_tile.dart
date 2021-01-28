import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../details/details_view.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firestore/commonscreeens/colorizer.dart';

class HomeListTile extends StatefulWidget {
  final Activity activity;
  HomeListTile({required this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {

  passData(Activity act){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(act)));
  }

  Widget getPrimeIcon() {
    if(widget.activity.prime){
      return IconButton(
        tooltip: 'Destacat',
        color: Colors.white,
        highlightColor: Colorizer.typecolor(widget.activity.type),
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
          color: Colorizer.typecolor(widget.activity.type),
          size: kIsWeb?26.0:30.0,
        ),
      );
    }
    else return Container();
  }




  @override
  Widget build(BuildContext context) {
      return ListTile(
          leading: Colorizer.showAvatar(widget.activity),
          onTap: () {
            passData(widget.activity);
          },
          //isThreeLine: true,
          title:Text(widget.activity.title,style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis),
          subtitle: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis),
          //trailing: getPrimeIcon(),
      );
  }
}