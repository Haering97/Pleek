import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pleek/models/plantList.dart';
import 'package:provider/provider.dart';

import 'models/plant.dart';

class ModalPopper extends StatefulWidget {
  const ModalPopper({
    required this.plant,
    Key? key,
  }) : super(key: key);
  final Plant plant;
  @override
  State<ModalPopper> createState() => _ModalPopperState();
}

class _ModalPopperState extends State<ModalPopper> {
  final textController = TextEditingController();
  final numberController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool dateChanged = false;
  bool nameChanged = false;
  bool notesChanged = false;

  selectDateAndSave(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: widget.plant.date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        dateChanged = true;
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.wysiwyg),
        onSelected: (newValue) {
          //used if instead of switch just so ide can collapse the whole modal
          if (newValue == 0) {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.green.shade700,
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(40, 5, 40, 50),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Eintrag ändern",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              //TODO alten Namen dem Widget übergeben
                              onChanged: (value) => nameChanged = true,
                              textAlign: TextAlign.center,
                              controller: textController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 2),
                                  ),
                                  hintText: widget.plant.name,
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 20)),
                            ),
                            TextField(
                              //TODO alten Namen dem Widget übergeben
                              onChanged: (value) => notesChanged = true,
                              textAlign: TextAlign.center,
                              controller: textController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 2),
                                  ),
                                  hintText: widget.plant.notes,
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 20)),
                            ),
                            ElevatedButton(
                              onPressed: () => selectDateAndSave(context),
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: const Text("Anderes Datum wählen",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14))),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.greenAccent;
                                    }
                                    return Colors.green.shade900;
                                  },
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<PlantList>(context,listen: false).deletePlant(widget.plant);
                                //widget.deletePlant();
                                Navigator.pop(context);
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: const Text("Pflanze Absäbeln",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14))),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.greenAccent;
                                    }
                                    return Colors.green.shade900;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Navigator.pop(context, textController.text),
                                child: Container(
                                    //margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: const Text("Speichern",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14))),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.greenAccent;
                                      }
                                      return Colors.green.shade900;
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                  );
                }).then((value) {
              setState(() {
                if (notesChanged) {
                  //widget.changeDate(widget.plant.name, selectedDate);
                  //widget.plant.date = selectedDate;
                  Provider.of<PlantList>(context,listen: false).changePlantDate(widget.plant, value);
                }
                if (dateChanged) {
                  //widget.changeDate(widget.plant.name, selectedDate);
                  //widget.plant.date = selectedDate;
                  Provider.of<PlantList>(context,listen: false).changePlantDate(widget.plant, selectedDate);
                }
                if (nameChanged) {
                  //widget.changeName(widget.plant.name, value);
                  Provider.of<PlantList>(context,listen: false).changePlantName(widget.plant, value);
                }
                textController.clear();
                dateChanged = false;
                nameChanged = false;
              });
            });
          } //changeEntryModal
          else if (newValue == 1) {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.green.shade700,
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(40, 5, 40, 50),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Pflanze gießen",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              //TODO alten Namen dem Widget übergeben
                              onChanged: (value) => nameChanged = true,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              textAlign: TextAlign.center,
                              controller: numberController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 2),
                                  ),
                                  hintText: "Wie viele Liter",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.8),
                                      fontSize: 20)),
                            ),
                            const Text("Tage seit dem letzen Gießen",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14)),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Navigator.pop(context, textController.text),
                                child: Container(
                                    //margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: const Text("Speichern",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14))),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.greenAccent;
                                      }
                                      return Colors.green.shade900;
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                  );
                }).then((value) {
              setState(() {
                if (dateChanged) {

                }
                numberController.clear();
                dateChanged = false;
                nameChanged = false;
              });
            });
          } //waterPlantModal
          else if (newValue == 2) {} //sendToFlower
        },
        itemBuilder: (context) => [
              const PopupMenuItem(child: Text("Mehr..."), value: 0),
              const PopupMenuItem(child: Text("Pflanze Gießen"), value: 1),
              const PopupMenuItem(
                child: Text("In die Blüte schicken"),
                value: 2,
              )
            ]);
  }
}
