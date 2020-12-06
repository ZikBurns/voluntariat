
import 'package:flutter_firestore/adminscreens/details/modify_details_elements.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:charcode/charcode.dart";


class ModifyActivity extends StatefulWidget {
  Activity activity;
  ModifyActivity(this.activity);

  @override
  _ModifyActivityState createState() => _ModifyActivityState();
}

class _ModifyActivityState extends State<ModifyActivity> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    print(widget.activity.entities);
    return StreamProvider<List<Entity>>.value(
      value: EntityService().entities,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: FormBuilder(
          initialValue:
          {
            'title': widget.activity.title,
            'desc': widget.activity.desc,
            'contact':widget.activity.contact,
            'place':widget.activity.place,
            'schedule':widget.activity.schedule,
            'type':widget.activity.type,
            'visibledate':widget.activity.visibleDate,
            'startdate': widget.activity.startDate,
            'finaldate': widget.activity.finalDate,
            'visible': widget.activity.visible,
            'prime': widget.activity.prime,
          },
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  ModifyActivityElements(widget.activity),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Enviar"),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              ActivityService().updateActivityMap(widget.activity.id,_fbKey.currentState.value);
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
      ),
    );
  }
}

