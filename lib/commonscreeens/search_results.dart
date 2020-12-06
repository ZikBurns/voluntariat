import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/search_result_list.dart';


class SearchResults extends StatefulWidget {
  String searchtext;
  String filter;

  SearchResults(this.searchtext, this.filter);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  ScrollController scrollController;
  bool dialVisible = true;

  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
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
          onTap: () => widget.filter='Èxit educatiu',
          label: 'Èxit educatiu',
          labelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          labelBackgroundColor: Colors.amberAccent,
        ),

        SpeedDialChild(
          child: Icon(Icons.face_rounded, color: Colors.white),
          backgroundColor: Colors.red,
          onTap: () => widget.filter='Joves',
          label: 'Joves',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.redAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.family_restroom, color: Colors.white),
          backgroundColor: Colors.lightBlue,
          onTap: () => widget.filter='Famílies',
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
          onTap: () => widget.filter='Igualtat d\'oportunitats',
          label: 'Igualtat d\'oportunitats',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          child: Icon(Icons.group, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => widget.filter='Participació comunitària',
          label: 'Participació comunitària',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.format_align_left, color: Colors.white),
          backgroundColor: Colors.black26,
          onTap: () => widget.filter="",
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
        child: StreamProvider<List<Entity>>.value(
          value: EntityService().entities,
          child: Scaffold(
            appBar: AppBar(
              title: new Text('Resultats amb: '+widget.searchtext),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Flexible(
                    child: SearchResultList(widget.searchtext,widget.filter),
                  )
                ],
              ),
            ),
              floatingActionButton: buildSpeedDial()
          ),
        )
    );
  }
}
