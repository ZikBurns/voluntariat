

import 'package:flutter/material.dart';
import 'package:flutter_firestore/data/entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialNetworks extends StatelessWidget {
  Entity entity;
  SocialNetworks(this.entity);


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            entity.facebook==""?Container():
            IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook),
                iconSize: 40,
                onPressed: () async {
                  print("Pressed");
                  await canLaunch(entity.facebook) ? await launch(entity.facebook) : throw 'Could not launch '+entity.facebook;

                }
            ),
            entity.twitter==""?Container():
            IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter),
                iconSize: 40,
                onPressed: () async {
                  print("Pressed");
                  await canLaunch(entity.twitter) ? await launch(entity.twitter) : throw 'Could not launch '+entity.twitter;

                }
            ),
            entity.website==""?Container():
            IconButton(
                icon: FaIcon(FontAwesomeIcons.globe),
                iconSize: 40,
                onPressed: () async {
                  print("Pressed");
                  await canLaunch(entity.website) ? await launch(entity.website) : throw 'Could not launch '+entity.website;

                }
            ),
            entity.instagram==""?Container():
            IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                iconSize: 40,
                onPressed: () async {
                  print("Pressed");
                  await canLaunch(entity.instagram) ? await launch(entity.instagram) : throw 'Could not launch '+entity.instagram;
                }
            ),
            entity.maps==""?Container():
            IconButton(
                icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                iconSize: 40,
                onPressed: () async {
                  print("Pressed");
                  await canLaunch(entity.maps) ? await launch(entity.maps) : throw 'Could not launch '+entity.maps;
                }
            ),
          ],
        )
    );
  }
}
