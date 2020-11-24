import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/commonscreeens/search_result_list.dart';


class SearchResults extends StatefulWidget {
  final String searchtext;

  SearchResults(this.searchtext);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
        value: ActivityService().activities,
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
                  child: SearchResultList(widget.searchtext),
                )
              ],
            ),
          ),
        )
    );
  }
}
