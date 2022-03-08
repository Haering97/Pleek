import 'package:flutter/material.dart';

class changeEntryModal extends StatefulWidget {
  const changeEntryModal({
    required this.changeName,
    required this.changeDate,
    required this.oldName,
    required this.oldDate,
    Key? key,
  }) : super(key: key);
  final Function changeName;
  final Function changeDate;
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
        icon: Icon(
          Icons.wysiwyg,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(children: [
                      const Text(
                        "Eintrag ändern",
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        //TODO alten Namen dem Widget übergeben
                        onChanged: (value) => nameChanged=true,
                        textAlign: TextAlign.center,
                        controller: textController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 2),
                            ),
                            hintText: 'Gib dem Baby einen Namen',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 20)),
                      ),
                      ElevatedButton(
                        onPressed: () => selectDateAndSave(context),
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                            child: const Text("Anderes Datum wählen",
                                style: TextStyle(fontSize: 15))),
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
                          onPressed: () =>
                              Navigator.pop(context, textController.text),
                          child: Text("Speichern"))
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
              };
            });
          });
        });
  }
}
