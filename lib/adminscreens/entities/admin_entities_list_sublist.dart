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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_firestore/commonscreeens/entities_list_sublist_results.dart';
import 'package:transparent_image/transparent_image.dart';

class AdminEntitiesListSubActivites extends StatefulWidget {
  Entity entity;

  AdminEntitiesListSubActivites(this.entity);

  @override
  _AdminEntitiesListSubActivitesState createState() =>
      _AdminEntitiesListSubActivitesState();
}

class _AdminEntitiesListSubActivitesState extends State<AdminEntitiesListSubActivites> {
  TextEditingController controller = TextEditingController();
  YoutubePlayerController _YTcontroller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=-FTNbqxCfhA"),
  );

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

  Future<String> DeleteImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Vols esborrar la imatge de l'activitat?"),
            content: Text("Aquesta acció serà irreversible"),
            actions: [
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                child: Text("Esborrar"),
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

  //It's Future because we are promising that a String will be returned
  Future<String> UpdateEntityNameDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          controller = TextEditingController();
          controller.text = widget.entity.name;
          return AlertDialog(
            title: Text("Modifica el nom de la entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Modificar"),
              )
            ],
          );
        });
  }

  Future<String> UpdateEntityDescDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          controller = TextEditingController();
          controller.text = widget.entity.desc;
          return AlertDialog(
            title: Text("Modifica la descripció de l'entitat"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
                child: Text("Modificar"),
              )
            ],
          );
        });
  }

  Future<String> UploadYTLinkDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          controller = TextEditingController();
          controller.text = widget.entity.ytlink;
          return AlertDialog(
            title: Text("Introdueix el link de YouTube al video"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                  setState(() {});
                },
                child: Text("Crear"),
              )
            ],
          );
        });
  }

  void runYoutubePlayer() {
    _YTcontroller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.entity.ytlink),
      flags: YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: false,
        isLive: false,
      ),
    );
  }

  void dispose() {
    _YTcontroller.dispose();
    super.dispose();
  }

  void deactivate() {
    _YTcontroller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var list_activities = Provider.of<List<Activity>>(context) ?? [];
    if (widget.entity.ytlink == "") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colorizer.typecolor(""),
          title: new Text(widget.entity.name),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.black12,
          child: ListView(
            children: [
              widget.entity.image != ""
                  ? Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.entity.image,
                ),
              ) : Container(),
              SizedBox(height: 20),
              ListTile(
                title: Wrap(
                  children: [
                    Text(widget.entity.name),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        UpdateEntityNameDialog(context).then((onValue) {
                          if ((onValue != null) && (onValue.isNotEmpty)) {
                            widget.entity.name = onValue;
                            EntityService().updateEntity(widget.entity);
                            (context as Element).reassemble();
                          }
                        });
                      },
                    ),
                  ],
                ),
                subtitle: Wrap(
                  children: [
                    Text(widget.entity.desc),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        UpdateEntityDescDialog(context).then((onValue) {
                          if ((onValue != null) && (onValue.isNotEmpty)) {
                            print(onValue);
                            widget.entity.desc = onValue;
                            EntityService().updateEntity(widget.entity);
                            (context as Element).reassemble();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text("Activitats de l'entitat:"),
              ),
              EntitiesListSubActivitiesResults(widget.entity),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            widget.entity.ytlink == ""
                ? FloatingActionButton(
              heroTag: "addvideotoentitybutton",
              onPressed: () {
                UploadYTLinkDialog(context).then((onValue) {
                  if ((onValue != null) && (onValue.isNotEmpty)) {
                    print(onValue);
                    widget.entity.ytlink = onValue;
                    EntityService().updateEntity(widget.entity);
                  }
                });
                (context as Element).reassemble();
              },
              child: Icon(Icons.ondemand_video),
              foregroundColor: Colors.white,
            )
                : FloatingActionButton(
              heroTag: "addvideotoentitybutton",
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Estas segur?"),
                        content: Text(
                            "Vols esborrar el video assignat a aquesta activitat"),
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
                              widget.entity.ytlink = "";
                              EntityService().updateEntity(widget.entity);
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            },
                          )
                        ],
                      );
                    });
                (context as Element).reassemble();
              },
              child: Icon(Icons.video_settings_outlined),
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
                await DeleteImageDialog(context);
                (context as Element).reassemble();
              },
              child: Icon(Icons.broken_image),
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              heroTag: "deleteactivitybutton",
              onPressed: () {
                var canDelete = true;
                for (var activity in list_activities) {
                  for (var entity in activity.entities) {
                    if (entity == widget.entity.id) canDelete = false;
                  }
                }
                if (canDelete) {
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
                                EntityService().deleteEntity(widget.entity);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
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
                          title: Text(
                              "No es pot esborrar l'entitat ja que té activitats assignades"),
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
                      });
                }
              },
              child: Icon(Icons.delete),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      );
    } else {
      runYoutubePlayer();
      return YoutubePlayerBuilder(
          player: YoutubePlayer(
              controller: _YTcontroller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blue,
              progressColors: ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              )),
          builder: (context, player) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colorizer.typecolor(""),
                title: new Text(widget.entity.name),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.black12,
                child: ListView(
                  children: [
                    Container(child: player),
                    SizedBox(height: 20),
                    ListTile(
                      title: Wrap(
                        children: [
                          Text(widget.entity.name),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              UpdateEntityNameDialog(context).then((onValue) {
                                if ((onValue != null) && (onValue.isNotEmpty)) {
                                  widget.entity.name = onValue;
                                  EntityService().updateEntity(widget.entity);
                                  (context as Element).reassemble();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      subtitle: Wrap(
                        children: [
                          Text(widget.entity.desc),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              UpdateEntityDescDialog(context).then((onValue) {
                                if ((onValue != null) && (onValue.isNotEmpty)) {
                                  print(onValue);
                                  widget.entity.desc = onValue;
                                  EntityService().updateEntity(widget.entity);
                                  (context as Element).reassemble();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text("Activitats de l'entitat:"),
                    ),
                    EntitiesListSubActivitiesResults(widget.entity),
                  ],
                ),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  widget.entity.ytlink == ""
                      ? FloatingActionButton(
                    heroTag: "addvideotoentitybutton",
                    onPressed: () {
                      UploadYTLinkDialog(context).then((onValue) {
                        if ((onValue != null) && (onValue.isNotEmpty)) {
                          print(onValue);
                          widget.entity.ytlink = onValue;
                          EntityService().updateEntity(widget.entity);
                        }
                      });
                      // pop current page
                    },
                    child: Icon(Icons.ondemand_video),
                    foregroundColor: Colors.white,
                  )
                      : FloatingActionButton(
                    heroTag: "addvideotoentitybutton",
                    onPressed: () async {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Estas segur?"),
                              content: Text(
                                  "Vols esborrar el video assignat a aquesta activitat"),
                              actions: [
                                TextButton(
                                  child: Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Esborrar"),
                                  onPressed: () {
                                    widget.entity.ytlink = "";
                                    EntityService()
                                        .updateEntity(widget.entity);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.video_settings_outlined),
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
                      await DeleteImageDialog(context);
                      (context as Element).reassemble();
                    },
                    child: Icon(Icons.broken_image),
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                  FloatingActionButton(
                    heroTag: "deleteactivitybutton",
                    onPressed: () {
                      var canDelete = true;
                      for (var activity in list_activities) {
                        for (var entity in activity.entities) {
                          if (entity == widget.entity.id) canDelete = false;
                        }
                      }
                      if (canDelete) {
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
                                      EntityService()
                                          .deleteEntity(widget.entity);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
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
                                title: Text(
                                    "No es pot esborrar l'entitat ja que té activitats assignades"),
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
                            });
                      }
                    },
                    child: Icon(Icons.delete),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            );
          });
    }
  }
}
