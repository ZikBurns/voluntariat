import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class HomeList extends StatefulWidget {
  String filter;
  String filtermode;
  HomeList(this.filter, this.filtermode);

  @override
  _State createState() => _State();
}

class _State extends State<HomeList> {
  TextEditingController searchController;
  String searchtext = null;
  List<Entity> entitylist;

  void initState() {
    searchController = TextEditingController();
    searchController.text = "";
    searchController.addListener(_onSearch);
    super.initState();
  }

  void _onSearch() {
    setState(() {
      searchtext = searchController.text;
    });
  }

  List<String> IDsToNames(List<String> idlist) {
    List<String> namelist = [];
    for (var i = 0; i < entitylist.length; i++) {
      for (var j = 0; j < idlist.length; j++) {
        if (idlist[j] == entitylist[i].id) namelist.add(entitylist[i].name);
      }
    }
    return namelist;
  }

  @override
  Widget build(BuildContext context) {
    var list_activities = Provider.of<List<Activity>>(context) ?? [];
    entitylist = Provider.of<List<Entity>>(context) ?? [];
    list_activities.sort((a, b) {
      if (b.prime)
        return 1;
      else
        return -1;
    });
    list_activities.sort((a, b) {
      if (b.prime)
        return 1;
      else
        return -1;
    });
    if (widget.filter != "") {
      list_activities = list_activities
          .where((activity) => activity.type == widget.filter)
          .toList();
    }
    if (widget.filtermode != "") {
      list_activities = list_activities
          .where((activity) => activity.mode == widget.filtermode)
          .toList();
    }

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueGrey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F6F9),
                    hintText: 'Busca',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.blueGrey,
                      onPressed: () {
                        // Removes any filtering effects
                        searchController.text = '';
                        setState(() {
                          searchtext = null;
                        });
                        FocusScope.of(context).unfocus();
                      },
                    )),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: list_activities.length,
              itemBuilder: (context, index) {
                var now = new DateTime.now();
                bool expired = list_activities[index].visibleDate.isBefore(now);
                List<String> entitiesinactivity =
                    IDsToNames(list_activities[index].entities);
                var act = list_activities[index].title.toLowerCase() +
                    list_activities[index].desc.toLowerCase() +
                    list_activities[index].place.toLowerCase() +
                    list_activities[index].schedule.toLowerCase() +
                    entitiesinactivity.toString().toLowerCase() +
                    list_activities[index].type.toString().toLowerCase();

                if (searchtext == null) {
                  if ((list_activities[index].visible) &&
                      (!expired) &&
                      (list_activities[index].prime)) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                      child: Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colorizer.typecolor(
                                      list_activities[index].type),
                                  width: 4.0),
                              borderRadius: BorderRadius.circular(4.0)),
                          child:
                              HomeListTile(activity: list_activities[index])),
                    );
                  } else if ((list_activities[index].visible) &&
                      (!expired) &&
                      (!list_activities[index].prime)) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                      child: Card(
                          child:
                              HomeListTile(activity: list_activities[index])),
                    );
                  } else
                    return Container();
                } else {
                  if ((list_activities[index].visible) &&
                      (!expired) &&
                      (list_activities[index].prime) &&
                      (act.contains(searchtext.toLowerCase()))) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                      child: Card(
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colorizer.typecolor(
                                      list_activities[index].type),
                                  width: 4.0),
                              borderRadius: BorderRadius.circular(4.0)),
                          child:
                              HomeListTile(activity: list_activities[index])),
                    );
                  } else if ((list_activities[index].visible) &&
                      (!expired) &&
                      (!list_activities[index].prime) &&
                      (act.contains(searchtext.toLowerCase()))) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                      child: Card(
                          child:
                              HomeListTile(activity: list_activities[index])),
                    );
                  } else
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
