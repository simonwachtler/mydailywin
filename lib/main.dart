import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'greeting.dart';
import 'hall_of_fame.dart';
import 'level.dart';
import 'new_success.dart';
import 'profil.dart';

void main() {
  runApp(MyApp());
}

final _model = ThemeModel();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModel>(
        create: (_) => _model..init(),
        child: Consumer<ThemeModel>(builder: (context, model, child) {
          return MaterialApp(
            title: "Flutter Demo",
            theme: model.theme,
            home: MyHomePage(),
          );
        }));
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewSuccess(
                        type: EntryType.Success,
                        morningRoutine: true,
                      )));
            }),
        SpeedDialChild(
            child: Icon(Icons.tag_faces),
            label: "Dankbarkeitsnotiz",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewSuccess(type: EntryType.Grateful)));
            }),
        SpeedDialChild(
            child: Icon(Icons.grade),
            label: "Erfolg",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewSuccess(
                        type: EntryType.Success,
                      )));
            }),
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
