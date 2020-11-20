import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list.dart';
import 'package:flutter_firestore/firestore_service.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot= List(10);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Activities");
  bool searching=false;


  void initState() {
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
    value: FireService().activities,
    child: Scaffold(
      appBar: AppBar(
          title: !searching ?  Text("Voluntariats"):
          TextField(
            decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Cerca",
                hintStyle: TextStyle(color: Colors.white)
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          actions: <Widget>[
            !searching?IconButton(
                icon: Icon(Icons.search, color: Colors.white,),
                onPressed: (){
                  setState(() {
                    searching=!searching;
                  });
                }
            )
                : IconButton(
                icon: new Icon(Icons.cancel, color: Colors.white,),
                onPressed: (){
                  setState(() {
                    searching=!searching;
                  });
                }
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
              title: new Text("Zona Administrador"),
              leading: new Icon(Icons.assignment_outlined, color: Colors.deepPurpleAccent),
            ),
            new Divider(
              height: 10.0,
              color: Colors.black,
            ),
            new ListTile(
              title: new Text("Tancar"),
              leading: new Icon(Icons.close, color: Colors.deepPurpleAccent),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: [
            Flexible(
              child: HomeList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        //Navigator.push(context, MaterialPageRoute(builder:(context)=> Afegir()));
      },
        child: Icon(Icons.edit,color:Colors.black),
        backgroundColor: Colors.deepPurpleAccent,
        tooltip: "Afegeix una activitat",
      ),
    )
    );
  }
}
