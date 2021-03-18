

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Qui som?"),
    ),
      body: Container(
      color: Colors.black12,
      child: Column(
        children: [
        Flexible(
        child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListTile(
                  title: Text("Qui ha fet aquesta app?",style: Theme.of(context).textTheme.headline5),
                  subtitle: SelectableText("Aquest es un projecte de colaboracio entre el ajuntament de Tortosa i la Universitat Rovira i Virgili bla bla bla...")
              ),
              Divider(thickness:2,color: Colors.amberAccent,indent: 20,endIndent:20),

            ]
        ),
        )
      ],
      ),
      )
    );
  }
}
