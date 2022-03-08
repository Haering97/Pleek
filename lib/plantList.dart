import 'package:flutter/material.dart';
import 'package:pleek/main.dart';

import 'plant.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantList extends StatelessWidget {
  PlantList(
      {Key? key,
      required this.plants,
      required this.deletePlant,
      required this.changeName,
      required this.changeDate})
      : super(key: key);
  final List<Plant> plants;
  final Function deletePlant;
  final Function changeName;
  final Function changeDate;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children: plants
                .map((item) => PlantCard(
                      name: item.name,
                      date: item.date,
                      deletePlant: deletePlant,
                      changeName: changeName,
                      changeDate: changeDate,
                    ))
                .toList()));
  }
}
