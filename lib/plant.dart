import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'changeEntryModal.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key? key,
    required this.name,
    required this.date,
    required this.deletePlant,
    required this.changeName,
    required this.changeDate,
  }) : super(key: key);
  final String name;
  final DateTime date;
  final VoidCallback deletePlant;
  final Function changeName;
  final Function changeDate;

  String calcWeeks() {
    DateTime plantDate = date;
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
    return Container(
      //TODO Use Card() Widget
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
      margin: EdgeInsets.fromLTRB(50, 18, 50, 18),
      color: Colors.green.shade600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: InkWell(
              onLongPress: deletePlant,
              child: Ink(
                child: Icon(Icons.delete),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(8, 2, 8, 8),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 26,
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
              child: changeEntryModal(oldName: name,oldDate: date,changeName: changeName,changeDate: changeDate) ),
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
