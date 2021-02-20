import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/entities/entities_list_sublist.dart';
import 'package:flutter_firestore/screens/entities/entities_list_sublist_web.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EntitiesListTile extends StatefulWidget {
  Entity entity;
  EntitiesListTile({this.entity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntitiesListTile> {
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    if (kIsWeb){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EntitiesListSubActivitesWeb(entity)));
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EntitiesListSubActivites(entity)));
    }
  }


  //It's Future because we are promising that a String will be returned
  Future<String> UpdateEntityDialog(BuildContext context){

    return showDialog(
        context: context,
        builder: (context){
          controller = TextEditingController();
          controller.text=widget.entity.name;
          return AlertDialog(
            title: Text("Modifica el nom de la entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Modificar"),
              )
            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    list_activities = list_activities
        .where((activity) => activity.entities.contains(widget.entity.id))
        .toList();
    return ListTile(
      title:Text(widget.entity.name+" ("+list_activities.length.toString()+")",style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
      subtitle: Container(
          child: Row(
            children: [
              Expanded(child: Text(widget.entity.desc)),
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
                  child: FadeInImage.memoryNetwork  (
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
    );
  }
}