import 'package:flutter/material.dart';

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
  final String date;
  final VoidCallback deletePlant;
  final VoidCallback changeName;
  final VoidCallback changeDate;

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
                  date,
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
            //TODO Random Icon, use get variable for that
            child: PopupMenuButton(
                child: Icon(Icons.dehaze),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Eintrag ändern"),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: Text("Modal"),
                              );
                            });
                      },
                    ),
                    PopupMenuItem(child: Text("Absäbeln"), onTap: deletePlant),
                  ];
                }),
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
