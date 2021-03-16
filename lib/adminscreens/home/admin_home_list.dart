import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/adminscreens/home/admin_home_list_tile.dart';
import 'file:///C:/Users/ZikBu/Desktop/TFG/FlutterProjects/flutter_firestore/lib/commonscreeens/colors/colorizer.dart';


class AdminHomeList extends StatefulWidget {
  String filter;
  AdminHomeList(this.filter);
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
    
    var list_activities = Provider.of<List<Activity>>(context) ?? [];
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    list_activities.sort((a, b) {if(b.prime) return 1; else return -1;});
    if(widget.filter!="") {
      list_activities = list_activities.where((activity) => activity.type==widget.filter).toList();
    }
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
              itemCount: list_activities.length,
              itemBuilder: (context, index) {
                var act = list_activities[index].title.toLowerCase() +
                    list_activities[index].desc.toLowerCase() +
                    list_activities[index].place.toLowerCase() +
                    list_activities[index].schedule.toLowerCase() +
                    list_activities[index].type.toString().toLowerCase();
                if((searchtext==null) ||(searchtext!=null)&&(act.contains(searchtext.toLowerCase()))){
                  return Card(
                      shape: list_activities[index].prime
                          ?new RoundedRectangleBorder(
                          side: new BorderSide(color: Colorizer.typecolor(list_activities[index].type), width: 4.0),
                          borderRadius: BorderRadius.circular(4.0))
                          : new RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.blueGrey[50], width: 0.0),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: AdminHomeListTile(activity: list_activities[index])
                  );
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