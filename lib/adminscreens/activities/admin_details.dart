import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/adminscreens/activities/modify_details.dart';
import 'package:flutter_firestore/commons/activities/details_body.dart';
import 'package:flutter_firestore/commons/colors/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/activities/present_entities.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkable/linkable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:transparent_image/transparent_image.dart';


class AdminDetailsPage extends StatefulWidget {
  Activity activity;
  AdminDetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<AdminDetailsPage> {
  String imageUrl;

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    if(kIsWeb){
      image = await _picker.getImage(source: ImageSource.gallery);
      var bytes = await image.readAsBytes();
      if (image != null)
      {
        var ref= _storage.ref();
        var snapshot = await ref.child('descriptionimages/'+widget.activity.id)
            .putData(bytes);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(()
        {
          widget.activity.image = downloadUrl;
          ActivityService().updateActivity(widget.activity);
        });
      }
      else print('No Path Received');
    }
    else{
      //Check Permissions
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted)
      {
        //Select Image
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);
        if (image != null)
        {
          //Upload to Firebase
          var snapshot = await _storage.ref()
              .child('descriptionimages/'+widget.activity.id)
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          setState(()
          {
            widget.activity.image = downloadUrl;
            ActivityService().updateActivity(widget.activity);
          });
        }
        else print('No Path Received');
      }
      else print('Grant Permissions and try again');
    }
  }
  void deleteImage() {
    final _storage = FirebaseStorage.instance;
    _storage.ref()
        .child('descriptionimages/'+widget.activity.id).delete();
    widget.activity.image = "";
    ActivityService().updateActivity(widget.activity);
  }

  Future<String> NewImageDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Vols esborrar la imatge de l'activitat?"),
            content: Text("Aquesta acció serà irreversible"),
            actions: [
              TextButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                child: Text("Esborrar"),
                onPressed:  () {
                  deleteImage();
                  Navigator.of(context, rootNavigator: true).pop();
                  (context as Element).reassemble();
                },
              )
            ],
          );
          //Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }


  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: StreamProvider<List<Entity>>.value(
        value: EntityService().entities,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colorizer.typecolor(widget.activity.type),
              title: Text(widget.activity.title),
            ),
            body: DetailsBody(widget.activity),
          floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            widget.activity.image==""
                ? FloatingActionButton(
                    heroTag: "addphototoactivitybutton",
                    onPressed: () {
                      uploadImage();
                    },
                    child: Icon(Icons.add_photo_alternate_rounded),
                    foregroundColor: Colors.white,
                  )
            :
            FloatingActionButton(
              heroTag: "addphototoactivitybutton",
              onPressed: () async {
                await NewImageDialog(context);
                (context as Element).reassemble();
              },
              child: Icon(Icons.broken_image),
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              heroTag: "editactivitybutton",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> ModifyActivity(widget.activity)));
              },
              child: Icon(Icons.edit),
              backgroundColor: Colors.yellow[900],
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              heroTag: "deleteactivitybutton",
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Estas segur?"),
                          content: Text("Aquesta operació podria afectar altres dades de l'aplicacio"),
                          actions: [
                            TextButton(
                              child: Text("Cancelar"),
                              onPressed:  () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Esborrar"),
                              onPressed:  () {
                                ActivityService().deleteActivity(widget.activity);
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            )
                          ],
                        );
                        //Navigator.of(context, rootNavigator: true).pop();
                      }
                  );
                },
              child: Icon(Icons.delete),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        ),
      ),
    );
  }


}