class Activity{
  String id;
  String title;
  String desc;
  String type;
  List<String> entities;
  DateTime startDate;
  DateTime finalDate;
  bool visible;

  Activity(this.id, this.title, this.desc, this.type, this.entities, this.startDate, this.finalDate,this.visible);
}