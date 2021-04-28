import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminspecific/activities/activity_form.dart';
import 'package:flutter_firestore/adminspecific/entities/entity_form.dart';
import 'package:flutter_firestore/adminspecific/feedback/feedbackadmin.dart';
import 'package:flutter_firestore/screens/main/about_page.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:flutter_firestore/utils/colorizer.dart';
import 'package:flutter_firestore/screens/entities/entity_list.dart';
import 'package:flutter_firestore/screens/firefeedback.dart';
import 'package:flutter_firestore/screens/activities/activity_list.dart';
import 'package:flutter_firestore/screens/main/carousel.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:unicorndial/unicorndial.dart';
import 'package:flutter_firestore/utils/strings.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  TextEditingController controllername = TextEditingController();
  String searchvalue = null;
  bool dialVisible = true;
  String filter = "";
  ScrollController scrollController;
  var foregroundColor;
  int _selectedIndex = 0;
  String filtermode = "";

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
    foregroundColor = Colorizer.typecolor(filter).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  Container customFloatingActionButton() {
    if (admin.isLoggedIn) {
      if (_selectedIndex == 1) {
        return Container(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModifyActivity(null)));
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
                          (context as Element).reassemble();
                        },
                        backgroundColor: Colorizer.typecolor(filter),
                        icon: Icon(Icons.clear, color: Colors.black),
                        label: Text(filter,
                            style: TextStyle(color: foregroundColor)),
                      ),
                    ),
                  ),
          ]),
        );
      } else if (_selectedIndex == 2) {
        return Container(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ModifyEntity(null)));
            },
            child: Icon(Icons.add, color: Colors.white, size: 30),
            backgroundColor: Colors.green,
          ),
        );
      } else
        return Container();
    } else {
      if (_selectedIndex == 1) {
        return Container(
          child: Stack(alignment: Alignment.bottomRight, children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  child: UnicornDialer(
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                    parentButtonBackground: Colors.black,
                    orientation: UnicornOrientation.VERTICAL,
                    parentButton:
                        _Face2FaceOptions.elementAt(_selectedface2face),
                    childButtons: [
                      UnicornButton(
                          hasLabel: true,
                          labelText: Strings.modeTot,
                          labelColor: Colors.black,
                          currentButton: FloatingActionButton(
                            heroTag: Strings.modeTot,
                            backgroundColor: Colors.black,
                            mini: true,
                            child: Icon(Icons.all_inclusive_rounded),
                            onPressed: () {
                              _selectedface2face = 0;
                              filtermode = "";
                              setState(() {});
                            },
                          )),
                      UnicornButton(
                          hasLabel: true,
                          labelText: Strings.modeVirtual,
                          labelColor: Colors.black,
                          currentButton: FloatingActionButton(
                            heroTag: Strings.modeVirtual,
                            backgroundColor: Colors.black87,
                            mini: true,
                            child: Icon(Icons.desktop_windows),
                            onPressed: () {
                              _selectedface2face = 1;
                              filtermode = Strings.modeVirtual;
                              setState(() {});
                            },
                          )),
                      UnicornButton(
                          hasLabel: true,
                          labelText: Strings.modePresencial,
                          labelColor: Colors.black,
                          currentButton: FloatingActionButton(
                            heroTag: Strings.modePresencialNomes,
                            backgroundColor: Colors.black87,
                            mini: true,
                            child: Icon(Icons.accessibility_new_rounded),
                            onPressed: () {
                              _selectedface2face = 2;
                              filtermode = Strings.modePresencial;
                              setState(() {});
                            },
                          )),
                      UnicornButton(
                          hasLabel: true,
                          labelText: Strings.modeSemi,
                          labelColor: Colors.black,
                          currentButton: FloatingActionButton(
                            heroTag: Strings.modeSemi,
                            backgroundColor: Colors.black87,
                            mini: true,
                            child: Icon(Icons.shuffle),
                            onPressed: () {
                              _selectedface2face = 3;
                              filtermode = Strings.modeSemi;
                              setState(() {});
                            },
                          )),
                    ],
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
                        label: Text(Strings.type,
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
                          (context as Element).reassemble();
                        },
                        backgroundColor: Colorizer.typecolor(filter),
                        icon: Icon(Icons.clear, color: Colors.black),
                        label: Text(filter,
                            style: TextStyle(color: foregroundColor)),
                      ),
                    ),
                  ),
          ]),
        );
      } else
        return Container();
    }
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
                      child: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                      ),
                    ),
                    title: new Text(Strings.modeTot,
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
                        child: Icon(
                          Icons.local_hospital,
                          color: Colors.black,
                        ),
                      ),
                      title: new Text(Strings.typesss),
                      onTap: () {
                        filter = Strings.typesss;
                        setState(() {});
                        Navigator.pop(context);
                      }),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.family_restroom, color: Colors.black),
                    ),
                    title: new Text(Strings.typeFamilia),
                    onTap: () {
                      filter = Strings.typeFamilia;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.lime,
                      child: Icon(
                        Icons.local_library,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeEducacio),
                    onTap: () {
                      filter = Strings.typeEducacio;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.cyanAccent,
                      child: Icon(Icons.sports_volleyball, color: Colors.black),
                    ),
                    title: new Text(Strings.typeEsport),
                    onTap: () {
                      filter = Strings.typeEsport;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.public,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeInter),
                    onTap: () {
                      filter = Strings.typeInter;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(
                        Icons.accessibility_new,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeBasic),
                    onTap: () {
                      filter = Strings.typeBasic;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.lightGreenAccent,
                      child: Icon(
                        Icons.nature,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeMedi),
                    onTap: () {
                      filter = Strings.typeMedi;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.deepOrange,
                      child: Icon(
                        Icons.face,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeJove),
                    onTap: () {
                      filter = Strings.typeJove;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.indigo,
                      child: Icon(
                        Icons.elderly,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeGran),
                    onTap: () {
                      filter = Strings.typeGran;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.brown,
                      child: Icon(Icons.pets, color: Colors.black),
                    ),
                    title: new Text(Strings.typeAnimal),
                    onTap: () {
                      filter = Strings.typeAnimal;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.theater_comedy,
                        color: Colors.black,
                      ),
                    ),
                    title: new Text(Strings.typeCult),
                    onTap: () {
                      filter = Strings.typeCult;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        });
  }

  BottomNavigationBar customNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: Strings.homeInici,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: Strings.homeActivitats,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city),
          label: Strings.homeEntitats,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: Strings.homeInfo,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Container bodyHome() {
    final container = [
      Container(
          child: StreamProvider<List<Activity>>.value(
        initialData: [],
        value: ActivityService().activities,
        child: Carousel(),
      )),
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
                child: StreamProvider<List<Entity>>.value(
              initialData: [],
              value: EntityService().entities,
              child: StreamProvider<List<Activity>>.value(
                initialData: [],
                value: ActivityService().activities,
                child: admin.isLoggedIn
                    ? ActivityList(filter: filter)
                    : ActivityList(
                        filter: filter,
                        filtermode: filtermode,
                      ),
              ),
            ))
          ],
        ),
      ),
      Container(
        color: Colors.white,
        child: Center(
          child: StreamProvider<List<Entity>>.value(
            initialData: [],
            value: EntityService().entities,
            child: EntitiesList(),
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
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            admin.isLoggedIn
                ? Container()
                : new ListTile(
                    title: new Text(Strings.homeAdmin),
                    leading: new Icon(Icons.assignment_outlined,
                        color: Colors.black),
                    onTap: () {
                      setState(() {
                        admin.isLoggedIn = true;
                      });
                      //Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen()));
                    },
                  ),
            admin.isLoggedIn?
            new ListTile(
              title: new Text(Strings.adminfeedback),
              leading:
              new Icon(Icons.announcement_outlined, color: Colors.black),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackAdmin()));
              },
            ):new ListTile(
              title: new Text(Strings.homefeedback),
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
            admin.isLoggedIn
                ? new ListTile(
                    title: new Text(Strings.hometTancar),
                    leading: new Icon(Icons.close, color: Colors.black),
                    onTap: () {
                      setState(() {
                        admin.isLoggedIn = false;
                      });
                    },
                  )
                : Container()
          ],
        ),
      ),
    ];
    return container[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: bodyHome(),
        ),
        floatingActionButton: customFloatingActionButton(),
        bottomNavigationBar: customNavBar(),
      ),
    );
  }
}
