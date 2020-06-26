import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'greeting.dart';
import 'hall_of_fame.dart';
import 'level.dart';
import 'lockscreen.dart';
import 'new_success.dart';
import 'profil.dart';
import 'screenlocker.dart';

Data data = Data([], null, null, true, false);
Future<Data> firstData;

void main() {
  runApp(MyApp());
  firstData = readData();
  firstData.then((value) => data = value);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void initializeNotifications(BuildContext context) async {
  if (flutterLocalNotificationsPlugin != null) return;

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (string) async {
    // remove the screen locker,
    // since it would be below the NewSuccess route
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => NewSuccess(
          type: EntryType.Success,
          morningRoutine: true,
        ),
      ),
      (route) => route.settings.name != screenlockerRouteName,
    );
    // lock the screen again
    context.findAncestorStateOfType<ScreenlockerState>().tryUnlock();
  });
}

final _model = ThemeModel();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModel>(
      create: (_) => _model..init(),
      child: Consumer<ThemeModel>(
        builder: (context, model, child) {
          return MaterialApp(
            title: "Flutter Demo",
            theme: ThemeData(
              fontFamily: "Abadi",
              brightness: model.theme.brightness,
            ),
            home: Screenlocker(
              child: MyHomePage(),
              lockscreenBuilder: (context, onRetry) => LockScreen(
                onRetry: onRetry,
              ),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale("de")],
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedScreen = 0;
  bool showingDialog = false;

  Widget currentScreen(int index) {
    switch (index) {
      case 0:
        return Greeting(
          switchToMutmacher: () {
            setState(() {
              selectedScreen = 2;
            });
          },
        );
      case 1:
        return Level();
      case 2:
        return HallOfFame();
      default:
        return Profil();
    }
  }

  @override
  void initState() {
    firstData.then((data) async {
      if (!showingDialog && data.name == null) {
        showingDialog = true;
        await showNameDialog(context);
      }
      initializeNotifications(context);
      setState(() {});
    });
    super.initState();
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
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
      ),
      floatingActionButton: SpeedDialAdd(
        onEntered: () {
          if (mounted) setState(() {});
        },
      ),
    );
  }
}

class SpeedDialAdd extends StatefulWidget {
  final VoidCallback onEntered;

  const SpeedDialAdd({
    Key key,
    this.onEntered,
  }) : super(key: key);

  @override
  _SpeedDialAddState createState() => _SpeedDialAddState();
}

class _SpeedDialAddState extends State<SpeedDialAdd> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Theme.of(context).scaffoldBackgroundColor,
      child: Icon(isExpanded ? Icons.close : Icons.add),
      children: [
        SpeedDialChild(
            child: Icon(Icons.wb_sunny),
            label: "Start in den Tag",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NewSuccess(
                    type: EntryType.Success,
                    morningRoutine: true,
                  ),
                ),
              );

              widget.onEntered();
            }),
        SpeedDialChild(
            child: Icon(Icons.tag_faces),
            label: "Dankbarkeitsnotiz",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewSuccess(type: EntryType.Grateful)));
              widget.onEntered();
            }),
        SpeedDialChild(
            child: Icon(Icons.grade),
            label: "Erfolg",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => NewSuccess(
                        type: EntryType.Success,
                      )));
              widget.onEntered();
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

Future<void> showNameDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => NameDialog(),
    barrierDismissible: false,
  );
}

class NameDialog extends StatefulWidget {
  @override
  _NameDialogState createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hi! Wie heißt du?"),
      content: TextField(
        onChanged: (n) => setState(() => setData(() => data.name = n)),
      ),
      actions: [
        FlatButton(
          child: Text("Jetzt loslegen!"),
          onPressed: data.name?.isNotEmpty == true
              ? () => Navigator.of(context).pop()
              : null,
        ),
      ],
    );
  }
}
