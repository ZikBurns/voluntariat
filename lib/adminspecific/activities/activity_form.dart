
import 'package:flutter_firestore/adminspecific/activities/activity_form_fields.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
    return StreamProvider<List<Entity>>.value(
      initialData: [],
      value: EntityService().entities,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Formulari"),
          backgroundColor: Colors.green,
        ),
        body: FormBuilder(
          initialValue:
          widget.activity==null?
          {
            'releasedays':30,
            'visible': false,
            'prime': false,
          }
          :
          {
            'title': widget.activity.title,
            'desc': widget.activity.desc,
            'contact':widget.activity.contact,
            'place':widget.activity.place,
            'schedule':widget.activity.schedule,
            'type':widget.activity.type,
            'launchdate':widget.activity.launchDate,
            'releasedays':widget.activity.releasedays,
            'visibledate':widget.activity.visibleDate,
            'startdate': widget.activity.startDate,
            'finaldate': widget.activity.finalDate,
            'visible': widget.activity.visible,
            'prime': widget.activity.prime,
            'mode':widget.activity.mode
          },
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  ActivityFormFields(activity:widget.activity),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text(Strings.textEnviar),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              if(widget.activity==null)ActivityService().addActivityMap(_fbKey.currentState.value);
                              else ActivityService().updateActivityMap(widget.activity.id,_fbKey.currentState.value, widget.activity.image);
                              Navigator.pop(context);
                              if(widget.activity!=null) Navigator.pop(context);
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

