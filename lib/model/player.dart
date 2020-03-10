import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  Player({
    this.id,
    this.name,
    this.team,
    this.type,
    this.salary,
    this.injured,
    this.country,
    this.overseas: false,
    this.key,
  });
  int id;
  String name;
  String team;
  int type; // 1 : batsman, 2: bowler, 3 all-rounder, 4 wicket keeper, 5 all
  int salary;
  bool injured;
  String country;
  bool overseas;
  String key;

  factory Player.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data;
    return Player(
      id: data['id'],
      name: data['name'],
      team: data['teamname'],
      type: data['type'],
      salary: data['salary'],
      injured: data['injured'],
      country: data['country'],
      overseas: data['overseas'],
      key: data['key'],
    );
  }

  String displayName(isCaptain) {
    String finalName;
    if (key.length > 10) {
      if (name.length <= 10) {
        finalName = name;
      } else {
        List names = key.split(new RegExp(r"\s+"));
        String name2 = '';
        names.forEach((name1) {
          name2 += name1 == names.last ? name1 : name1[0] + ' ';
        });
        finalName = name2;
      }
    } else {
      finalName = key;
    }
    return !isCaptain && overseas ? finalName + ' (O)' : finalName;
  }
}
