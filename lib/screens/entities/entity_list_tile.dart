import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/entities/entity_details.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EntityListTile extends StatefulWidget {
  Entity entity;
  EntityListTile(this.entity);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntityListTile> {
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEntityDetails(entity)));
  }

  @override
  Widget build(BuildContext context) {
    var listActivities=Provider.of<List<Activity>>(context) ?? [];
    listActivities = listActivities
        .where((activity) => activity.entities.contains(widget.entity.id))
        .toList();
    listActivities.removeWhere((element) => element.visible==false);
    var now = new DateTime.now();
    listActivities.removeWhere((element) => element.visibleDate.isBefore(now));

    return StreamProvider<List<Activity>>.value(
      initialData: [],
      value: ActivityService().activities,
      child: Container(
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
          title:Text(widget.entity.name+" ("+listActivities.length.toString()+")",style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
          subtitle: Text(widget.entity.desc,maxLines: 3, overflow: TextOverflow.ellipsis),
          onTap: (){
            passData(widget.entity);
          },
          //Text(list_activities.length.toString(),style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
          trailing: Container(
            child: widget.entity.image!=""
                ? CircleAvatar(
                radius: 25.0,
                child: AspectRatio(
                    aspectRatio: 1/1,
                    child: ClipOval(
                      child:FadeInImage.memoryNetwork  (
                        width: 100,
                        height: 100,
                        placeholder: kTransparentImage,
                        image:widget.entity.image,
                        fit: BoxFit.cover,
                      ),
                    )
                )
            )
                : CircleAvatar(
              backgroundColor: Color(widget.entity.color),
            ),
          ),
        ),
      ),
    );
  }
}