import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/entities/admin_entities_list.dart';
import 'package:flutter_firestore/adminscreens/newactivity/form_new_activity.dart';
import 'package:flutter_firestore/commonscreeens/search_results.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/home/carousel.dart';
import 'package:flutter_firestore/screens/home/home.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/adminscreens/home/admin_home_list.dart';
import 'package:flutter_firestore/adminscreens/aboutpage/about_page_admin.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;
import 'package:flutter_firestore/commonscreeens/firefeedback.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdminHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {
  TextEditingController controllername = TextEditingController();
  SearchBar searchBar;
  String searchvalue = null;
  bool dialVisible = true;
  String filter = "";
  ScrollController scrollController;
  var foregroundColor;
  int _selectedIndex = 0;
  String filtermode = "";

  Future<String> NewEntityDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          controllername = TextEditingController();
          return AlertDialog(
            title: Text("Introdueix les dades de l\'entitat"),
            content: Container(
              child: Flexible(
                child: Column(
                  children: [
                    TextField(
                      controller: controllername,
                      autofocus: true,
                      decoration: InputDecoration(hintText: "Introdueix el nom"),
                    ),
                  ],
                ),
              ),
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
                  Navigator.of(context).pop();
                },
                child: Text("Afegir"),
              )
            ],
          );
        }
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Voluntariats',
    ),
    Text(
      'Voluntariats Presencials',
    ),
    Text(
      'Voluntariats Virtuals',
    ),
    Text(
      'Voluntariats Semipresencials',
    ),
  ];

  static const List<Widget> _Face2FaceOptions = <Widget>[
    Icon(Icons.all_inclusive_rounded),
    Icon(Icons.desktop_windows),
    Icon(Icons.accessibility_new_rounded),
    Icon(Icons.shuffle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      filter = "";
    });
  }

  int _selectedface2face = 0;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: filter == ""
            ? new Text("Voluntariats")
            : new Text(filter, style: TextStyle(color: foregroundColor)),
        //centerTitle: true,
        backgroundColor: Colorizer.typecolor(filter),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    searchvalue = value;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResults(searchvalue, filter)));
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

  void initState() {
    admin.isLoggedIn = true;
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
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

  void _settingModalBottomSheet(context) {
    double screenpercentage;
    if (kIsWeb)
      screenpercentage = 0.60;
    else
      screenpercentage = 0.85;
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * screenpercentage,
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    tileColor: Colors.black87,
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black87,
                      child: IconButton(
                        icon: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                        ),
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
                            Icons.local_hospital,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: new Text('Serveis Sociosanitaris'),
                      onTap: () {
                        filter = "Serveis Sociosanitaris";
                        setState(() {});
                        Navigator.pop(context);
                      }),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: IconButton(
                        icon: Icon(Icons.family_restroom, color: Colors.black),
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
                        icon: Icon(
                          Icons.local_library,
                          color: Colors.black,
                        ),
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
                        icon:
                            Icon(Icons.sports_volleyball, color: Colors.black),
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
                        icon: Icon(
                          Icons.public,
                          color: Colors.black,
                        ),
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
                          Icons.accessibility_new,
                          color: Colors.black,
                        ),
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
                        icon: Icon(
                          Icons.nature,
                          color: Colors.black,
                        ),
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
                        icon: Icon(
                          Icons.face,
                          color: Colors.black,
                        ),
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
                        icon: Icon(
                          Icons.elderly,
                          color: Colors.black,
                        ),
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
                        icon: Icon(Icons.pets, color: Colors.black),
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
                        icon: Icon(
                          Icons.theater_comedy,
                          color: Colors.black,
                        ),
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
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final container = [
      Container(
          child: StreamProvider<List<Activity>>.value(
        value: ActivityService().activities,
        child: Carousel(),
      )),
      Container(
        color: Colors.black12,
        child: Column(
          children: [
            Flexible(
              child: StreamProvider<List<Entity>>.value(
                value: EntityService().entities,
                child: StreamProvider<List<Activity>>.value(
                    value: ActivityService().activities,
                    child: AdminHomeList(filter)),
              ),
            )
          ],
        ),
      ),
      Container(
          color: Colors.black26,
          child: Center(
            child: StreamProvider<List<Entity>>.value(
                value: EntityService().entities,
                child: AdminEntitiesList(),
              ),
            ),
          ),
      Container(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(
                  "Aplicació de voluntariats",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: new Text("Sigues voluntari a Tortosa",
                    style: TextStyle(color: Colors.black)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/escutp.png"),
                      fit: BoxFit.cover),
                )),
            new ListTile(
              title: new Text("Qui som?"),
              leading: new Icon(Icons.approval, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPageAdmin()));
              },
            ),
            new ListTile(
              title: new Text("Dona el teu feedback"),
              leading:
                  new Icon(Icons.announcement_outlined, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FireFeedback()));
              },
            ),
            new Divider(
              height: 10.0,
              color: Colors.black,
            ),
            new ListTile(
              title: new Text("Tancar"),
              leading: new Icon(Icons.close, color: Colors.black),
              onTap: () {
                admin.isLoggedIn = false;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            )
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: container[_selectedIndex],
      ),
      floatingActionButton: _selectedIndex == 1
          ? Stack(alignment: Alignment.bottomRight, children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormNewActivity()));
                      },
                      child: Icon(Icons.add, color: Colors.white, size: 30),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              filter == ""
                  ? Container(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                          backgroundColor: Colorizer.typecolor(filter),
                          icon: Colorizer.showIcon(filter),
                          label: Text("Tipus",
                              style: TextStyle(color: foregroundColor)),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            filter = "";
                            print("bona nit");
                            (context as Element).reassemble();
                          },
                          backgroundColor: Colorizer.typecolor(filter),
                          icon: Icon(Icons.clear, color: Colors.black),
                          label: Text(filter,
                              style: TextStyle(color: foregroundColor)),
                        ),
                      ),
                    ),
            ])
          : _selectedIndex == 2
          ?FloatingActionButton(onPressed: (){
        NewEntityDialog(context).then((onValue){
          if ((onValue!=null)&&(onValue.isNotEmpty)) {
            Entity entity=new Entity("",controllername.text.toString(),"","");
            EntityService().addEntity(entity);
          }

        });
      },
        child: Icon(Icons.add,color:Colors.white,size: 30),
        backgroundColor: Colors.green,
      )
          :Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inici',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Activitats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Entitats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
