import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({Key? key, required this.name, required this.date,required this.deletePlant})
      : super(key: key);
  final String name;
  final String date;
  final VoidCallback deletePlant;

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO Use Card() Widget
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      margin: EdgeInsets.fromLTRB(50, 18, 50, 18),
      color: Colors.green.shade600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
          //TODO Random Icon, use get variable for that
            child: const Icon(Icons.rocket_launch),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Center(
            child: InkWell(
              onLongPress: deletePlant,
              child: Ink(child: Icon(Icons.dehaze),),
            ),
          )
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