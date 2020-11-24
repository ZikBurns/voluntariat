import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../data/activity.dart';

class DetailsPage extends StatefulWidget {
  Activity activity;
  DetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
            ListTile(
                title: Text("Tipus",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.type)
            ),
            Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),
            ListTile(
                title: Text("Dates",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText("Data d\'inici: "+widget.activity.startDate.day.toString()+"/"+widget.activity.startDate.month.toString()+"/"+widget.activity.startDate.year.toString()+"\n"+
                    "Data final: "+widget.activity.finalDate.day.toString()+"/"+widget.activity.finalDate.month.toString()+"/"+widget.activity.finalDate.year.toString()+"\n")
            ),
          ]
      ),
    );
  }
}
