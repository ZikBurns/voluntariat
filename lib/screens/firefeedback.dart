import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class FireFeedback extends StatelessWidget{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback"),
        ),
        body: FormBuilder(
          initialValue:
              {
                'title': "",
                'desc': "",
              },
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text('Omple el següent formulari per donar el teu feedback als desenvolupadors de la APP.\n',
                              style: TextStyle(fontSize: 15, color: Colors.black)),
                          Text('Assumpte',
                            style: TextStyle(fontSize: 20, color: Colors.black)),
                            FormBuilderTextField(
                            maxLines: 1,
                            obscureText: false,
                            name: 'title',
                            readOnly: false,
                            validator: FormBuilderValidators.compose([
                            (val){
                              if(val=="") return "El feedback ha de tenir un assumpte.";
                            }
                        ]),
                        ),
                          SizedBox(height: 20),
                          Text('Cos del missatge',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                          //* ----------------------------------------------------
                          //* TEXT INPUT
                          //* ----------------------------------------------------
                          FormBuilderTextField(
                            maxLines: 8,
                            obscureText: false,
                            name: 'desc',
                            readOnly: false,
                            validator:FormBuilderValidators.compose( [
                                  (val){
                                if(val=="") return "El feedback ha de tenir un cos.";
                              }
                            ]),
                          ),
                      ]
                        ),
                    ),
              ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Crear"
                              ""),
                          onPressed: (){
                            if(_fbKey.currentState.saveAndValidate()){
                              CollectionReference ref = FirebaseFirestore.instance.collection("Feedback");
                              ref.add(_fbKey.currentState.value);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 4),
                                    content: Row(
                                      children: [
                                        Icon(Icons.assignment_turned_in_outlined),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Text('Feedback enviat'),
                                        )
                                      ],
                                    ),
                                  )
                              );
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
