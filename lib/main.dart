import 'package:flutter/material.dart';

import 'plantList.dart';
import 'createEntry.dart';
void main() {
  runApp(const MyApp());
}

class Plant {
  String name;
  DateTime dayPlanted;

  Plant({required this.name, required this.dayPlanted});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pleek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Plant> plants = [];

  void _createNewPlant(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateEntry()),
    );
    _addPlant(result);
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text("Eintrag wurde erstellt!")));
  }

  void _addPlant(String name) {
    Plant plant = Plant(name: name, dayPlanted: DateTime.now());
    plant.toString();
    setState(() {

      plants.add(plant);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.greenAccent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.green.shade800,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 70, 0, 150),
          padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
          color: Colors.green.shade700,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [PlantList(plants: plants)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => {
          _createNewPlant(context)
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.greenAccent,
        hoverColor: Colors.green.shade500,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//TODO Zuordnung zu den Töpfe herstellen.
//TODO IDEA:  QR-Code Pro Pflanze um sie zuordnen zu können.