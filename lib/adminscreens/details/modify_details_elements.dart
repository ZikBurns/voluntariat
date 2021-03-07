

import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/formcomponents/formcomponents.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import "package:charcode/charcode.dart";


class ModifyActivityElements extends StatefulWidget {
  Activity activity;
  ModifyActivityElements(this.activity);

  @override
  _ModifyActivityElementsState createState() => _ModifyActivityElementsState();
}

class _ModifyActivityElementsState extends State<ModifyActivityElements> {
  List<Entity> entitylist;
  List<dynamic> listOfIDs;

  List<String> EntitiesToNames(List<Entity> entitylist){
    List<String> namelist = new List();
    for (var i=0; i<entitylist.length; i++) {
      namelist.add(entitylist[i].name);
    }
    return namelist;
  }

  List<String> NamestoIDs(List<String> namelist){
    List<String> idlist=[];
    for (var i=0; i<entitylist.length; i++) {
      for (var j=0; j<namelist.length; j++) {
        if (namelist[j] == entitylist[i].name) idlist.add(entitylist[i].id);
      }
    }
    return idlist;
  }

  List<String> IDsToNames(List<String> idlist){
    print(entitylist.length);
    List<String> namelist=[];
    for (var i=0; i<entitylist.length; i++) {
      for (var j=0; j<idlist.length; j++) {
        if (idlist[j] == entitylist[i].id) namelist.add(entitylist[i].name);
      }
    }
    print('hola'+namelist.toString());
    return namelist;
  }


  @override
  Widget build(BuildContext context) {
    entitylist= Provider.of<List<Entity>>(context) ?? [];
    final List<String> namelist = EntitiesToNames(entitylist);
    List<String> initialcheckedentities=IDsToNames(widget.activity.entities);

    return entitylist.length==0 ? CircularProgressIndicator(): Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FormComponents.titleText('Titol'),
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
            FormComponents.titleText('Descripció'),
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
            FormComponents.titleText('Entitat/s'),
            FormBuilderCheckboxGroup(
              //TODO: initialvalue is assigned with [] first because the data has not yet arrived from the cloud and therefore cannot be assigned again. Find a way to make it work. Ideal option: make a loading button until Stream Provider has everything.
              initialValue: initialcheckedentities,
              name: 'entities',
              options:
              namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
              validator: FormBuilderValidators.compose([
                    (val){
                  if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
                }
              ]),
              valueTransformer: (val)=>
              List<dynamic>.from(NamestoIDs(List<String>.from(val))),
            ),
            SizedBox(height: 20),
            FormComponents.titleText('Tipologia'),
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
            FormComponents.titleText('Dates'),
            FormComponents.titledesc('Si hi ha una diferencia de més de 10 anys entre la data de començament i la de final, l\'activitat serà permanent'),
            FormBuilderDateTimePicker(
              name: 'startdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data d\'inici',
              ),
            ),
            FormBuilderDateTimePicker(
              name: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data final',
              ),
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
            FormComponents.titledesc('Dies que l\'activitat serà novetat'),
            FormBuilderTouchSpin(
              name: 'releasedays',
              step: 1,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: 20),
            FormComponents.titleText('Lloc/s'),
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
            FormComponents.titleText('Horari'),

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
            FormComponents.titleText('Contacte'),
            FormBuilderTextField(
              maxLines: 10,
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
            FormComponents.titleText('Visibilitat'),
            FormBuilderCheckbox(
              name: 'visible',
              title: Text('Vols que l\'activitat sigui visible?'),
            ),
            FormComponents.titleText('Destacada'),
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
