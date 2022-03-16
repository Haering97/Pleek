import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'plant.dart';

class PlantList with ChangeNotifier {
  String name = "Hallo";
  List<Plant> plants = [];

  void addPlant(Plant plant)  {
      plants.add(plant);
      notifyListeners();
  }
  void deletePlant(Plant plant){
    plants.removeWhere((element) => element.name == plant.name);
    notifyListeners();
  }


}

//TODO vielleicht immer die plant list übergeben und somit alles in einem state haben.
//TODO save with sharedPreferences
//TODO dont forget Snackbars
/*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text("Das Arme Ding wurde entfernt!")));*/