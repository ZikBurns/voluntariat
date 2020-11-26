


import 'package:firebase_auth/firebase_auth.dart';

class SignInService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}