import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class ModifyEntityElements extends StatefulWidget {
  @override
  _ModifyEntitiesElementsState createState() => _ModifyEntitiesElementsState();
}

class _ModifyEntitiesElementsState extends State<ModifyEntityElements> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text('Nom',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              maxLines: 1,
              obscureText: false,
              name: 'name',
              readOnly: false,
              validator: FormBuilderValidators.compose([
                    (val){
                  if(val=="") return "L'entitat ha de tenir un nom.";
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
              validator: FormBuilderValidators.compose([(val){
                if(val=="") return "L'entitat ha de tenir una descripció.";
              }]),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Video de YouTube',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              decoration: InputDecoration(
                hintText: "Introdueix el link al video o deixa el camp en blanc"
              ),
              maxLines: 2,
              obscureText: false,
              name: 'ytlink',
              readOnly: false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Pàgina de twitter',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: "Introdueix el link o deixa el camp en blanc"
              ),
              maxLines: 2,
              obscureText: false,
              name: 'twitter',
              readOnly: false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Pàgina de facebook',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            //* ----------------------------------------------------
            //* TEXT INPUT
            //* ----------------------------------------------------
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: "Introdueix el link o deixa el camp en blanc"
              ),
              maxLines: 1,
              obscureText: false,
              name: 'facebook',
              readOnly: false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Pàgina de Instagram',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: "Introdueix el link o deixa el camp en blanc"
              ),
              maxLines: 1,
              obscureText: false,
              name: 'instagram',
              readOnly: false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Pàgina web',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: "Introdueix el link o deixa el camp en blanc"
              ),
              maxLines: 1,
              obscureText: false,
              name: 'website',
              readOnly: false,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Direcció de Google Maps',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            FormBuilderTextField(
              decoration: InputDecoration(
                  hintText: "Introdueix el link o deixa el camp en blanc"
              ),
              maxLines: 1,
              obscureText: false,
              name: 'maps',
              readOnly: false,
            ),
          ],
        ),
      ),
    );
  }
}
