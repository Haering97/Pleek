import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'plant.dart';

import 'plantList.dart';
import 'createEntry.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoSerif'
      ),
      home: const MyHomePage(title: 'Pleek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  //Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plant> plants = [
    //Plant(name: "Dummy", dayPlanted: DateTime(2022,2,3))
  ];

  void _createNewPlant(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateEntry()),
    );
    try {
      _addPlant(result);
    } catch (e) {
      print(e);
    }
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
          content: Text("Auf ein kurzes aber glücklichs Leben!")));
  }

  void _addPlant(Plant plant) async {
    setState(() {
      plants.add(plant);
    });
    _savePlants();
  }

  void deletePlant(String name) {
    setState(() {
      plants.removeWhere((element) => element.name == name);
    });
    _savePlants();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text("Das Arme Ding wurde entfernt!")));
  }

  void changeName(String oldName,String newName) {
    print("oldName: "+oldName);
    setState(() {
      plants.forEach((element) {
        if (element.name == oldName) {
          element.name = newName;
        }
      });
    });
    _savePlants();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text("Das Pflänzchen wurde umbenannt!")));
  }

  void changeDate(String name, DateTime newDate) {
      setState(() {
        plants.forEach((element) {
          if (element.name == name) {
            element.date = newDate;
          }
        });
      });
    _savePlants();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          const SnackBar(content: Text("Das Datum wurde geändert!")));
  }

  Future _savePlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = Plant.encode(plants);
    prefs.setString('plants_key', encodedData);
  }

  Future _loadPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String? plantsString = prefs.getString('plants_key');
    print(plantsString);
    final List<Plant> decodedList = Plant.decode(plantsString!);
    setState(() {
      plants = decodedList;
    });
  }

  @override
  void initState() {
    _loadPlants();
    super.initState();
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
          margin: const EdgeInsets.fromLTRB(0, 70, 0, 90),
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          color: Colors.green.shade700,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PlantList(
                plants: plants,
                deletePlant: deletePlant,
                changeName: changeName,
                changeDate: changeDate,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_createNewPlant(context)},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.greenAccent,
        hoverColor: Colors.green.shade500,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//checkedTODO Delete Plant, am liebsten in einem Modal mit infos
//TODO Zuordnung zu den Töpfe herstellen.
//TODO IDEA:  QR-Code Pro Pflanze um sie zuordnen zu können.
//TODO create water Modal
//TODO add PopMenu Again, Buttons: 1. Open change Modal 2. open water Modal 3. Maybe delete 4.Maybe zu Blütephase
//TODO waterPlant: easier Number input