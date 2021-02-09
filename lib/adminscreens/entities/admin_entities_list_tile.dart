import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist.dart';
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
  TextEditingController controller = TextEditingController();

  passData(Entity entity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EntitiesListSubActivites(entity)));
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
              FlatButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
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
              FlatButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
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
              FlatButton(
                child: Text("Cancelar"),
                onPressed:  () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
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

  @override
  Widget build(BuildContext context) {
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    return ListTile(
      title:Row(
        children: [
          Text(widget.entity.name,style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
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
        ],
      ),
      subtitle: Column(
        children: <Widget>[
          Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(widget.entity.desc),
                  ),
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
                  widget.entity.image==""?
                  IconButton(icon: Icon(Icons.add_photo_alternate_rounded),
                    onPressed: (){
                      uploadImage();
                    },
                  ):
                  IconButton(icon: Icon(Icons.broken_image),
                    onPressed: () async {
                      await DeleteImageDialog(context);
                      (context as Element).reassemble();
                    },
                  ),
                  IconButton(icon: Icon(Icons.delete),
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
                                  FlatButton(
                                    child: Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                  FlatButton(
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

                                  FlatButton(
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
                  ),
                ],
              ))
        ],
      ),
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
      )
          : CircleAvatar(),
    );
  }
}