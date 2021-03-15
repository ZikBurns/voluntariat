import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firestore/screens/entities/entities_list_tile.dart';

class EntitiesList extends StatefulWidget {
  @override
  _EntitiesListState createState() => _EntitiesListState();
}

class _EntitiesListState extends State<EntitiesList> {
  TextEditingController searchController = TextEditingController();
  String searchtext = null;
  ScrollController _scrollViewController;

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
    final list_entities = Provider.of<List<Entity>>(context) ?? [];

    return Column(
      //shrinkWrap: true,
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
                      child: EntitiesListTile(entity: list_entities[index]),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ],
    );
  }
}
