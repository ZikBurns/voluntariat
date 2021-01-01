import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist.dart';
import 'package:flutter_firestore/data/activity.dart';


class AdminEntitiesListTile extends StatefulWidget {
  Entity entity;
  List<Activity> list_activities;
  List<Entity> list_entities;
  AdminEntitiesListTile(this.entity,list_activities,list_entities);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminEntitiesListTile> {
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

  List<String> IDsToNames(List<String> idlist){
    List<String> namelist=[];
    for (var i=0; i<widget.list_entities.length; i++) {
      for (var j=0; j<idlist.length; j++) {
        if (idlist[j] == widget.list_entities[i].id) namelist.add(widget.list_entities[i].name);
      }
    }
    return namelist;
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
                      /*
                      for(var activity in widget.list_activities){
                        List<String> entitiesinactivity=IDsToNames(activity.entities);
                        for(var entity in entitiesinactivity) {
                          if (entity == widget.entity.name) canDelete=false;
                        }
                      }
                      */
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
                                title: Text("Esborra les activitats per poder esborrar l'entitat"),
                                content: Text(
                                    "No es pot esborrar l'entitat ja que té activitats assignades"),
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