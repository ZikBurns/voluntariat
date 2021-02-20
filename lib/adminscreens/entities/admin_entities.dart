import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'admin_entities_list.dart';


class AdminEntities extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<AdminEntities> {
  TextEditingController controller = TextEditingController();

  //It's Future because we are promising to come back
  Future<String> NewEntityDialog(BuildContext context){
    print("ADEU1232343143");
    return showDialog(
        context: context,
        builder: (context){
          controller = TextEditingController();
          return AlertDialog(
            title: Text("Introdueix el nom de la entitat"),
            content: TextField(
              controller: controller,
              autofocus: true,
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
                AdminEntitiesList()
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(onPressed: (){
            print("ghla");
            NewEntityDialog(context).then((onValue){
              print(onValue);
              if ((onValue!=null)&&(onValue.isNotEmpty)) EntityService().addEntity(new Entity("",onValue,"","",""));
            });
          },
            child: Icon(Icons.add,color:Colors.white,size: 30),
            backgroundColor: Colors.green,
          ),
        )
    );



  }
}
