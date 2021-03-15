

import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/modify_entity_elements.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ModifyEntity extends StatefulWidget {
  Entity entity;
  ModifyEntity(this.entity);

  @override
  _ModifyEntityState createState() => _ModifyEntityState();
}

class _ModifyEntityState extends State<ModifyEntity> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: FormBuilder(
          initialValue:
          {
            'name': widget.entity.name,
            'desc': widget.entity.desc,
            'ytlink':widget.entity.ytlink,
            'twitter':widget.entity.twitter,
            'facebook':widget.entity.facebook,
            'instagram':widget.entity.instagram,
            'website':widget.entity.website,
            'maps':widget.entity.maps,
            'color':Color(widget.entity.color)
          },
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  ModifyEntityElements(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Enviar"),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              EntityService().updateEntityMap(widget.entity.id,_fbKey.currentState.value, widget.entity.image);
                              Navigator.pop(context);
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
