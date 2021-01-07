

import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/home/admin_home.dart';
import 'package:flutter_firestore/services/signin_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final SignInService _authservice = SignInService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in Admin'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: new InputDecoration(hintText: 'email'),
                  validator: (val)
                    {
                      if(val==null) return 'Introdueix un email';
                      else if(val.isEmpty) return 'Introdueix un email';
                      else return null;
                    },
                    onChanged: (val) {
                  setState(() => email = val);
                  },
                  ),
                  SizedBox(height: 20.0),
                    TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(hintText: 'contrasenya'),
                  validator: (val) {
                    if(val==null) return 'La contasenya ha de tenir mes de 6 caracters';
                    else if(val.length < 6)return 'La contasenya ha de tenir mes de 6 caracters';
                    else return null;
                  },

                  onChanged: (val) {
                  setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.deepPurple,
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      var state_current =_formKey.currentState;
                      if(state_current!=null) {
                        if ((state_current.validate())) {
                          setState(() => loading = true);
                          dynamic result = await _authservice
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'No s\' ha pogut iniciar sessio';
                            });
                          }
                          else
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => AdminHomePage()));;
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
