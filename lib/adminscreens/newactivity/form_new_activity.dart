
import 'package:flutter_firestore/adminscreens/newactivity/form_elements.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormNewActivity extends StatefulWidget {
  @override
  _FormNewActivityState createState() => _FormNewActivityState();
}

class _FormNewActivityState extends State<FormNewActivity> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Entity>>.value(
      value: EntityService().entities,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: FormBuilder(
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  FormElements(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Crear"
                              ""),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              ActivityService().addActivityMap(_fbKey.currentState.value);
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
      ),
    );
  }
}
