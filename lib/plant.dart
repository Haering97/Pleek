import 'dart:convert';
import 'package:intl/intl.dart';

class Plant {
  String name;
  DateTime date;

  Plant({required this.name, required this.date});

  factory Plant.fromJson(Map<String, dynamic> jsonData) {
    return Plant(
        name: jsonData['name'],
        date: DateFormat("dd.MM.yy").parse(jsonData['dayPlanted']));
  }

  static Map<String, dynamic> toMap(Plant plant) => {
    'name': plant.name,
    'dayPlanted': DateFormat("dd.MM.yy").format(plant.date)
  };

  static String encode(List<Plant> plants) => json.encode(
    plants
        .map<Map<String, dynamic>>((music) => Plant.toMap(music))
        .toList(),
  );

  static List<Plant> decode(String plants) =>
      (json.decode(plants) as List<dynamic>)
          .map<Plant>((item) => Plant.fromJson(item))
          .toList();
}