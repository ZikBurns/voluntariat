import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/commonscreeens/colorizer.dart';
import 'package:flutter_firestore/data/activity.dart';
import 'package:flutter_firestore/screens/home/home_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_firestore/screens/details/details_view.dart';


class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {


  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
  BoxDecoration switchIfNoImage(Activity activity){
    if(activity.image==""){
      return BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: darken(Colorizer.typecolor(activity.type),0.4),
      );
    }
    else{
      return BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              image: NetworkImage(activity.image),
              fit: BoxFit.cover
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var listActivities=Provider.of<List<Activity>>(context) ?? [];
    List<Activity> primelist = listActivities.where((activity) => activity.prime==true).toList();
    listActivities.sort((a,b)=>b.launchDate.millisecondsSinceEpoch.compareTo(a.launchDate.millisecondsSinceEpoch));



    return Container(
      child: ListView(
        children:[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.all(8.0),
              child: Text("Activitats Destacades:",
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold
                ),
              ),

            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 360.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: primelist.map((activity)=>
            InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DetailsPage(activity)));
              },
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: switchIfNoImage(activity),
                      alignment: Alignment.center,
                      /*child: Image.network(
                        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),*/
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(activity.title,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0),)),
                  ],
                ),
              ),
            )
            ).toList(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.all(8.0),
              child: Text("Novetats:",
                style: TextStyle(
                    fontSize:20,
                    fontWeight: FontWeight.bold
                ),
              ),

            ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listActivities.length,
              itemBuilder: (context,index){
                var now= new DateTime.now();
                bool expired= listActivities[index].visibleDate.isBefore(now);
                var duration = new Duration(days : listActivities[index].releasedays);
                var checknewdate= listActivities[index].launchDate.add(duration);
                bool notnew= checknewdate.isBefore(now);

                if((listActivities[index].visible)&&(!expired)&&(listActivities[index].prime)&&(!notnew)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                        shape: new RoundedRectangleBorder(
                            side: new BorderSide(color: Colorizer.typecolor(listActivities[index].type), width: 4.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: HomeListTile(activity: listActivities[index])
                    ),
                  );
                }
                else if((listActivities[index].visible)&&(!expired)&&(!listActivities[index].prime)&&(!notnew)){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(child: HomeListTile(activity: listActivities[index])),
                  );
                }
                else return Container();
              }
          )
        ]

      ),
    );
  }
}
