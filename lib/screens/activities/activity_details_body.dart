

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/activities/activity_present_entities.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:linkable/linkable.dart';
import 'package:flutter_firestore/utils/colorizer.dart';
import 'package:transparent_image/transparent_image.dart';

class ActivityDetailsBody extends StatelessWidget {
  Activity activity;
  ActivityDetailsBody(this.activity);

  @override
  Widget build(BuildContext context) {
    final difference = this.activity.finalDate.difference(this.activity.startDate).inDays;
    return Container(
      child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              constraints: BoxConstraints(
                maxHeight: this.activity.image=="" ?0:300,
              ),
              child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                child: (this.activity.image!="")
                    ? Stack(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    Center(child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:this.activity.image,
                    ), )
                  ],
                )
                    : Container(),
              ),
            ),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text(Strings.activityDesc,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(this.activity.desc)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text(Strings.activityEnt, style: Theme.of(context).textTheme.headline5)),
            PresentEntities(this.activity),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text(Strings.type,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(this.activity.type)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),

            difference<3650?ListTile(
                title: Text(Strings.activityDates,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(Strings.activityDataInici+": "+this.activity.startDate.day.toString()+"/"+this.activity.startDate.month.toString()+"/"+this.activity.startDate.year.toString()+"\n"+
                    Strings.activityDataFinal+": "+this.activity.finalDate.day.toString()+"/"+this.activity.finalDate.month.toString()+"/"+this.activity.finalDate.year.toString())
            ):ListTile(
                title: Text(Strings.activityDates,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(Strings.activityInfoPerm)
            ),

            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text(Strings.activityLloc,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(this.activity.place)
            ),
            ListTile(
                title: Text(Strings.activityHorari,style: Theme.of(context).textTheme.headline5),
                subtitle: SelectableText(this.activity.schedule)
            ),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
            ListTile(
                title: Text(Strings.activityContacte,style: Theme.of(context).textTheme.headline5),
                subtitle: Linkable(
                  text: this.activity.contact,
                )
            ),
            Divider(thickness:2,color: Colorizer.typecolor(this.activity.type),indent: 20,endIndent:20),
          ]
      ),
    );
  }
}
