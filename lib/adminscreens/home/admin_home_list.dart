import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_home_list_tile.dart';


class AdminHomeList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AdminHomeList> {




  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Activities").snapshots(),
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> querySnapshot){
        if(querySnapshot.hasError) return Text("Error");
        if(querySnapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{

          var list=querySnapshot.data.docs;

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: AdminHomeListTile(snapshot: list[index]),
                  ),
                );
              }
          );
        }

      },

    );
  }
}
