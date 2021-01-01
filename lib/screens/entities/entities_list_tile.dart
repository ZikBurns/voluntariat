import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist.dart';

class EntitiesListTile extends StatefulWidget {
  Entity entity;
  EntitiesListTile({this.entity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntitiesListTile> {
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EntitiesListSubActivites(entity)));
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
              FlatButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
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
    return ListTile(
      title:Text(widget.entity.name,style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
      onTap: (){
        passData(widget.entity);
      },
    );
  }
}