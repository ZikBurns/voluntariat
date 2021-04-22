import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:transparent_image/transparent_image.dart';

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

  static Icon showIcon(String type){
    switch(type) {
      case 'Serveis Sociosanitaris': {
        return Icon(Icons.local_hospital, color: Colors.black);
      }break;
      case 'Atenció i suport a les families': {
        return Icon(Icons.family_restroom, color: Colors.black);
      }break;
      case 'Educació i lleure': {
        return Icon(Icons.local_library, color: Colors.black);
      }break;
      case 'Esport': {
        return Icon(Icons.sports_volleyball, color: Colors.black);
      }break;
      case 'Voluntariat Internacional': {
        return Icon(Icons.public, color: Colors.black);
      }break;
      case 'Atenció a les necessitats bàsiques': {
        Icon(Icons.accessibility_new, color: Colors.black);
      }break;
      case 'Defensa del mediambient': {
        return Icon(Icons.nature, color: Colors.black);
      }break;
      case 'Joventut': {
        return Icon(Icons.face, color: Colors.black);
      }break;
      case 'Gent Gran': {
        return Icon(Icons.elderly, color: Colors.black);
      }break;
      case 'Protecció dels animals': {
        return Icon(Icons.pets, color: Colors.black);
      }break;
      case 'Cultura': {
        return Icon(Icons.theater_comedy, color: Colors.black);
      }break;
      default: {
        return Icon(Icons.dashboard, color: Colors.white,);
      }break;
    }
  }
  static Icon showIconPrime(String type){
    switch(type) {
      case 'Serveis Sociosanitaris': {
        return Icon(Icons.local_hospital, color: typecolor(type));
      }break;
      case 'Atenció i suport a les families': {
        return Icon(Icons.family_restroom, color: typecolor(type));
      }break;
      case 'Educació i lleure': {
        return Icon(Icons.local_library, color: typecolor(type));
      }break;
      case 'Esport': {
        return Icon(Icons.sports_volleyball, color: typecolor(type));
      }break;
      case 'Voluntariat Internacional': {
        return Icon(Icons.public, color: typecolor(type));
      }break;
      case 'Atenció a les necessitats bàsiques': {
        Icon(Icons.accessibility_new, color: typecolor(type));
      }break;
      case 'Defensa del mediambient': {
        return Icon(Icons.nature, color: typecolor(type));
      }break;
      case 'Joventut': {
        return Icon(Icons.face, color: typecolor(type));
      }break;
      case 'Gent Gran': {
        return Icon(Icons.elderly, color: typecolor(type));
      }break;
      case 'Protecció dels animals': {
        return Icon(Icons.pets, color: typecolor(type));
      }break;
      case 'Cultura': {
        return Icon(Icons.theater_comedy, color: typecolor(type));
      }break;
      default: {
        return Icon(Icons.dashboard, color: typecolor(type));
      }break;
    }
  }

  static CircleAvatar showAvatarPrime(Activity act){if(act.image==""){
      return CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.black87,
          child: Colorizer.showIconPrime(act.type));
    }
    else{
      return CircleAvatar(
          radius: 25.0,
          backgroundColor: typecolor(act.type),
          child: AspectRatio(
              aspectRatio: 1/1,
              child: ClipOval(
                child: FadeInImage.memoryNetwork  (
                  width: 100,
                  height: 100,
                  placeholder: kTransparentImage,
                  image:act.image,
                  fit: BoxFit.cover,
                ),
              )
          )
      );
    }
  }
  // Found on https://stackoverflow.com/questions/58360989/programmatically-lighten-or-darken-a-hex-color-in-dart. Thank you NearHuscarl.
  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
  // Found on https://stackoverflow.com/questions/58360989/programmatically-lighten-or-darken-a-hex-color-in-dart. Thank you NearHuscarl.
  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static CircleAvatar showAvatar(Activity act){
    if(act.image==""){
      switch(act.type) {
        case 'Serveis Sociosanitaris': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.local_hospital, color: Colors.black),
          );
        }break;
        case 'Atenció i suport a les families': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(Icons.family_restroom, color: Colors.black),
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
            child: Icon(Icons.accessibility_new, color: Colors.black),
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
            child: Icon(Icons.face, color: Colors.black),
          );
        }break;
        case 'Gent Gran': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.elderly, color: Colors.black),
          );
        }break;
        case 'Protecció dels animals': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
            child: Icon(Icons.pets, color: Colors.black),
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
                      width: 100,
                      height: 100,
                      placeholder: kTransparentImage,
                      image:act.image,
                      fit: BoxFit.cover,
                    ),
                  )
              )
          );
      }
    }
  }
