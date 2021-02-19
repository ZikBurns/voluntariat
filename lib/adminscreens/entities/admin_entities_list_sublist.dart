import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list_sublist_provider.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';
import 'package:transparent_image/transparent_image.dart';

class AdminEntitiesListSubActivites extends StatefulWidget {
  Entity entity;

  AdminEntitiesListSubActivites(this.entity);

  @override
  _AdminEntitiesListSubActivitesState createState() => _AdminEntitiesListSubActivitesState();
}

class _AdminEntitiesListSubActivitesState extends State<AdminEntitiesListSubActivites> {
  TextEditingController controller = TextEditingController();


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
        var snapshot = await ref.child('entityimages/'+widget.entity.id)
            .putData(bytes);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(()
        {
          widget.entity.image = downloadUrl;
          EntityService().updateEntity(widget.entity);
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
              .child('entityimages/'+widget.entity.id)
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          setState(()
          {
            widget.entity.image = downloadUrl;
            EntityService().updateEntity(widget.entity);
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
        .child('entityimages/'+widget.entity.id).delete();
    widget.entity.image = "";
    EntityService().updateEntity(widget.entity);
  }


  Future<String> DeleteImageDialog(BuildContext context){
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



  //It's Future because we are promising that a String will be returned
  Future<String> UpdateEntityNameDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          controller = TextEditingController();
          controller.text=widget.entity.name;
          return AlertDialog(
            title: Text("Modifica el nom de la entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Modificar"),
              )
            ],
          );
        }
    );
  }

  Future<String> UpdateEntityDescDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          controller = TextEditingController();
          controller.text=widget.entity.desc;
          return AlertDialog(
            title: Text("Modifica la descripció de l'entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Modificar"),
              )
            ],
          );
        }
    );
  }







  @override
  Widget build(BuildContext context) {
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    print("hola2");
    print(widget.entity.image.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colorizer.typecolor(""),
          title: new Text(widget.entity.name),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black12,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  widget.entity.image!=""
                      ? Stack(
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      Center(child: FadeInImage.memoryNetwork  (
                        placeholder: kTransparentImage,
                        image:widget.entity.image,
                      ), )
                    ],
                  )
                      : Container(),
                ],
              ),
              SizedBox(height:20),
              ListTile(
                title: Row(
                  children: [
                    IconButton(icon: Icon(Icons.edit),
                      onPressed: (){
                        UpdateEntityNameDialog(context).then((onValue){
                          if ((onValue!=null)&&(onValue.isNotEmpty)) {
                            widget.entity.name=onValue;
                            EntityService().updateEntity(widget.entity);
                          }
                        });
                      },
                    ),
                    Text(widget.entity.name),
                  ],
                ),
                subtitle: Row(
                  children: [
                    IconButton(icon: Icon(Icons.edit),
                      onPressed: (){
                        UpdateEntityDescDialog(context).then((onValue){
                          if ((onValue!=null)&&(onValue.isNotEmpty)) {
                            print(onValue);
                            widget.entity.desc=onValue;
                            EntityService().updateEntity(widget.entity);
                            (context as Element).reassemble();
                          }
                        });
                      },
                    ),
                    Text(widget.entity.desc),
                  ],
                ),
              ),
              ListTile(
                title: Text("Activitats de l'entitat:"),
              ),
              Flexible(
                child: EntitiesListSubActivitiesResults(widget.entity),
              )
            ],
          ),
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          widget.entity.image==""
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
              await DeleteImageDialog(context);
              (context as Element).reassemble();
            },
            child: Icon(Icons.broken_image),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: "deleteactivitybutton",
            onPressed: (){
              var canDelete=true;
              for(var activity in list_activities){
                for(var entity in activity.entities) {
                  if (entity == widget.entity.id) canDelete=false;
                }
              }
              if(canDelete) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Estas segur?"),
                        content: Text(
                            "Aquesta operació podria afectar altres dades de l'aplicacio"),
                        actions: [
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            },
                          ),
                          TextButton(
                            child: Text("Esborrar"),
                            onPressed: () {
                              EntityService().deleteEntity(
                                  widget.entity);
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            },
                          )
                        ],
                      );
                    }
                );
              }
              else{
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("No es pot esborrar l'entitat ja que té activitats assignades"),
                        content: Text(
                            "Desassigna les activitats d'aquesta entitat o esborra les activitats de l'entitat"),
                        actions: [

                          TextButton(
                            child: Text("Acceptar"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            },
                          )
                        ],
                      );
                    }
                );
              }
            },
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
