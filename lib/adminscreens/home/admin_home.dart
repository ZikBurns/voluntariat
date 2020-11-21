import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/adminscreens/entities/entities.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';
import 'admin_home_list.dart';


class AdminHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot= List(10);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Activities");



  void initState() {
    //db.reference().child(firelistname).onChildAdded.listen(_activityAdded);
    //db.reference().child(firelistname).onChildRemoved.listen(_activityRemoved);
    //db.reference().child(firelistname).onChildChanged.listen(_activityChanged);
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: Scaffold(
        appBar: AppBar(
            title:Text("Voluntariats"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.search, color: Colors.white,),
                  onPressed: null
              )
            ]
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Aplicació de voluntariats"),
                  accountEmail: new Text("Troba un a Tortosa")
              ),
              new ListTile(
                title: new Text("Qui som?"),
                leading: new Icon(Icons.approval, color: Colors.deepPurpleAccent),
              ),
              new ListTile(
                title: new Text("Entitats"),
                leading: new Icon(Icons.account_circle_outlined, color: Colors.deepPurpleAccent),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Entities()));
                },
              ),
              new Divider(
                height: 10.0,
                color: Colors.black,
              ),
              new ListTile(
                title: new Text("Tancar"),
                leading: new Icon(Icons.close, color: Colors.deepPurpleAccent),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.black12,
          child: Column(
            children: [
              Flexible(
                child: AdminHomeList(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          //Navigator.push(context, MaterialPageRoute(builder:(context)=> Afegir()));
        },
          child: Icon(Icons.add,color:Colors.white,size: 30),
          backgroundColor: Colors.green,

        ),
      )
    );
  }
}
