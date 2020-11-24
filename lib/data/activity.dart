class Activity{
  String title;
  String desc;
  String id;
  List<String> entities;

  Activity(String id,String title, String desc,List<String> entities){
    print('hola');
    this.id=id;
    this.title=title;
    this.desc=desc;
    print(entities??'0');
    this.entities=entities;
  }

  String presentEntities(){
    if (entities!=null){
      String text="";
      for (var i=0; i<entities.length; i++) {
        text=text+entities[i]+"\n";
      }
      return text;
    }
    else return "No hi ha entitats assignades";

  }


}