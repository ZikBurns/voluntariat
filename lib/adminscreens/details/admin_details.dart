import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
class AdminDetailsPage extends StatefulWidget {
  Activity activity;
  AdminDetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<AdminDetailsPage> {



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.activity.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text("Descripcio",style: Theme.of(context).textTheme.headline5),
              subtitle: SelectableText(widget.activity.desc)
            ),
            Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
            ListTile(
                title: Text("Entitats",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.presentEntities())
            ),
            Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
          ]
        ),
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "editactivitybutton",
          onPressed: () {

          },
          child: Icon(Icons.edit),
          foregroundColor: Colors.white,
        ),
        SizedBox(height: 20),
        FloatingActionButton(
          heroTag: "deleteactivitybutton",
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Estas segur?"),
                      content: Text("Aquesta operació podria afectar altres dades de l'aplicacio"),
                      actions: [
                        FlatButton(
                          child: Text("Cancelar"),
                          onPressed:  () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("Esborrar"),
                          onPressed:  () {
                            ActivityService().deleteActivity(widget.activity);
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        )
                      ],
                    );
                    //Navigator.of(context, rootNavigator: true).pop();
                  }
              );
            },
          child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ],
    ),
    );
  }
}