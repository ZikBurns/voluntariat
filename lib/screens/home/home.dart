import 'package:flutter/material.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list.dart';
import 'package:flutter_firestore/commonscreeens/search_results.dart';
import 'package:flutter_firestore/commonscreeens/firefeedback.dart';
import 'package:flutter_firestore/screens/signinadmin/signin_screen.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_firestore/screens/aboutpage/about_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firestore/screens/entities/entities.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SearchBar searchBar;
  String searchvalue=null;
  ScrollController scrollController;
  bool dialVisible = true;
  String filter="";



  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: filter==""?new Text('Voluntariats'):new Text(filter),
        //centerTitle: true,
        backgroundColor: Colorizer.typecolor(filter),
        actions: [searchBar.getSearchAction(context)]);
    }

  void onSubmitted(String value) {
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
  void initState() {

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    super.initState();

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
      child: Icon(Icons.format_align_left),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => setState(() {}),
      visible: dialVisible,
      curve: Curves.bounceIn,
      backgroundColor: Colorizer.typecolor(filter),
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
          backgroundColor: Colors.black54,
          onTap: () => filter="",
          label: 'Totes les activitats',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.black12,
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
            padding: EdgeInsets.zero,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Aplicació de voluntariats",style:TextStyle(color: Colors.black),),
                  accountEmail: new Text("Sigues voluntari a Tortosa",style:TextStyle(color: Colors.black)),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/escutp.png"),
                        fit: BoxFit.cover),
                    )
                ),
              new ListTile(
                title: new Text("Qui som?"),
                leading: new Icon(Icons.approval, color: Colors.black),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              new ListTile(
                title: new Text("Entitats"),
                leading: new Icon(Icons.account_circle_outlined, color: Colors.black),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Entities()));
                },
              ),
              new ListTile(
                title: new Text("Zona Administrador"),
                leading: new Icon(Icons.assignment_outlined, color: Colors.black),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                },
              ),
              new ListTile(
                title: new Text("Dona el teu feedback"),
                leading: new Icon(Icons.announcement_outlined, color: Colors.black),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FireFeedback()));
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
                child: HomeList(filter),
              )
            ],
          ),
        ),
          floatingActionButton: buildSpeedDial(),
        ),
      );
  }
}
