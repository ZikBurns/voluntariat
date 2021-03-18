

import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminspecific/entities/entity_form_fields.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NewEntity extends StatefulWidget {

  @override
  _NewEntityState createState() => _NewEntityState();
}

class _NewEntityState extends State<NewEntity> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context) {
    Entity entity = new Entity("", "", "", "", "", "", "", "", "", "",16777215);
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: FormBuilder(
        initialValue:
        {
          'name': "",
          'desc': "",
          'ytlink':"",
          'twitter':"",
          'facebook':"",
          'instagram':"",
          'website':"",
          'maps':"",
          'color': Colors.blueGrey

        },
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children:[
                EntityFormFields(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Enviar"),
                        onPressed: (){
                          if(_fbKey.currentState.saveAndValidate()){
                            EntityService().addEntityMap(_fbKey.currentState.value);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
