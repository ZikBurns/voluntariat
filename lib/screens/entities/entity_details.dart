import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminspecific/entities/entity_form.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_firestore/utils/commonfunctions.dart';
import 'package:flutter_firestore/screens/entities/entity_present_activities.dart';
import 'package:flutter_firestore/screens/entities/socialnetworks.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkable/linkable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter_firestore/data/admin.dart' as admin;


class AdminEntityDetails extends StatefulWidget {
  Entity entity;

  AdminEntityDetails(this.entity);

  @override
  _AdminEntityDetailsState createState() =>
      _AdminEntityDetailsState();
}

class _AdminEntityDetailsState
    extends State<AdminEntityDetails> {
  TextEditingController controller = TextEditingController();

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    if (kIsWeb) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var bytes = await image.readAsBytes();
      if (image != null) {
        var ref = _storage.ref();
        var snapshot =
            await ref.child('entityimages/' + widget.entity.id).putData(bytes);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          widget.entity.image = downloadUrl;
          EntityService().updateEntity(widget.entity);
        });
      } else
        print('No Path Received');
    } else {
      //Check Permissions
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        //Select Image
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);
        if (image != null) {
          //Upload to Firebase
          var snapshot = await _storage
              .ref()
              .child('entityimages/' + widget.entity.id)
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          setState(() {
            widget.entity.image = downloadUrl;
            EntityService().updateEntity(widget.entity);
          });
        } else
          print('No Path Received');
      } else
        print('Grant Permissions and try again');
    }
  }

  void deleteImage() {
    final _storage = FirebaseStorage.instance;
    _storage.ref().child('entityimages/' + widget.entity.id).delete();
    widget.entity.image = "";
    EntityService().updateEntity(widget.entity);
  }

  Future<String> deleteImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Strings.entityImageErase),
            content: Text(Strings.entityImageEraseWarn),
            actions: [
              TextButton(
                child: Text(Strings.textCancelar),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                child: Text(Strings.textEsborrar),
                onPressed: () {
                  deleteImage();
                  Navigator.of(context, rootNavigator: true).pop();
                  (context as Element).reassemble();
                },
              )
            ],
          );
          //Navigator.of(context, rootNavigator: true).pop();
        });
  }


  FloatingActionButton deleteButton() {
    return FloatingActionButton(
      heroTag: "deleteactivitybutton",
      onPressed: () async {
        var listActivities = Provider.of<List<Activity>>(context, listen: false) ?? [];
        var canDelete = true;
        for (var activity in listActivities) {
          for (var entity in activity.entities) {
            if (entity == widget.entity.id) canDelete = false;
          }
        }
        if (canDelete) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(Strings.entityEraseWarn1),
                  content: Text(
                      Strings.entityEraseWarn2),
                  actions: [
                    TextButton(
                      child: Text(Strings.textCancelar),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                    TextButton(
                      child: Text(Strings.textEsborrar),
                      onPressed: () {
                        EntityService().deleteEntity(widget.entity);
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(Strings.entityEraseWarn3),
                  content: Text(Strings.entityEraseWarn4),
                  actions: [
                    TextButton(
                      child: Text("Acceptar"),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                );
              });
        }
      },
      child: Icon(Icons.delete),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      initialData: [],
        value: ActivityService().activities,
        child: StreamProvider<List<Entity>>.value(
            initialData: [],
        value: EntityService().entities,
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Color(widget.entity.color),
        title: new Text(
          widget.entity.name,
          style: TextStyle(
              color: Color(widget.entity.color).computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Color(widget.entity.color).computeLuminance() > 0.5
                ? Colors.black
                : Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            CommonFunctions.showMedia(widget.entity.ytlink,widget.entity.image),
            SizedBox(height: 5),
            ListTile(
              title: Text(widget.entity.name),
              subtitle: Text(widget.entity.desc),
            ),
            widget.entity.contact!=""?ListTile(
              title: Text("Contacte:"),
              subtitle: Linkable(text: widget.entity.contact),
            ):Container(),
            SocialNetworks(widget.entity),
            widget.entity.tasks!=""?ListTile(
              title: Text("Tasques de voluntariat:"),
              subtitle: Text(widget.entity.tasks),
            ):Container(),
            EntityPresentActivities(widget.entity),
          ],
        ),
      ),
      floatingActionButton: admin.isLoggedIn?Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "editactivitybutton",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ModifyEntity(widget.entity)));
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.yellow[900],
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          widget.entity.image == ""
              ? FloatingActionButton(
                  heroTag: "addphototoactivitybutton",
                  onPressed: () {
                    uploadImage();
                  },
                  child: Icon(Icons.add_photo_alternate_rounded),
                  foregroundColor: Colors.white,
                )
              : FloatingActionButton(
                  heroTag: "addphototoactivitybutton",
                  onPressed: () async {
                    await deleteImageDialog(context);
                    (context as Element).reassemble();
                  },
                  child: Icon(Icons.broken_image),
                  foregroundColor: Colors.white,
                ),
          SizedBox(height: 20),
          deleteButton()
        ],
      ):Container(),
    )));
  }
}
