import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';

import 'entities_list.dart';


class Entities extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<Entities> {
  TextEditingController controller = TextEditingController();

  //It's Future because we are promising that a String will be returned
  Future<String> NewEntityDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          controller = TextEditingController();
          return AlertDialog(
            title: Text("Introdueix el nom de la entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                onPressed: (){
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Afegir"),
              )
            ],
          );
        }
    );
  }




  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Entity>>.value(
        value: EntityService().entities,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Entities"),
          ),
          body: Container(
            color: Colors.black12,
            child: Column(
              children: [
                Flexible(
                  child: EntitiesList(),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            NewEntityDialog(context).then((onValue){
              if ((onValue!=null)&&(onValue.isNotEmpty)) EntityService().addEntity(onValue);
            });
          },
            child: Icon(Icons.add,color:Colors.white,size: 30),
            backgroundColor: Colors.green,
          ),
        )
    );



  }
}
