import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'plant.dart';

class PlantList with ChangeNotifier {
  String listName = "Erste Liste";
  List<Plant> plants = [];

  void addPlant(Plant plant) {
    plants.add(plant);
    savePlants();
    notifyListeners();
  }

  void deletePlant(Plant plant) {
    plants.removeWhere((element) => element.name == plant.name);
    savePlants();
    notifyListeners();
  }

  void changePlantName(Plant plant, String newName) {
    plants.forEach((element) {
      if (element.name == plant.name) {
        element.name = newName;
      }
    });
    savePlants();
    notifyListeners();
  }

  void changePlantDate(Plant plant, DateTime newDate) {
    plants.forEach((element) {
      if (element.name == plant.name) {
        element.date = newDate;
      }
    });
    savePlants();
    notifyListeners();
  }

  Future savePlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = encode(plants);
    prefs.setString('plants_key', encodedData);
  }

  static Map<String, dynamic> toMap(Plant plant) =>
      {
        'name': plant.name,
        'dayPlanted': DateFormat("dd.MM.yy").format(plant.date)
      };

  static String encode(List<Plant> plants) =>
      json.encode(
        plants
            .map<Map<String, dynamic>>((plant) => toMap(plant))
            .toList(),
      );


  Future loadPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String? plantsString = prefs.getString('plants_key');
    //print(plantsString);
    final List<Plant> decodedList = Plant.decode(plantsString!);

    plants = decodedList;
    notifyListeners();
  }

  static List<Plant> decode(String plants) =>
      (json.decode(plants) as List<dynamic>)
          .map<Plant>((item) => fromJson(item))
          .toList();

  static fromJson(Map<String, dynamic> jsonData) {
    return Plant(
        name: jsonData['name'],
        date: DateFormat("dd.MM.yy").parse(jsonData['dayPlanted']));
  }


}

//TODO vielleicht immer die plant list übergeben und somit alles in einem state haben.
//TODO save with sharedPreferences
//TODO save to shared, maybe consumer. but no
//TODO dont forget Snackbars
/*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text("Das Arme Ding wurde entfernt!")));*/
