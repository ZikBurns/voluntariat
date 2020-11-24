import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/entities.dart';
import 'package:flutter_firestore/adminscreens/newactivity/form_new_activity.dart';
import 'package:flutter_firestore/commonscreeens/search_results.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';
import 'admin_home_list.dart';
import 'package:flutter_firestore/adminscreens/aboutpage/about_page_admin.dart';


class AdminHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {

  SearchBar searchBar;
  String searchvalue=null;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Voluntariats'),
        centerTitle: true,
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    print("Maria "+value);
    setState(() async {
      searchvalue=value;
      await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(searchvalue)));
      searchvalue=null;
    });
  }

  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          searchvalue=null;
          print("cleared");
        },
        onClosed: () {
          searchvalue=null;
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: Scaffold(
        appBar: searchBar.build(context),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPageAdmin()));
                },
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
          Navigator.push(context, MaterialPageRoute(builder:(context)=> FormNewActivity()));
        },
          child: Icon(Icons.add,color:Colors.white,size: 30),
          backgroundColor: Colors.green,

        ),
      )
    );
  }
}
