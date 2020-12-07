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
import 'package:flutter_firestore/data/admin.dart' as admin;
import 'package:flutter_firestore/commonscreeens/firefeedback.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {
  SearchBar searchBar;
  String searchvalue=null;
  bool dialVisible = true;
  String filter="";
  ScrollController scrollController;

  void initState() {
    admin.isLoggedIn=true;
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Voluntariats'),
        centerTitle: true,
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    print("Maria "+value);
    searchvalue=value;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(searchvalue,filter)));
  }

  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => setState(() {}),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.local_library_rounded, color: Colors.white),
          backgroundColor: Colors.amber,
          onTap: () => filter='Èxit educatiu',
          label: 'Èxit educatiu',
          labelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          labelBackgroundColor: Colors.amberAccent,
        ),

        SpeedDialChild(
          child: Icon(Icons.face_rounded, color: Colors.white),
          backgroundColor: Colors.red,
          onTap: () => filter='Joves',
          label: 'Joves',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.redAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.family_restroom, color: Colors.white),
          backgroundColor: Colors.lightBlue,
          onTap: () => filter='Famílies',
          label: 'Famílies',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.lightBlueAccent,
          /*labelWidget: Container(
            color: Colors.blue,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text('Custom Label Widget'),
          ),*/
        ),
        SpeedDialChild(
          child: Icon(Icons.all_inclusive_rounded, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => filter='Igualtat d\'oportunitats',
          label: 'Igualtat d\'oportunitats',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.group, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => filter='Participació comunitària',
          label: 'Participació comunitària',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.format_align_left, color: Colors.white),
          backgroundColor: Colors.black26,
          onTap: () => filter="",
          label: 'Totes les activitats',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.black38,
        ),
      ],
    );
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
                accountName: new Text("Aplicació de voluntariats",style:TextStyle(color: Colors.black),),
                accountEmail: new Text("Sigues voluntari a Tortosa",style:TextStyle(color: Colors.black)),
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png"),),
                    )
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
              new ListTile(
                title: new Text("Dona el teu feedback"),
                leading: new Icon(Icons.announcement_outlined, color: Colors.deepPurpleAccent),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FireFeedback()));
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
                  admin.isLoggedIn=false;
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
        floatingActionButton: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned(
              bottom: 70,
              child: Container(
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> FormNewActivity()));
                  },
                  child: Icon(Icons.add,color:Colors.white,size: 30),
                  backgroundColor: Colors.green,
                )
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                buildSpeedDial(),
              ],
            ),
          ],
        ),
      )
    );
  }
}
