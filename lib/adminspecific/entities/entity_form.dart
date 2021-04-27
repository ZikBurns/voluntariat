

import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminspecific/entities/entity_form_fields.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ModifyEntity extends StatelessWidget {
  Entity entity;
  ModifyEntity(this.entity);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Formulari"),
          backgroundColor: Colors.green,
        ),
        body: FormBuilder(
          initialValue:
          this.entity==null?
          {
            'name': "",
            'desc': "",
            'ytlink':"",
            'twitter':"",
            'facebook':"",
            'instagram':"",
            'website':"",
            'maps':"",
            'contacts':"",
            'tasks':"",
            'color': Colors.blueGrey
          }
          :{
            'name': this.entity.name,
            'desc': this.entity.desc,
            'ytlink':this.entity.ytlink,
            'twitter':this.entity.twitter,
            'facebook':this.entity.facebook,
            'instagram':this.entity.instagram,
            'website':this.entity.website,
            'maps':this.entity.maps,
            'contacts':this.entity.contact,
            'tasks':this.entity.tasks,
            'color':Color(this.entity.color)
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
                          child: Text(Strings.textEnviar),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              if(this.entity==null) EntityService().addEntityMap(_fbKey.currentState.value);
                              else EntityService().updateEntityMap(this.entity.id,_fbKey.currentState.value, this.entity.image);
                              Navigator.pop(context);
                              if(this.entity!=null) Navigator.pop(context);
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
