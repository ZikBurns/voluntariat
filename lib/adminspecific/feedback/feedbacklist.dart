
import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/feed.dart';
import 'package:flutter_firestore/services/feedback_service.dart';
import 'package:flutter_firestore/utils/strings.dart';
import 'package:provider/provider.dart';

class Feedbacklist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Feed> feedlist= Provider.of<List<Feed>>(context) ?? [];
    print(feedlist.length);
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: feedlist.length,
        itemBuilder: (context, index) {
          print(index);
          return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0,top: 1.0,bottom: 1.0),
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color:Color(0xFFF5F6F9),
                        width: 4.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child:ListTile(
                  tileColor: Color(0xFFF5F6F9),
                  title: Text(feedlist[index].title),
                  subtitle: Text(feedlist[index].desc),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(Strings.activityEraseWarn1),
                              actions: [
                                TextButton(
                                  child: Text(Strings.textCancelar),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(Strings.textEsborrar),
                                  onPressed: () {
                                    FeedbackService fs = FeedbackService();
                                    fs.deleteFeed(feedlist[index]);
                                    Navigator.of(context, rootNavigator: true).pop();
                                  },
                                )
                              ],
                            );

                          });

                    },
                  ),
                  ),
              )
          );

          }
    );
  }
}
