


import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

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
                FormBuilderValidators.required(),
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
            Text('checkboxGroup',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderCheckboxGroup(
              attribute: 'checkboxGroup',
              options:
                listOfEntities.map((e) => FormBuilderFieldOption(value: e)).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
