import 'package:flutter/material.dart';
import 'package:pleek/modals/plantList.dart';
import 'package:provider/provider.dart';
import 'modals/plant.dart';

import 'plantCard.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantListWidget extends StatefulWidget {
  PlantListWidget(
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
  State<PlantListWidget> createState() => _PlantListWidgetState();
}

class _PlantListWidgetState extends State<PlantListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.greenAccent.withOpacity(0.1),
              shadowColor: Colors.transparent,
            ),
            child: Consumer<PlantList>(
                builder: (context, plantList, child) {
                      return ReorderableListView(
                      children: plantList.plants
                          .map((item) => PlantCard(
                                key: ValueKey(item),
                                plant: item,
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
                      },
                    );}),
            /*child: ReorderableListView(
            children: widget.plants
                .map((item) => PlantCard(
                      key: ValueKey(item),
                      plant: item,
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
            },),*/
          ),
        );
  }
}
