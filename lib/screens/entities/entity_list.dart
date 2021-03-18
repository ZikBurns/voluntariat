import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/entities/entity_list_tile.dart';
import 'package:flutter_firestore/services/activity_service.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/data/admin.dart' as admin;

class EntitiesList extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<EntitiesList> {
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollViewController;
  String searchtext = null;

  void initState() {
    searchController = TextEditingController();
    searchController.text = "";
    searchController.addListener(_onSearch);
    _scrollViewController = new ScrollController();
    super.initState();
  }

  void _onSearch() {
    setState(() {
      searchtext = searchController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    var list_entities=Provider.of<List<Entity>>(context) ?? [];



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
          child: StreamProvider<List<Activity>>.value(
            value: ActivityService().activities,
            child: StreamProvider<List<Entity>>.value(
              value: EntityService().entities,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: list_entities.length,
                  itemBuilder: (context, index) {
                  var ent = list_entities[index].name.toLowerCase() +
                  list_entities[index].desc.toLowerCase();
                  if ((searchtext == null) ||
                  (searchtext != null) &&
                  (ent.contains(searchtext.toLowerCase()))) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        child: EntityListTile(list_entities[index]),
                      ),
                    );
                  }
                  else return Container();
                  }
              ),
            ),
              )
          ),
      ],
    );
  }
}
