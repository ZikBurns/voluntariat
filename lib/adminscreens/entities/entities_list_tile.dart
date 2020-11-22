import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';

class EntitiesListTile extends StatefulWidget {
  Entity entity;
  EntitiesListTile({this.entity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntitiesListTile> {
  TextEditingController controller = TextEditingController();

  //It's Future because we are promising that a String will be returned
  Future<String> NewEntityDialog(BuildContext context){
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
      subtitle: Column(
        children: <Widget>[
          Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(widget.entity.id),
                  ),
                  IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      NewEntityDialog(context).then((onValue){
                        if ((onValue!=null)&&(onValue.isNotEmpty)) {
                          widget.entity.name=onValue;
                          EntityService().updateEntity(widget.entity);
                        }
                      });
                    },
                  ),
                  IconButton(icon: Icon(Icons.delete),
                    onPressed: (){
                    //TODO: Show alert dialog instead of deleting directly https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095
                      EntityService().deleteEntity(widget.entity);
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}