
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

class FormNewActivity extends StatefulWidget {
  @override
  _FormNewActivityState createState() => _FormNewActivityState();
}

class _FormNewActivityState extends State<FormNewActivity> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Widget _buildformfields(){
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
                //* General
                FormBuilderValidators.required(),
                //* Numeric
                // FormBuilderValidators.numeric(),
                // FormBuilderValidators.min(0),
                // FormBuilderValidators.max(100),
                //* Strings
                // FormBuilderValidators.minLength(10),
                // FormBuilderValidators.maxLength(15),
                // FormBuilderValidators.pattern(_emailPattern),
                // FormBuilderValidators.email(),
                // FormBuilderValidators.url(),
                //FormBuilderValidators.IP(),
                // FormBuilderValidators.creditCard(),
                // 4137868152556047 16-digits
                //* Date
                // FormBuilderValidators.date(),
                //* Boolean
                //FormBuilderValidators.requiredTrue(),
                //* Custom validator
                // (val) {
                //   if (val.toLowerCase() != "yes")
                //     return "The answer must be Yes";
                // }
              ],
            ),
            SizedBox(height: 20),
            Text('Descripcio',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            FormBuilderTextField(
              maxLines: 10,
              obscureText: false,
              attribute: 'desc',
              readOnly: false,
              validators: [
                //* General
                // FormBuilderValidators.required(),
                //* Numeric
                // FormBuilderValidators.numeric(),
                // FormBuilderValidators.min(0),
                // FormBuilderValidators.max(100),
                //* Strings
                // FormBuilderValidators.minLength(10),
                // FormBuilderValidators.maxLength(15),
                // FormBuilderValidators.pattern(_emailPattern),
                // FormBuilderValidators.email(),
                // FormBuilderValidators.url(),
                //FormBuilderValidators.IP(),
                // FormBuilderValidators.creditCard(),
                // 4137868152556047 16-digits
                //* Date
                // FormBuilderValidators.date(),
                //* Boolean
                //FormBuilderValidators.requiredTrue(),
                //* Custom validator
                // (val) {
                //   if (val.toLowerCase() != "yes")
                //     return "The answer must be Yes";
                // }
              ],
            ),
          ],
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crea una nova activitat"),
      ),
      body: FormBuilder(
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildformfields(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Crear"),
                        onPressed: (){
                          if(_fbKey.currentState.saveAndValidate()){
                            ActivityService().addActivityMap(_fbKey.currentState.value);
                            Navigator.pop(context);
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
    );
  }
}
