import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/details/present_entities.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import '../../data/activity.dart';
import 'package:linkable/linkable.dart';


class DetailsPage extends StatefulWidget {
  Activity activity;
  DetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}


class _DetailsPageState extends State<DetailsPage> {


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
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
            ]
        ),
      ),
    );
  }
}
