import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/entities/entities_list_details.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;

class EntitiesListTile extends StatefulWidget {
  Entity entity;
  EntitiesListTile(this.entity);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntitiesListTile> {
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    if(admin.isLoggedIn) Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEntityDetails(entity)));
    else Navigator.push(context, MaterialPageRoute(builder: (context) =>EntityDetails(entity)));
  }

  @override
  Widget build(BuildContext context) {
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    list_activities = list_activities
        .where((activity) => activity.entities.contains(widget.entity.id))
        .toList();
    list_activities.removeWhere((element) => element.visible==false);
    var now = new DateTime.now();
    list_activities.removeWhere((element) => element.visibleDate.isBefore(now));

    return StreamProvider<List<Activity>>.value(
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
          title:Text(widget.entity.name+" ("+list_activities.length.toString()+")",style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
          subtitle: Container(
              child: Row(
                children: [
                  Expanded(child: Text(widget.entity.desc,maxLines: 3, overflow: TextOverflow.ellipsis)),
                ],
              )
          ),
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
                : CircleAvatar(),
          ),
        ),
      ),
    );
  }
}