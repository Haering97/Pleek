import 'package:flutter/material.dart';
import 'package:pleek/main.dart';
import 'package:intl/intl.dart';

import 'plant.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantList extends StatelessWidget {
  const PlantList({Key? key, required this.plants, required this.deletePlant})
      : super(key: key);
  final List<Plant> plants;
  final Function deletePlant;

  String calcWeeks(Plant plant){
    DateTime plantDate = plant.dayPlanted;
    int daysSince = DateTime.now().difference(plantDate).inDays;
    double weeksSince = (daysSince/7);
    return daysSince.toString()+" Tage / "+weeksSince.floor().toString()+" Wochen";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children: plants
                .map((item) => PlantCard(
                      name: item.name,
                      date: calcWeeks(item),
                      deletePlant:() => deletePlant(item.name),
                    ))
                .toList()));
  }
}
