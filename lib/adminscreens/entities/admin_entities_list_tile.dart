import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list_sublist.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list_sublist_provider.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import 'package:transparent_image/transparent_image.dart';


class AdminEntitiesListTile extends StatefulWidget {
  Entity entity;
  AdminEntitiesListTile(this.entity);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminEntitiesListTile> {

  passData(Entity entity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEntitiesListSublistProvider(entity)));
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: ListTile(
        title: Text(widget.entity.name,style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
        subtitle: Text(widget.entity.desc),
        onTap: (){
          passData(widget.entity);
        },
        trailing: widget.entity.image!=""
            ? CircleAvatar(
            radius: 25.0,
            child: AspectRatio(
                aspectRatio: 1/1,
                child: ClipOval(
                  child: FadeInImage.memoryNetwork  (
                    width: 100,
                    height: 100,
                    placeholder: kTransparentImage,
                    image:widget.entity.image,
                    fit: BoxFit.cover,
                  ),
                )
            )
        ) : CircleAvatar(),
      ),
    );
  }
}