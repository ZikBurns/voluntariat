import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class FormElements extends StatefulWidget {
  @override
  _FormElementsState createState() => _FormElementsState();
}

class _FormElementsState extends State<FormElements> {
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

  @override
  Widget build(BuildContext context) {
    entitylist=Provider.of<List<Entity>>(context) ?? [];
    final List<String> namelist = EntitiesToNames(entitylist);
    namelist.sort();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text('Titol',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Descripció',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              name: 'desc',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'activitat ha de tenir una descripció.";
                }
              ]),
            ),
            SizedBox(height: 20),
            //* ----------------------------------------------------
            //* CHECKBOX GROUP
            //* ----------------------------------------------------
            Align(
              alignment: Alignment.topLeft,
              child: Text('Entitat/s',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderCheckboxGroup(
              name: 'entities',
              options:
                namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
              validator: FormBuilderValidators.compose([
                (val){
                  if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
                }
              ]),
              valueTransformer: (val)=> val==null ? val : List<dynamic>.from(NamestoIDs(List<String>.from(val))),
            ),
            SizedBox(height: 20),
            //* ----------------------------------------------------
            //* CHECKBOX GROUP
            //* ----------------------------------------------------
            Align(
              alignment: Alignment.topLeft,
              child: Text('Tipologia',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Dates',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Si hi ha una diferencia de més de 10 anys entre la data de començament i la de final, l\'activitat serà permanent',
                  style: TextStyle(fontSize: 14, color: Colors.black)),
            ),
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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Lloc/s',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Horari',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Contacte',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
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
            Align(
              alignment: Alignment.topLeft,
              child: Text('Visibilitat',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderCheckbox(
              name: 'visible',
              initialValue: false,
              title: Text('Vols que l\'activitat sigui visible?'),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Destacada',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderCheckbox(
              name: 'prime',
              initialValue: false,
              title: Text('Vols que l\'activitat sigui destacada?'),
            )
          ],
        ),
      ),
    );
  }
}
