import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_firestore/data/activity.dart';

class Colorizer{


  static Color typecolor(String type){
    switch(type) {
      case 'Serveis Sociosanitaris': {
        return Colors.red;
      }break;
      case 'Atenció i suport a les families': {
        return Colors.deepPurpleAccent;
      }break;
      case 'Educació i lleure': {
        return Colors.lime;
      }break;
      case 'Esport': {
        return Colors.cyanAccent;
      }break;
      case 'Atenció a les necessitats bàsiques': {
        return Colors.pinkAccent;
      }break;
      case 'Voluntariat Internacional': {
        return Colors.greenAccent;
      }break;
      case 'Defensa del mediambient': {
        return Colors.lightGreenAccent;
      }break;
      case 'Joventut': {
        return Colors.deepOrange;
      }break;
      case 'Gent Gran': {
      return Colors.indigo;
    }break;
      case 'Protecció dels animals': {
        return Colors.brown;
      }break;
      case 'Cultura': {
        return Colors.yellow;
      }break;
      default: {
        return Colors.black87;
      }break;
    }
  }


  static CircleAvatar showAvatar(Activity act){
    if(act.image==""){
      switch(act.type) {
        case 'Serveis Sociosanitaris': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.local_hospital, color: Colors.white),
          );
        }break;
        case 'Atenció i suport a les families': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(Icons.family_restroom, color: Colors.white),
          );
        }break;
        case 'Educació i lleure': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lime,
            child: Icon(Icons.local_library, color: Colors.black),
          );
        }break;
        case 'Esport': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.cyanAccent,
            child: Icon(Icons.sports_volleyball, color: Colors.black),
          );
        }break;
        case 'Voluntariat Internacional': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.public, color: Colors.black),
          );
        }break;
        case 'Atenció a les necessitats bàsiques': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pinkAccent,
            child: Icon(Icons.accessibility_new, color: Colors.white),
          );
        }break;
        case 'Defensa del mediambient': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreenAccent,
            child: Icon(Icons.nature, color: Colors.black),
          );
        }break;
        case 'Joventut': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.face, color: Colors.white),
          );
        }break;
        case 'Gent Gran': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.elderly, color: Colors.white),
          );
        }break;
        case 'Protecció dels animals': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
            child: Icon(Icons.pets, color: Colors.white),
          );
        }break;
        case 'Cultura': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.yellow,
            child: Icon(Icons.theater_comedy, color: Colors.black),
          );
        }break;
        default: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black87,
          );
        }break;
      }
    }
    else{
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: typecolor(act.type),
              child: AspectRatio(
                  aspectRatio: 1/1,
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork  (
                      placeholder: kTransparentImage,
                      image:act.image,
                    ),
                  )
              )
          );
      }
    }
  }
