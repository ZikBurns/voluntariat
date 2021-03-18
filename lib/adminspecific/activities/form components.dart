

import 'package:flutter/material.dart';

class FormComponents{

  static Align titleText(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
  static Align titledesc(String text){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,
          style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

}