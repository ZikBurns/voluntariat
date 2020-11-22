import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/home/admin_home.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<Activity>> searchresults=ActivityService().activities;


  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: searchresults,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Voluntariats"),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search, color: Colors.white,),
                  onPressed: (){

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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
                },
              ),
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
      )
    );
  }
}
