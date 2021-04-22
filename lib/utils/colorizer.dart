import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:transparent_image/transparent_image.dart';

class Colorizer{


  static Color typecolor(String type){
    switch(type) {
      case Strings.typesss: {
        return Colors.red;
      }break;
      case Strings.typeFamilia: {
        return Colors.deepPurpleAccent;
      }break;
      case Strings.typeEducacio: {
        return Colors.lime;
      }break;
      case Strings.typeEsport: {
        return Colors.cyanAccent;
      }break;
      case Strings.typeBasic: {
        return Colors.pinkAccent;
      }break;
      case Strings.typeInter: {
        return Colors.greenAccent;
      }break;
      case Strings.typeMedi: {
        return Colors.lightGreenAccent;
      }break;
      case Strings.typeJove: {
        return Colors.deepOrange;
      }break;
      case Strings.typeGran: {
      return Colors.indigo;
    }break;
      case Strings.typeAnimal: {
        return Colors.brown;
      }break;
      case Strings.typeCult: {
        return Colors.yellow;
      }break;
      default: {
        return Colors.black87;
      }break;
    }
  }

  static Icon showIcon(String type){
    switch(type) {
      case Strings.typesss: {
        return Icon(Icons.local_hospital, color: Colors.black);
      }break;
      case Strings.typeFamilia: {
        return Icon(Icons.family_restroom, color: Colors.black);
      }break;
      case Strings.typeEducacio: {
        return Icon(Icons.local_library, color: Colors.black);
      }break;
      case Strings.typeEsport: {
        return Icon(Icons.sports_volleyball, color: Colors.black);
      }break;
      case Strings.typeInter: {
        return Icon(Icons.public, color: Colors.black);
      }break;
      case Strings.typeBasic: {
        Icon(Icons.accessibility_new, color: Colors.black);
      }break;
      case Strings.typeMedi: {
        return Icon(Icons.nature, color: Colors.black);
      }break;
      case Strings.typeJove: {
        return Icon(Icons.face, color: Colors.black);
      }break;
      case Strings.typeGran: {
        return Icon(Icons.elderly, color: Colors.black);
      }break;
      case Strings.typeAnimal: {
        return Icon(Icons.pets, color: Colors.black);
      }break;
      case Strings.typeCult: {
        return Icon(Icons.theater_comedy, color: Colors.black);
      }break;
      default: {
        return Icon(Icons.dashboard, color: Colors.white,);
      }break;
    }
  }
  static Icon showIconPrime(String type){
    switch(type) {
      case Strings.typesss: {
        return Icon(Icons.local_hospital, color: typecolor(type));
      }break;
      case Strings.typeFamilia: {
        return Icon(Icons.family_restroom, color: typecolor(type));
      }break;
      case Strings.typeEducacio: {
        return Icon(Icons.local_library, color: typecolor(type));
      }break;
      case Strings.typeEsport: {
        return Icon(Icons.sports_volleyball, color: typecolor(type));
      }break;
      case Strings.typeInter: {
        return Icon(Icons.public, color: typecolor(type));
      }break;
      case Strings.typeBasic: {
        Icon(Icons.accessibility_new, color: typecolor(type));
      }break;
      case Strings.typeMedi: {
        return Icon(Icons.nature, color: typecolor(type));
      }break;
      case Strings.typeJove: {
        return Icon(Icons.face, color: typecolor(type));
      }break;
      case Strings.typeGran: {
        return Icon(Icons.elderly, color: typecolor(type));
      }break;
      case Strings.typeAnimal: {
        return Icon(Icons.pets, color: typecolor(type));
      }break;
      case Strings.typeCult: {
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
        case Strings.typesss: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.local_hospital, color: Colors.black),
          );
        }break;
        case Strings.typeFamilia: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(Icons.family_restroom, color: Colors.black),
          );
        }break;
        case Strings.typeEducacio: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lime,
            child: Icon(Icons.local_library, color: Colors.black),
          );
        }break;
        case Strings.typeEsport: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.cyanAccent,
            child: Icon(Icons.sports_volleyball, color: Colors.black),
          );
        }break;
        case Strings.typeInter: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.public, color: Colors.black),
          );
        }break;
        case Strings.typeBasic: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pinkAccent,
            child: Icon(Icons.accessibility_new, color: Colors.black),
          );
        }break;
        case Strings.typeMedi: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreenAccent,
            child: Icon(Icons.nature, color: Colors.black),
          );
        }break;
        case Strings.typeJove: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.face, color: Colors.black),
          );
        }break;
        case Strings.typeGran: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.elderly, color: Colors.black),
          );
        }break;
        case Strings.typeAnimal: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
            child: Icon(Icons.pets, color: Colors.black),
          );
        }break;
        case Strings.typeCult: {
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
