import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home/home.dart';

class Switcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    /*if (user == null){
      return Authenticate();
    } else {*/
    return HomePage();


  }
}