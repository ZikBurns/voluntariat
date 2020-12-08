import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:flutter_firestore/screens/details/present_entities.dart';
import 'package:flutter_firestore/services/entity_service.dart';
import 'package:provider/provider.dart';
import '../../data/activity.dart';
import 'package:linkable/linkable.dart';
import 'package:transparent_image/transparent_image.dart';


class DetailsPage extends StatefulWidget {
  Activity activity;
  DetailsPage(this.activity);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

Color typecolor(String type){
  switch(type) {
    case 'Èxit educatiu': {
      return Colors.amber;
    }break;
    case 'Joves': {
      return Colors.red;
    }break;
    case 'Famílies': {
      return Colors.lightBlue;
    }break;
    case 'Igualtat d\'oportunitats': {
      return Colors.green;
    }break;
    case 'Participació comunitària': {
      return Colors.deepOrange;
    }break;
    default: {
      return Colors.white;

    }break;
  }
}

class _DetailsPageState extends State<DetailsPage> {
  Widget primeAppBar(){
    if(widget.activity.prime){
      return AppBar(
        backgroundColor: typecolor(widget.activity.type),
        title: Text(widget.activity.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Es necessiten voluntaris urgentment:"),
                          content: Text("Les activitats destacades tenen el triangle amb exclamació."),
                          actions: <Widget>[
                            TextButton(
                              child: Text('D\'acord'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                        //Navigator.of(context, rootNavigator: true).pop();
                      }
                  );
                },
                child: Icon(
                  Icons.warning_amber_outlined,
                  size: 26.0,
                ),
              )
          ),
        ],
      );
    }
    else{
      return AppBar(
          backgroundColor: typecolor(widget.activity.type),
          title: Text(widget.activity.title)
      );
    }
  }

  Widget build(BuildContext context) {
    return StreamProvider<List<Entity>>.value(
      value: EntityService().entities,
      child: Scaffold(
          appBar:primeAppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: new BoxConstraints(
              //minWidth: 70,
              //minHeight: 70,
              maxWidth: 1000,
            ),
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  (widget.activity.image!="")
                      ? Stack(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          Center(child: FadeInImage.memoryNetwork  (
                            placeholder: kTransparentImage,
                            image:widget.activity.image,
                          ), )
                        ],
                      )
                      : Container(),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  ListTile(
                      title: Text("Descripcio",style: Theme.of(context).textTheme.headline5),
                      subtitle: SelectableText(widget.activity.desc)
                  ),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  PresentEntities(widget.activity),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  ListTile(
                      title: Text("Tipus",style: Theme.of(context).textTheme.headline5),
                      subtitle: SelectableText(widget.activity.type)
                  ),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  ListTile(
                      title: Text("Dates",style: Theme.of(context).textTheme.headline5),
                      subtitle: SelectableText("Data d\'inici: "+widget.activity.startDate.day.toString()+"/"+widget.activity.startDate.month.toString()+"/"+widget.activity.startDate.year.toString()+"\n"+
                          "Data final: "+widget.activity.finalDate.day.toString()+"/"+widget.activity.finalDate.month.toString()+"/"+widget.activity.finalDate.year.toString())
                  ),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  ListTile(
                      title: Text("Lloc",style: Theme.of(context).textTheme.headline5),
                      subtitle: SelectableText(widget.activity.place)
                  ),
                  ListTile(
                      title: Text("Horari",style: Theme.of(context).textTheme.headline5),
                      subtitle: SelectableText(widget.activity.schedule)
                  ),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                  ListTile(
                      title: Text("Contacte",style: Theme.of(context).textTheme.headline5),
                      subtitle: Linkable(
                        text: widget.activity.contact,
                      )
                  ),
                  Divider(thickness:2,color: typecolor(widget.activity.type),indent: 20,endIndent:20),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
