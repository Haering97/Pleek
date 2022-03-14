import 'package:flutter/material.dart';
import 'package:pleek/main.dart';

import 'plant.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantList extends StatefulWidget {
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
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        children: widget.plants
            .map((item) => PlantCard(
                  name: item.name,
                  date: item.date,
                  deletePlant: widget.deletePlant,
                  changeName: widget.changeName,
                  changeDate: widget.changeDate,
                ))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final element = widget.plants.removeAt(oldIndex);
            widget.plants.insert(newIndex, element);
          });
        });
  }
}
