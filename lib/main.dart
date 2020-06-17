import 'package:flutter/material.dart';

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
        return Placeholder();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Hinzufügen",
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            'Guten Tag, Michael!',
            style: TextStyle(
                fontSize: 38.0,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(left: 65.0, top: 3.0),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("MORGEN-ROUTINE: \nPerfekt in den Tag starten!"),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 65.0,
              top: 15.0,
            ),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("TÄGLICHE REFLEXION:\nPositive Stimmung!"),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 65.0,
              top: 18.0,
            ),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("SELBSTVERTRAUEN-BOOST: \nJa, ich schaffe es!"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Level extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text(
            'Guten Tag, Michael!',
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: PercentageWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text("Glückwunsch, du hast Level 5 erreicht!"),
        ),
      ]),
    );
  }
}

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.75,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 10),
                shape: BoxShape.circle),
            width: 250,
            height: 250,
            child: Center(
              child: Text("60 %",
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Abadi',
                    fontWeight: FontWeight.bold,
                  )),
            )),
      ),
    );
  }
}

class HallOfFame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Ich schaffe das",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 7, bottom: 15.0),
          child: Text(
            "Lorem ipsum.....",
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        DayWidget(),
        DayWidget(),
        DayWidget(),
        DayWidget(),
        DayWidget(),
      ]),
    );
  }
}

class DayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "30",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Text("Samstag"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
                Text("1. Lorem ipsum"),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
