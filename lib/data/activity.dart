class Activity{
  String id;
  String title;
  String desc;
  String type;
  List<String> entities;
  DateTime startDate;
  DateTime finalDate;


  Activity(this.id, this.title, this.desc, this.type, this.entities, this.startDate, this.finalDate);

  String presentEntities(){
    if (entities!=null){
      String text="";
      for (var i=0; i<entities.length; i++) {
        text=text+entities[i]+"\n";
      }
      return text.substring(0,text.length-1);
    }
    else return "No hi ha entitats assignades";

  }


}