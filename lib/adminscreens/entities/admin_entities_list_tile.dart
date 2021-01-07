import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist.dart';
import 'package:flutter_firestore/data/activity.dart';


class AdminEntitiesListTile extends StatefulWidget {
  Entity entity;
  AdminEntitiesListTile(this.entity);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminEntitiesListTile> {
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EntitiesListSubActivites(entity)));
  }


  //It's Future because we are promising that a String will be returned
  Future<String?> UpdateEntityDialog(BuildContext context){
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
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
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
                      UpdateEntityDialog(context).then((onValue){
                        if ((onValue!=null)&&(onValue.isNotEmpty)) {
                          widget.entity.name=onValue;
                          EntityService().updateEntity(widget.entity);
                        }
                      });
                    },
                  ),
                  IconButton(icon: Icon(Icons.delete),
                    onPressed: (){

                      //TODO: Check if Entitity has activities
                      var canDelete=true;

                      for(var activity in list_activities){
                        for(var entity in activity.entities) {
                          if (entity == widget.entity.id) canDelete=false;
                        }
                      }

                      if(canDelete) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Estas segur?"),
                                content: Text(
                                    "Aquesta operació podria afectar altres dades de l'aplicacio"),
                                actions: [
                                  FlatButton(
                                    child: Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Esborrar"),
                                    onPressed: () {
                                      EntityService().deleteEntity(
                                          widget.entity);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  )
                                ],
                              );
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("No es pot esborrar l'entitat ja que té activitats assignades"),
                                content: Text(
                                    "Desassigna les activitats d'aquesta entitat o esborra les activitats de l'entitat"),
                                actions: [

                                  FlatButton(
                                    child: Text("Acceptar"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                  ),
                ],
              ))
        ],
      ),
      onTap: (){
        passData(widget.entity);
      },
    );
  }
}