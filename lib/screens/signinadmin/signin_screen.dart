

import 'package:flutter/material.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/main/admin_home.dart';
import 'package:flutter_firestore/services/signin_service.dart';
import 'package:flutter_firestore/data/admin.dart'as admin;
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
                  validator: (val) => val.isEmpty ? 'Introdueix un email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(hintText: 'contrasenya'),
                  validator: (val) =>
                  val.length < 6
                      ? 'La contasenya ha de tenir mes de 6 caracters'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)) ,
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _authservice
                            .signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'No s\' ha pogut iniciar sessio';
                          });
                        }
                        else{
                          admin.isLoggedIn = true;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
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
