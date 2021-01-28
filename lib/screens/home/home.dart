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
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SearchBar searchBar;
  String searchvalue="";
  late ScrollController scrollController;
  bool dialVisible = true;
  String filter="";
  var foregroundColor;



  AppBar buildAppBar(BuildContext context) {

    return new AppBar(
        title: filter==""?new Text('Voluntariats'):new Text(filter,style:TextStyle(color:foregroundColor)),
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


  void _settingModalBottomSheet(context){
    double screenpercentage;
    if(kIsWeb)screenpercentage=0.60;
    else screenpercentage=0.85;
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc){
            return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * screenpercentage,
              child:new ListView(
                children: <Widget>[
                  new ListTile(
                    tileColor: Colors.black87,
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black87,
                      child: IconButton(
                        icon: Icon(Icons.dashboard, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Totes les activitats',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      filter = "";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                        child: IconButton(
                          icon: Icon(
                            Icons.local_hospital, color: Colors.white,),
                        ),
                      ),
                      title: new Text('Serveis Sociosanitaris'),
                      onTap: () {
                        filter = "Serveis Sociosanitaris";
                        setState(() {});
                        Navigator.pop(context);
                      }
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: IconButton(
                        icon: Icon(Icons.family_restroom, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Atenció i suport a les families'),
                    onTap: () {
                      filter = "Atenció i suport a les families";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.lime,
                      child: IconButton(
                        icon: Icon(Icons.local_library, color: Colors.black,),
                      ),
                    ),
                    title: new Text('Educació i lleure'),
                    onTap: () {
                      filter = "Educació i lleure";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.cyanAccent,
                      child: IconButton(
                        icon: Icon(
                          Icons.sports_volleyball, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Esport'),
                    onTap: () {
                      filter = "Esport";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.greenAccent,
                      child: IconButton(
                        icon: Icon(Icons.public, color: Colors.black,),
                      ),
                    ),
                    title: new Text('Voluntariat Internacional'),
                    onTap: () {
                      filter = "Voluntariat Internacional";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pinkAccent,
                      child: IconButton(
                        icon: Icon(
                          Icons.accessibility_new, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Atenció a les necessitats bàsiques'),
                    onTap: () {
                      filter = "Atenció a les necessitats bàsiques";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.lightGreenAccent,
                      child: IconButton(
                        icon: Icon(Icons.nature, color: Colors.black,),
                      ),
                    ),
                    title: new Text('Defensa del mediambient'),
                    onTap: () {
                      filter = "Defensa del mediambient";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepOrange,
                      child: IconButton(
                        icon: Icon(Icons.face, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Joventut'),
                    onTap: () {
                      filter = "Joventut";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.indigo,
                      child: IconButton(
                        icon: Icon(Icons.elderly, color: Colors.white,),
                      ),
                    ),
                    title: new Text('Gent Gran'),
                    onTap: () {
                      filter = "Gent Gran";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.brown,
                      child: IconButton(
                        icon: Icon(Icons.pets, color: Colors.white),
                      ),
                    ),
                    title: new Text('Protecció dels animals'),
                    onTap: () {
                      filter = "Protecció dels animals";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.yellow,
                      child: IconButton(
                        icon: Icon(Icons.theater_comedy, color: Colors.black,),
                      ),
                    ),
                    title: new Text('Cultura'),
                    onTap: () {
                      filter = "Cultura";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    foregroundColor = Colorizer.typecolor(filter).computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return StreamProvider<List<Activity>>.value(
      value: ActivityService().activities,
      child: Scaffold(
        appBar: searchBar.build(context),
        drawer:filter==""? new Drawer(
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
        ):null,
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
          floatingActionButton: FloatingActionButton.extended(
                  onPressed: (){
                    _settingModalBottomSheet(context);
                  },
                  backgroundColor:Colorizer.typecolor(filter),
                  icon: Icon(Icons.explore, color:foregroundColor),
                  label: Text("Tipus",style:TextStyle(color:foregroundColor)),
                ),
      )
      );
  }
}
