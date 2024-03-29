import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pleek/models/plantList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'models/plant.dart';
import 'plantListWidget.dart';
import 'createEntry.dart';
import 'package:pleek/models/client.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantList()),
        Provider(create: (context) => AWClient()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'RobotoSerif'),
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
  void _createNewPlant(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateEntry()),
    );
    try {
      Provider.of<PlantList>(context, listen: false).addPlant(result);

      AWClient awClient = Provider.of<AWClient>(context, listen: false);

      Client tmpClient = Client()
          .setEndpoint(
              'https://test.digiappwrite.webtron.io/v1') // Your Appwrite Endpoint
          .setProject('635a855adec12706d793') // Your project ID
          .setSelfSigned(
              status:
                  true); // For self signed certificates, only use for development



      Map<String, dynamic> data = {"name": "Pilbert"};

      Future createSession = awClient.account.createEmailSession(
          email: 'test@test.de', password: 'testtest');

      createSession.then((response) {
        print("response");
        print(response);

        Future createDoc = awClient.databases.createDocument(
          databaseId: '635a85a86ef8cfc36a76',
          collectionId: '635a864bc5cd05f22061',
          documentId: 'unique()',
          data: {
            'name':'Blirgo',
            'age':'2'
          },
        );
        createDoc.then((response) {
          print(response);
        }).catchError((error) {
          print(error.response);
        });



        Future listDocs = awClient.databases.listDocuments(
            databaseId: '635a85a86ef8cfc36a76',
            collectionId: '635a864bc5cd05f22061');
        listDocs.then((response) {
          print("Docs response");
          print(response.total);
        }).catchError((error) {
          print("Docs error.response");
          print(error);
        });



      }).catchError((error) {
        print("error.response");
        print(error);
      });
    } catch (e) {
      print(e);
    }
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
          content: Text("Auf ein kurzes aber glücklichs Leben!")));
  }

  @override
  void initState() {
    //_loadPlants();
    Provider.of<PlantList>(context, listen: false).loadPlants();
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
            children: const [PlantListWidget()],
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
//checkedTODO REFACTOR CODE!!!
//TODO Zuordnung zu den Töpfe herstellen.
//TODO IDEA:  QR-Code Pro Pflanze um sie zuordnen zu können.
//TODO create water Modal
//TODO add PopMenu Again, Buttons: 1. Open change Modal 2. open water Modal 3. Maybe delete 4.Maybe zu Blütephase
//TODO waterPlant: easier Number input
//TODO Accounts Lol
