import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';

class SearchResultList extends StatefulWidget {
  final String searchtext;

  SearchResultList(this.searchtext);

  @override
  _State createState() => _State();
}

class _State extends State<SearchResultList> {

  @override
  Widget build(BuildContext context) {
    print(widget.searchtext);
    var list_activities=Provider.of<List<Activity>>(context) ?? [];
    print(list_activities);
    List<Activity> _resultsList=null;

    if((widget.searchtext!=null)&&(widget.searchtext != "")) {
      _resultsList=[];
      int i=0;
      for(var activity in list_activities){
        print(i);
        print(activity.title);
        var title = activity.title.toLowerCase();
        var desc =activity.desc.toLowerCase();
        if(title.contains(widget.searchtext.toLowerCase())) {
          _resultsList.add(activity);
        } else if (desc.contains(widget.searchtext.toLowerCase())) {
          _resultsList.add(activity);
        }
      }
      list_activities=_resultsList;
    }
    return ListView.builder(
        itemCount: list_activities.length,
        itemBuilder: (context,index){
          if(list_activities[index].visible){
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: HomeListTile(activity: list_activities[index]),
            );
          }
          else return Container();
        }
    );


  }
}
