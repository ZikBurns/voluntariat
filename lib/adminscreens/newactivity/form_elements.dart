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

  List<String> EntitiesToNames(List<Entity> entitylist){
    List<String> namelist = new List();
    for (var i=0; i<entitylist.length; i++) {
      namelist.add(entitylist[i].name);
      print(namelist);
    }
    return namelist;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listOfEntities = EntitiesToNames(Provider.of<List<Entity>>(context) ?? []);
    return Container(
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
                (val){
                  if(val=="") return "L'activitat ha de tenir un titol.";
                }
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
              attribute: 'entities',
              options:
                listOfEntities.map((e) => FormBuilderFieldOption(value: e)).toList(),
              validators: [
                (val){
                  if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
                }
              ],
            ),
            SizedBox(height: 20),
            //* ----------------------------------------------------
            //* CHECKBOX GROUP
            //* ----------------------------------------------------
            Text('Entitat/s',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderDropdown(
              hint: Text('Select Gender'),
              attribute: 'type',
              items: ['Participacio comunitaria', 'Exit educatiu', 'Families', 'Joves', 'Igualtat d\'oportunitats', 'Altres']
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
                labelText: 'Dia d\'inici',
              ),
            ),
            FormBuilderDateTimePicker(
              attribute: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Dia final',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
