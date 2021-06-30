import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_daily_win/new_camera_entry.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'greeting.dart';
import 'hall_of_fame.dart';
import 'level.dart';
import 'lockscreen.dart';
import 'new_entry.dart';
import 'profil.dart';
import 'screenlocker.dart';
import 'onboarding.dart';
import 'speed_dial/flutter_speed_dial.dart';

void main() async {
  runApp(ProvidersApp());
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> initializeNotifications(BuildContext context) async {
  if (flutterLocalNotificationsPlugin != null ||
      !context.read<DataModel>().dailyNotificationsEnabled) return;

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (string) async {
      // remove the screen locker,
      // since it would be below the NewSuccess route
      context.findAncestorStateOfType<ScreenlockerState>().popLockscreen();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MorningRoutine()),
      );

      // lock the screen again
      context.findAncestorStateOfType<ScreenlockerState>().tryUnlock();
    },
  );
}

class ProvidersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => DataModel()..load()),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ThemeModel>();
    return MaterialApp(
      theme: model.theme,
      home: Screenlocker(
        child: MaterialApp(
          title: "My Daily Win!",
          theme: ThemeData(
            brightness: model.theme.brightness,
          ),
          home: MyHomePage(),
        ),
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
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showingDialog = false;

  Widget currentScreen(DataModel model) {
    switch (model.selectedScreen) {
      case 0:
        return Greeting(
          switchToMutmacher: () {
            model.selectedScreen = 2;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = context.read<DataModel>();
    if (showingDialog || model.loading) {
      return;
    }
    if (model.name == null) {
      showingDialog = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FirstImpression(),
          ),
        );
      });
    } else {
      // onboarding will initialize notifcations
      initializeNotifications(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState:
          model.loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Scaffold(
        key: ValueKey(1),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      secondChild: Scaffold(
        key: ValueKey(2),
        body: currentScreen(model),
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
          currentIndex: model.selectedScreen,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            model.selectedScreen = index;
          },
        ),
        floatingActionButton: SpeedDialAdd(
          onEntered: () {
            if (mounted) setState(() {});
          },
        ),
      ),
    );
  }
}

class SpeedDialAdd extends StatelessWidget {
  final VoidCallback onEntered;

  const SpeedDialAdd({
    Key key,
    this.onEntered,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Theme.of(context).scaffoldBackgroundColor,
      childOnFold: Icon(Icons.add, key: ValueKey("add")),
      childOnUnfold: Icon(Icons.close, key: ValueKey("close")),
      children: [
        SpeedDialChild(
            child: Icon(Icons.wb_sunny),
            label: "Erfolgsroutine starten",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MorningRoutine()),
              );
              onEntered();
            }),
        SpeedDialChild(
            child: Icon(Icons.tag_faces),
            label: "Dankbarkeitsnotiz",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => NewGrateful()),
              );
              onEntered();
            }),
        SpeedDialChild(
            child: Icon(Icons.grade),
            label: "Erfolg",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => NewSuccess()),
              );
              onEntered();
            }),
        SpeedDialChild(
            child: Icon(Icons.camera_alt),
            label: "Kameranotiz",
            labelStyle: TextStyle(color: Colors.black),
            onTap: () async {
              final imageEntry = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => NewCameraEntry()),
              );
              if (imageEntry != null) {
                context
                    .read<DataModel>()
                    .addImage(imageEntry.item1, imageEntry.item2);
              }
              onEntered();
            }),
      ],
    );
  }
}

Future<void> showNameDialog(BuildContext context) {
  return showDialog(
    useRootNavigator: false,
    context: context,
    builder: (_) => NameDialog(),
  );
}

class NameDialog extends StatefulWidget {
  @override
  _NameDialogState createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: context.read<DataModel>().name);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void finish() {
    context.read<DataModel>().name = _controller.text;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Hi! Wie heißt du?"),
      content: TextField(
        controller: _controller,
        onChanged: (_) {
          setState(() {});
        },
        onEditingComplete: finish,
      ),
      actions: [
        FlatButton(
          child: Text("Abbrechen"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Speichern"),
          onPressed: _controller.text.isNotEmpty ? finish : null,
        ),
      ],
    );
  }
}
