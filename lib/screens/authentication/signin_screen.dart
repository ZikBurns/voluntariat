

import 'package:flutter/material.dart';
import 'package:flutter_firestore/screens/main/home.dart';
import 'package:flutter_firestore/services/signin_service.dart';
import 'package:flutter_firestore/data/admin.dart'as admin;
import 'package:flutter_firestore/utils/strings.dart';

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
        title: Text(Strings.signTitle),
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
                  key: Key("SignInScreen_email"),
                  decoration: new InputDecoration(hintText: Strings.signHintCorreu),
                  validator: (val) => val.isEmpty ? Strings.signEnterCorreu : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  key: Key("SignInScreen_password"),
                  obscureText: true,
                  decoration: new InputDecoration(hintText: Strings.signHintContra),
                  validator: (val) =>
                  val.length < 6
                      ? Strings.signEnterContra
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    key: Key("SignInScreen_send"),
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)) ,
                    child: Text(
                      Strings.textEntrar,
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
                            error = Strings.signError;
                          });
                        }
                        else{
                          admin.isLoggedIn = true;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
