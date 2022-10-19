import 'package:flutter/material.dart';
import 'package:pleek/models/plantList.dart';
import 'package:provider/provider.dart';
import 'models/plant.dart';

import 'plantCard.dart';

//TODO das ganze Widget wahrscheinlich komplett sparen
class PlantListWidget extends StatefulWidget {
  const PlantListWidget(
      {Key? key})
      : super(key: key);

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
                              ))
                          .toList(),

                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final element = plantList.plants.removeAt(oldIndex);
                          plantList.plants.insert(newIndex, element);
                        });
                      },
                    );}),
          ),
        );
  }
}
