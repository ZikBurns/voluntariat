

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/activities/activity_present_entities.dart';
import 'package:linkable/linkable.dart';
import 'package:flutter_firestore/utils/colorizer.dart';
import 'package:transparent_image/transparent_image.dart';

class ActivityDetailsBody extends StatefulWidget {
  Activity activity;
  ActivityDetailsBody(this.activity);
  @override
  _ActivityDetailsBodyState createState() => _ActivityDetailsBodyState();
}

class _ActivityDetailsBodyState extends State<ActivityDetailsBody> {


  @override
  Widget build(BuildContext context) {
    final difference = widget.activity.finalDate.difference(widget.activity.startDate).inDays;
    return Container(
      child: ListView(
          children: <Widget>[
            Container(
              color: Colors.black,
              constraints: BoxConstraints(
                maxHeight: widget.activity.image=="" ?0:300,
              ),
              child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                child: (widget.activity.image!="")
                    ? Stack(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    Center(child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:widget.activity.image,
                    ), )
                  ],
                )
                    : Container(),
              ),
            ),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text("Descripcio",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.desc)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text("Entitats", style: Theme.of(context).textTheme.headline5)),
            PresentEntities(widget.activity),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text("Tipus",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.type)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),

            difference<3650?ListTile(
                title: Text("Dates",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText("Data d\'inici: "+widget.activity.startDate.day.toString()+"/"+widget.activity.startDate.month.toString()+"/"+widget.activity.startDate.year.toString()+"\n"+
                    "Data final: "+widget.activity.finalDate.day.toString()+"/"+widget.activity.finalDate.month.toString()+"/"+widget.activity.finalDate.year.toString())
            ):ListTile(
                title: Text("Dates",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText("Aquesta és una activitat permanent.")
            ),

            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text("Lloc",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.place)
            ),
            ListTile(
                title: Text("Horari",style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(widget.activity.schedule)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text("Contacte",style: Theme.of(context).textTheme.headline5),
                subtitle: Linkable(
                  text: widget.activity.contact,
                )
            ),
            Divider(thickness:2,color: Colorizer.typecolor(widget.activity.type),indent: 20,endIndent:20),
          ]
      ),
    );
  }
}
