
import 'package:flutter_firestore/adminspecific/activities/activity_form_fields.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ModifyActivity extends StatelessWidget {
  Activity activity;
  ModifyActivity(this.activity);

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
          this.activity==null?
          {
            'releasedays':30,
            'visible': false,
            'prime': false,
          }
          :
          {
            'title': this.activity.title,
            'desc': this.activity.desc,
            'contact':this.activity.contact,
            'place':this.activity.place,
            'schedule':this.activity.schedule,
            'type':this.activity.type,
            'launchdate':this.activity.launchDate,
            'releasedays':this.activity.releasedays,
            'visibledate':this.activity.visibleDate,
            'startdate': this.activity.startDate,
            'finaldate': this.activity.finalDate,
            'visible': this.activity.visible,
            'prime': this.activity.prime,
            'mode':this.activity.mode
          },
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  ActivityFormFields(activity:this.activity),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text(Strings.textEnviar),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              if(this.activity==null)ActivityService().addActivityMap(_fbKey.currentState.value);
                              else ActivityService().updateActivityMap(this.activity.id,_fbKey.currentState.value, this.activity.image);
                              Navigator.pop(context);
                              if(this.activity!=null) Navigator.pop(context);
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

