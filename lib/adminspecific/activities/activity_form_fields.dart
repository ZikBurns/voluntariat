

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/utils/commonfunctions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ActivityFormFields extends StatefulWidget {
  Activity activity;
  ActivityFormFields({this.activity});

  @override
  _ActivityFormFieldsState createState() => _ActivityFormFieldsState();
}

class _ActivityFormFieldsState extends State<ActivityFormFields> {
  List<Entity> entitylist;

  FormBuilderCheckboxGroup builderCheckbox(){

    final List<String> namelist = CommonFunctions.entitiesToNames(entitylist);
    namelist.sort();
    if(widget.activity!=null){
      List<String> initialcheckedentities=CommonFunctions.iDsToNames(widget.activity.entities,entitylist);
      return FormBuilderCheckboxGroup(
        initialValue: initialcheckedentities,
        name: 'entities',
        options:
        namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
        validator: FormBuilderValidators.compose([
              (val){
            if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
          }
        ]),
        valueTransformer: (val)=> val==null ? val :List<dynamic>.from(CommonFunctions.namestoIDs(List<String>.from(val),entitylist)),
      );
    }
    else{
      return FormBuilderCheckboxGroup(
        name: 'entities',
        options:
        namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
        validator: FormBuilderValidators.compose([
              (val){
            if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
          }
        ]),
        valueTransformer: (val)=> val==null ? val : List<dynamic>.from(CommonFunctions.namestoIDs(List<String>.from(val),entitylist)),
      );
    }
  }

  Align titleText(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
  Align titledesc(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }


  @override
  Widget build(BuildContext context) {
    entitylist= Provider.of<List<Entity>>(context) ?? [];
    FormBuilderCheckboxGroup entitycheckbox=builderCheckbox();

    return entitylist.length==0 ? CircularProgressIndicator(): Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            titleText('Titol'),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'title',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'activitat ha de tenir un titol.";
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText('Descripció'),
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              name: 'desc',
              readOnly: false,
              validator: FormBuilderValidators.compose([(val){
                if(val=="") return "L'activitat ha de tenir una descripció.";
              }]),
            ),
            SizedBox(height: 20),
            titleText('Entitat/s'),
            entitycheckbox,
            SizedBox(height: 20),
            titleText('Tipologia'),
            FormBuilderDropdown(
              hint: Text('Selecciona un tipus'),
              name: 'type',
              items: ['Serveis Sociosanitaris','Atenció i suport a les families','Educació i lleure','Esport','Voluntariat Internacional','Atenció a les necessitats bàsiques','Defensa del mediambient','Joventut','Gent Gran','Protecció dels animals','Cultura']
                  .map((type) =>
                  DropdownMenuItem(value: type, child: Text("$type")))
                  .toList(),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir un tipus.";
                }
              ]),
            ),
            FormBuilderDropdown(
              hint: Text('Selecciona si es presencial, virtual o semipresencial'),
              name: 'mode',
              items: ["Presencial","Virtual","Semipresencial"]
                  .map((type) =>
                  DropdownMenuItem(value: type, child: Text("$type")))
                  .toList(),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de ser presencial, virtual o semipresencial.";
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText('Dates'),
            titledesc('Si hi ha una diferencia de més de 10 anys entre la data de començament i la de final, l\'activitat serà permanent'),
            FormBuilderDateTimePicker(
              name: 'startdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data d\'inici',
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data d\'inici";
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data final',
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data final";
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'visibledate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data fins la que l\'activitat serà visible',
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data de caducitat";
                }
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'launchdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data de llançament',
              ),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data de llantçament";
                }
              ]),
            ),
            SizedBox(height: 20),
            titledesc('Dies que l\'activitat serà novetat'),
            FormBuilderTouchSpin(
              name: 'releasedays',
              step: 1,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            titleText('Lloc/s'),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'place',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'activitat ha de tenir un lloc.";
                }
              ]),
            ),
            titleText('Horari'),
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'schedule',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'activitat ha de tenir un horari.";
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText('Contacte'),
            FormBuilderTextField(
              maxLines: 5,
              obscureText: false,
              name: 'contact',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'activitat ha de tenir un contacte.";
                }
              ]),
            ),
            SizedBox(height: 20),
            titleText('Visibilitat'),
            FormBuilderCheckbox(
              name: 'visible',
              title: Text('Vols que l\'activitat sigui visible?'),
            ),
            titleText('Destacada'),
            FormBuilderCheckbox(
              name: 'prime',
              title: Text('Vols que l\'activitat sigui destacada?'),
            ),
          ],
        ),
      ),
    );
  }
}
