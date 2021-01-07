

import 'package:flutter/material.dart';
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
  List<Entity> entitylist=[];
  List<dynamic> listOfIDs=[];

  List<String> EntitiesToNames(List<Entity> entitylist){
    List<String> namelist = [];
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
            Text('Titol',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              attribute: 'title',
              readOnly: false,
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if(val=="") return "L'activitat ha de tenir un titol.";
                }
                 */
              ],
            ),
            SizedBox(height: 20),
            Text('Descripcio',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              attribute: 'desc',
              readOnly: false,
              validators: [],
            ),
            SizedBox(height: 20),
            //* ----------------------------------------------------
            //* CHECKBOX GROUP
            //* ----------------------------------------------------
            Text('Entitat/s',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderCheckboxGroup(
              //TODO: initialvalue is assigned with [] first because the data has not yet arrived from the cloud and therefore cannot be assigned again. Find a way to make it work. Ideal option: make a loading button until Stream Provider has everything.
              initialValue: initialcheckedentities,
              attribute: 'entities',
              options:
              namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
                }
                */
              ],
              valueTransformer: (val)=>
              List<dynamic>.from(NamestoIDs(List<String>.from(val))),
            ),
            SizedBox(height: 20),
            //* ----------------------------------------------------
            //* CHECKBOX GROUP
            //* ----------------------------------------------------
            Text('Tipus',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderDropdown(
              hint: Text('Selecciona un tipus'),
              attribute: 'type',
              items: ['Participaci'+String.fromCharCode($oacute)+' comunit'+String.fromCharCode($agrave)+'ria',String.fromCharCode($Egrave)+'xit educatiu', 'Fam'+String.fromCharCode($iacute)+'lies', 'Joves', 'Igualtat d\'oportunitats', 'Altres']
                  .map((type) =>
                  DropdownMenuItem(value: type, child: Text("$type")))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text('Dates',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderDateTimePicker(
              attribute: 'startdate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data d\'inici',
              ),
            ),
            FormBuilderDateTimePicker(
              attribute: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data final',
              ),
            ),
            FormBuilderDateTimePicker(
              attribute: 'visibledate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data fins la que l\'activitat serà visible',
              ),
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data de caducitat";
                }
                */
              ],
            ),
            SizedBox(height: 20),
            Text('Lloc/s',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              attribute: 'place',
              readOnly: false,
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if(val=="") return "L'activitat ha de tenir un lloc.";
                }
                */

              ],
            ),
            Text('Horari',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              attribute: 'schedule',
              readOnly: false,
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if(val=="") return "L'activitat ha de tenir un horari.";
                }
                */
              ],
            ),
            SizedBox(height: 20),
            Text('Contacte',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              attribute: 'contact',
              readOnly: false,
              validators: [
                FormBuilderValidators.required(),
                /*
                    (val){
                  if(val=="") return "L'activitat ha de tenir un contacte.";
                }
                */
              ],
            ),
            SizedBox(height: 20),
            Text('Visibilitat',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderCheckbox(
              attribute: 'visible',
              label: Text('Vols que l\'activitat sigui visible?'),
            ),
            FormBuilderCheckbox(
              attribute: 'prime',
              label: Text('Vols que l\'activitat sigui destacada?'),
            ),
          ],
        ),
      ),
    );
  }
}
