import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class FormElements extends StatelessWidget {
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
            Text('Descripció',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              attribute: 'desc',
              readOnly: false,
              validators: [
                    (val){
                  if(val=="") return "L'activitat ha de tenir una descripció.";
                }
              ],
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
                namelist.map((e) => FormBuilderFieldOption(value: e)).toList(),
              validators: [
                (val){
                  if((val==null)|| (val.length==0)) return "L'activitat ha de tenir al menys una entitat.";
                }
              ],
              valueTransformer: (val)=> val==null ? val : List<dynamic>.from(NamestoIDs(List<String>.from(val))),
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
              items: ['Participació comunitària','Èxit educatiu', 'Famílies', 'Joves', 'Igualtat d\'oportunitats', 'Altres']
                 .map((type) =>
                     DropdownMenuItem(value: type, child: Text("$type")))
                 .toList(),
              validators: [
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir un tipus.";
                }
              ],
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
              validators: [
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data d\'inici";
                }
              ],
            ),
            FormBuilderDateTimePicker(
              attribute: 'finaldate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data final',
              ),
              validators: [
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data final";
                }
              ],
            ),
            FormBuilderDateTimePicker(
              attribute: 'visibledate',
              format: DateFormat('dd-MM-yyyy'),
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Data fins la que l\'activitat serà visible',
              ),
              validators: [
                    (val){
                  if((val==null)|| (val=="")) return "L'activitat ha de tenir una data de caducitat";
                }
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
                    (val){
                  if(val=="") return "L'activitat ha de tenir un lloc.";
                }
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
                    (val){
                  if(val=="") return "L'activitat ha de tenir un horari.";
                }
              ],
            ),
            SizedBox(height: 20),
            Text('Contacte',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 5,
              obscureText: false,
              attribute: 'contact',
              readOnly: false,
              validators: [
                    (val){
                  if(val=="") return "L'activitat ha de tenir un contacte.";
                }
              ],
            ),
            SizedBox(height: 20),
            Text('Visibilitat',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderCheckbox(
              attribute: 'visible',
              label: Text('Vols que l\'activitat sigui visible?'),
            ),
            Text('Destacada',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderCheckbox(
              attribute: 'prime',
              label: Text('Vols que l\'activitat sigui destacada?'),
            )
          ],
        ),
      ),
    );
  }
}
