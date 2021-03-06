class Activity{
  String id;
  String title;
  String desc;
  String type;
  String contact;
  String place;
  String schedule;
  List<String> entities;
  DateTime startDate;
  DateTime finalDate;
  DateTime visibleDate;
  DateTime launchDate;
  int releasedays;
  bool visible;
  bool prime;
  String image;
  String mode;

  Activity(
      this.id,
      this.title,
      this.desc,
      this.type,
      this.contact,
      this.place,
      this.schedule,
      this.entities,
      this.startDate,
      this.finalDate,
      this.visibleDate,
      this.launchDate,
      this.releasedays,
      this.visible,
      this.prime,
      this.image,
      this.mode);
}