import 'package:flutter/material.dart';
import 'package:pleek/main.dart';
import 'package:intl/intl.dart';

import 'plant.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantList extends StatelessWidget {
  PlantList({Key? key,
    required this.plants,
    required this.deletePlant,
    required this.changeName,
    required this.changeDate})
      : super(key: key);
  final List<Plant> plants;
  final Function deletePlant;
  final Function changeName;
  final Function changeDate;



  String calcWeeks(Plant plant) {
    DateTime plantDate = plant.date;
    int daysSince = DateTime
        .now()
        .difference(plantDate)
        .inDays;
    double weeksSince = (daysSince / 7);
    return daysSince.toString() +
        " Tage / " +
        weeksSince.floor().toString() +
        " Wochen";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children: plants
                .map((item) =>
                PlantCard(
                  name: item.name,
                  date: calcWeeks(item),
                  deletePlant: () => deletePlant(item.name),
                  changeName: () => changeName(item.name),
                  changeDate: () => changeDate(context,item.name),
                ))
                .toList()));
  }
}
