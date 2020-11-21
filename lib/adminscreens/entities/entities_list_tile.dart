import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/entities.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';

class EntitiesListTile extends StatefulWidget {
  Entity entity;
  EntitiesListTile({this.entity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<EntitiesListTile> {



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
                      //TODO: Create functionality
                    },
                  ),
                  IconButton(icon: Icon(Icons.delete),
                    onPressed: (){
                    //TODO: Show alert dialog instead of deleting directly https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095
                      EntityService().deleteEntity(widget.entity);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Entities()));
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}