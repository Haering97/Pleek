import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class CreateEntry extends StatefulWidget {
  const CreateEntry({Key? key}) : super(key: key);

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final textController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  selectDateAndSave(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    Navigator.pop(
        context, Plant(name: textController.text, dayPlanted: selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.greenAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Pleek"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.green.shade800,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 70, 0, 150),
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          color: Colors.green.shade700,
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(flex: 1),
                const Text(
                  "Einen Sämling einpflanzen",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 1),
                TextField(
                  textAlign: TextAlign.center,
                  controller: textController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 2),
                      ),
                      hintText: 'Gib dem Baby einen Namen',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.8), fontSize: 20)),
                ),
                const Spacer(
                  flex: 5,
                ),
                ElevatedButton(
                  onPressed: () => selectDateAndSave(context),
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: const Text("Anderes Datum wählen",
                          style: TextStyle(fontSize: 15))),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.greenAccent;
                        }
                        return Colors.green.shade900;
                      },
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(
                      context,
                      Plant(
                          name: textController.text,
                          dayPlanted: DateTime.now())),
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: const Text("Jetzt Einpflanzen",
                          style: TextStyle(fontSize: 15))),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.greenAccent;
                        }
                        return Colors.green.shade900;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
