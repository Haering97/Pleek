import 'package:flutter/material.dart';

class changeEntryModal extends StatefulWidget {
  const changeEntryModal({
    required this.changeName,
    required this.changeDate,
    required this.deletePlant,
    required this.oldName,
    required this.oldDate,
    Key? key,
  }) : super(key: key);
  final Function changeName;
  final Function changeDate;
  final VoidCallback deletePlant;
  final String oldName;
  final DateTime oldDate;

  @override
  State<changeEntryModal> createState() => _changeEntryModalState();
}

class _changeEntryModalState extends State<changeEntryModal> {
  final textController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool dateChanged = false;
  bool nameChanged = false;

  selectDateAndSave(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: widget.oldDate,
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
    return IconButton(
        alignment: Alignment.center,
        icon: Icon(
          Icons.wysiwyg,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.green.shade700,
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 40, 50),
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
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 2),
                                ),
                                hintText: widget.oldName,
                                hintStyle: TextStyle(
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
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.greenAccent;
                                  }
                                  return Colors.green.shade900;
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.deletePlant();
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: const Text("Element löschen",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14))),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
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
                                    if (states.contains(MaterialState.pressed)) {
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
                widget.changeDate(widget.oldName, selectedDate);
              }
              if (nameChanged) {
                widget.changeName(widget.oldName, value);
              }
              textController.clear();
              dateChanged = false;
              nameChanged = false;
            });
          });
        });
  }
}
