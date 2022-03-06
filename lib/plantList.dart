import 'package:flutter/material.dart';
import 'package:pleek/main.dart';
import 'package:intl/intl.dart';

import 'plant.dart';
//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantList extends StatelessWidget {
  const PlantList({Key? key,required this.plants}) : super(key: key);
  final List<Plant> plants;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: plants.map((item) => PlantCard(name: item.name, date: item.dayPlanted)).toList()
      )
    );
  }
}
