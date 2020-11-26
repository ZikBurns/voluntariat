import 'package:flutter/material.dart';
import 'package:flutter_firestore/adminscreens/details/admin_details.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/services/activity_service.dart';

class AdminHomeListTile extends StatefulWidget {
  final Activity activity;
  AdminHomeListTile({this.activity});
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<AdminHomeListTile> {


  passData(Activity activity){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDetailsPage(activity)));
  }

  @override
  Widget build(BuildContext context) {
    if(widget.activity.visible){
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        subtitle: Column(
          children: [
            Container(
              child: Row(
                children:<Widget> [
                  Expanded(
                      child: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,)
                  ),
                  IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: (){
                      widget.activity.visible=false;
                      ActivityService().updateActivity(widget.activity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.visibility),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Text('L\'activitat ja no es visible'),
                              )
                            ],
                          ),
                        )
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    else{
      return ListTile(
        onTap: (){
          passData(widget.activity);
        },
        title:Text(widget.activity.title,style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        subtitle: Column(
          children: [
            Container(
              child: Row(
                children:<Widget> [
                  Expanded(
                      child: Text(widget.activity.desc, maxLines: 3,overflow: TextOverflow.ellipsis,)
                  ),
                  IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: (){
                      widget.activity.visible=true;
                      ActivityService().updateActivity(widget.activity);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.visibility),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text('L\'activitat ara es visible per tothom'),
                                )
                              ],
                            ),
                          )
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}







