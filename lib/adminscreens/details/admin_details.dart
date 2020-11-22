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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.activity.desc),
            )
          ],
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