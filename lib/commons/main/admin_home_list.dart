import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/commons/commonfunctions.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commons/main/admin_home_list_tile.dart';
import 'package:flutter_firestore/commons/colors/colorizer.dart';
import 'package:flutter_firestore/data/admin.dart'as admin;

class AdminHomeList extends StatefulWidget {
  String filter;
  String filtermode;
  AdminHomeList({@required this.filter,this.filtermode});
  @override
  _State createState() => _State();
}

class _State extends State<AdminHomeList> {
  TextEditingController searchController;
  String searchtext = null;
  void _onSearch() {
    setState(() {
      searchtext = searchController.text;
    });
  }

  void initState() {
    searchController = TextEditingController();
    searchController.text = "";
    searchController.addListener(_onSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Entity> entitylist= Provider.of<List<Entity>>(context) ?? [];
    var list_activities = Provider.of<List<Activity>>(context) ?? [];
    list_activities=CommonFunctions.sortActivityPrimes(list_activities);
    if(admin.isLoggedIn) {
      list_activities = CommonFunctions.applyTypeFilter(list_activities, widget.filter);
    }
    else{
      list_activities=CommonFunctions.applyActivityFilters(list_activities,widget.filter,widget.filtermode);
      list_activities=CommonFunctions.deleteHiddenActivities(list_activities);
    }
    print("HOLAAAAA");
      return Column(
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
                  var act = CommonFunctions.toStringLowerCaseComplete(list_activities[index],entitylist);
                  if((searchtext==null)||(act.contains(searchtext.toLowerCase()))){
                    if (list_activities[index].prime) {
                      print("HOLAAAAA2");
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                        child: Card(
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: Colorizer.typecolor(
                                        list_activities[index].type),
                                    width: 4.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child:AdminHomeListTile(activity: list_activities[index]),
                        ));
                    }
                    else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
                        child: Card(
                            child:AdminHomeListTile(activity: list_activities[index]))
                      );
                    }
                  }
                  else{
                    return Container();
                  }

                }
            ),
          ),
        ],
      );
    }
  }
