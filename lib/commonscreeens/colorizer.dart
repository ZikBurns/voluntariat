import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_firestore/data/activity.dart';

class Colorizer{


  static Color typecolor(String type){
    switch(type) {
      case 'Èxit educatiu': {
        return Colors.amber;
      }break;
      case 'Joves': {
        return Colors.red;
      }break;
      case 'Famílies': {
        return Colors.lightBlue;
      }break;
      case 'Igualtat d\'oportunitats': {
        return Colors.green;
      }break;
      case 'Participació comunitària': {
        return Colors.deepOrange;
      }break;
      default: {
        return Colors.black54;
      }break;
    }
  }


  static CircleAvatar showAvatar(Activity act){
    if(act.image==""){
      switch(act.type) {
        case 'Èxit educatiu': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.amber,
            child: Icon(Icons.local_library_rounded, color: Colors.white),
            //backgroundImage: AssetImage("assets/icon_image.png"),
          );
        }break;
        case 'Joves': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.face_rounded, color: Colors.white),
          );
        }break;
        case 'Famílies': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightBlue,
            child: Icon(Icons.family_restroom, color: Colors.white),
          );
        }break;
        case 'Igualtat d\'oportunitats': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green,
            child: Icon(Icons.all_inclusive_rounded, color: Colors.white),
          );
        }break;
        case 'Participació comunitària': {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.group, color: Colors.white),
          );
        }break;
        default: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
          );
        }break;
      }
    }
    else{
      switch(act.type) {
        case 'Èxit educatiu': {
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.amber,
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
        }break;
        case 'Joves': {
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.red,
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
        }break;
        case 'Famílies': {
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.lightBlue,
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
        }break;
        case 'Igualtat d\'oportunitats': {
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.green,
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
        }break;
        case 'Participació comunitària': {
          return CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.deepOrange,
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
        }break;
        default: {
          return CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
          );
        }break;
      }
    }
  }

}