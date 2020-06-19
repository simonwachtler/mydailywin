import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'greeting.dart';
import 'hall_of_fame.dart';
import 'level.dart';
import 'profil.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
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
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedScreen = 0;

  Widget currentScreen(int index) {
    switch (index) {
      case 0:
        return Greeting();
      case 1:
        return Level();
      case 2:
        return HallOfFame();
      default:
        return Profil();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen(selectedScreen),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text("Startseite"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.show_chart,
            ),
            title: Text("Level"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grade,
            ),
            title: Text("Mutmacher"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text("Profil"),
          ),
        ],
        currentIndex: selectedScreen,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
      ),
      floatingActionButton: SpeedDialAdd(),
    );
  }
}

class SpeedDialAdd extends StatefulWidget {
  const SpeedDialAdd({
    Key key,
  }) : super(key: key);

  @override
  _SpeedDialAddState createState() => _SpeedDialAddState();
}

class _SpeedDialAddState extends State<SpeedDialAdd> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    // TODO: Better icons
    return SpeedDial(
      child: Icon(isExpanded ? Icons.close : Icons.add),
      children: [
        SpeedDialChild(
          child: Icon(Icons.wb_sunny),
          label: "Start in den Tag",
        ),
        SpeedDialChild(
          child: Icon(Icons.tag_faces),
          label: "Dankbarkeitsnotiz",
        ),
        SpeedDialChild(
          child: Icon(Icons.grade),
          label: "Erfolg",
        ),
      ],
      onOpen: () {
        setState(() {
          isExpanded = true;
        });
      },
      onClose: () {
        setState(() {
          isExpanded = false;
        });
      },
    );
  }
}
