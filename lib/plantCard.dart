import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pleek/plant.dart';

import 'plant.dart';
import 'plantPopMenu.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key? key,
    required this.plant,
    required this.deletePlant,
    required this.changeName,
    required this.changeDate,
  }) : super(key: key);
  final Plant plant;
  final Function deletePlant;
  final Function changeName;
  final Function changeDate;

  String calcWeeks() {
    DateTime plantDate = plant.date;
    int daysSince = DateTime.now().difference(plantDate).inDays;
    double weeksSince = (daysSince / 7);
    return daysSince.toString() +
        " Tage / " +
        weeksSince.floor().toString() +
        " Wochen";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO Use Card() Widget
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(11, 10, 11, 15),
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      color: Colors.green.shade600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
              child: ChangeEntryModal(
            oldName: plant.name,
            oldDate: plant.date,
            changeName: changeName,
            changeDate: changeDate,
            deletePlant: () => deletePlant(plant.name),
          )),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                child: Text(
                  plant.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  calcWeeks(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onLongPress: null,
                child: Ink(
                  child: const Icon(Icons.dehaze),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*emo-squint
            emo-sunglasses
            bug
            user-md
            tree
            angellist
            viadeo
            hand_lizard
            flask
            fighter-jet
            ambulance
            rocket
            space-shuttle
            bomb
            poo
            smoking
            user-astronaut
            helicopter
            kiwi_bird
            skull
            ghost*/
