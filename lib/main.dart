import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/main/admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminHomePage(),
      theme: ThemeData(
          //primaryColor: Colors.black38
      ),
    );
  }
}

