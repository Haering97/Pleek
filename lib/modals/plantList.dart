import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'plant.dart';

class PlantList with ChangeNotifier {
  List<Plant> plants = [];

  void addPlant(Plant plant)  {
      print("New Plant in PlanList");
      print(plants);
      plants.add(plant);
      notifyListeners();
  }

}

//TODO vielleicht immer die plant list übergeben und somit alles in einem state haben.