import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/adminscreens/details/modify_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/details/present_entities.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:linkable/linkable.dart';
import 'package:provider/provider.dart';
class AdminDetailsPage extends StatefulWidget {
  Activity activity;
  AdminDetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<AdminDetailsPage> {



  Widget build(BuildContext context) {
    return StreamProvider<List<Entity>>.value(
      value: EntityService().entities,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.activity.title),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Image(
                    alignment: Alignment(-.2, 0),
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png"),
                    fit: BoxFit.cover),
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              ListTile(
                title: Text("Descripcio",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.desc)
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              PresentEntities(widget.activity),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              ListTile(
                  title: Text("Tipus",style: Theme.of(context).textTheme.headline5),
                  subtitle: SelectableText(widget.activity.type)
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              ListTile(
                  title: Text("Dates",style: Theme.of(context).textTheme.headline5),
                  subtitle: SelectableText("Data d\'inici: "+widget.activity.startDate.day.toString()+"/"+widget.activity.startDate.month.toString()+"/"+widget.activity.startDate.year.toString()+"\n"+
                                              "Data final: "+widget.activity.finalDate.day.toString()+"/"+widget.activity.finalDate.month.toString()+"/"+widget.activity.finalDate.year.toString())
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              ListTile(
                  title: Text("Lloc",style: Theme.of(context).textTheme.headline5),
                  subtitle: SelectableText(widget.activity.place)
              ),
              ListTile(
                  title: Text("Horari",style: Theme.of(context).textTheme.headline5),
                  subtitle: SelectableText(widget.activity.schedule)
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
              ListTile(
                  title: Text("Contacte",style: Theme.of(context).textTheme.headline5),
                  subtitle: Linkable(
                    text: widget.activity.contact,
                  )
              ),
            ]
          ),
        floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "editactivitybutton",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=> ModifyActivity(widget.activity)));
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
      ),
    );
  }
}